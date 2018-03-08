% pca feature for GPR
% combine the feature: sst,mslp,d to one feature and train the kernel
% parameters just for this function

function [u0 u1  consum inter hyp] = reg_mult_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV,epoch,samp,sub_row,sub_col)
resolution = 0.125;
%% some global variables for EC data

region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat)];
filename_ps = strcat(prefix_p,region,'.txt');  %pca data
 
filename_ss = strcat(prefix_s,region,'.mat');   %space data of all variables
hyp = [];consum = []; inter = [];
rmse = [];
% ====================data preprocessing parameters========================
samp_inter = samp;

%% 0)read data and preprocessing the outlier

% space information data
load(filename_ss);
[sxpca,sypca,sxpca_train,sypca_train,sxpca_test,sypca_test] = filedata_pre(filename_ps,samp_inter);
sx=[];sy=[];sx_train=[];sy_train=[];sx_test=[];sy_test=[];

switch(typeV)
    case 1
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,u,samp_inter);
    case 2
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,v,samp_inter);
    case 3 %direction
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,d_mat,samp_inter);
    case 6 %direction
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,s_mat,samp_inter);
   
end


%% tarin by subregion
% delete the unuseful data to release space
clear sxpca_train sypca_train sxpca_test sypca_test sx_train sy_train sx_test sy_test

size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;

row_reg = size_lat/sub_row;    col_reg = size_lon/sub_col; 
regGrid = row_reg*col_reg;
[x,y] = subReg(sx,sy,size_lat,size_lon,sub_row,sub_col);
[xpca,ypca] = subReg(sxpca,sypca,size_lat,size_lon,sub_row,sub_col);

size_reg = size(x,2);

sub_px = {};sub_py = {};sub_ty = {};

for i = 1:size_reg
    subx = x{i}; suby = y{i};
    sub_pcay = ypca{i};
    
    sub_xtrain = subx(1:samp_inter:regGrid,:);
    sub_ytrain = suby(1:samp_inter:regGrid);
    sub_xtest = subx(samp_inter:samp_inter:regGrid,:);
    sub_yest = suby(samp_inter:samp_inter:regGrid);
    
    sub_pcaytrain = sub_pcay(1:samp_inter:regGrid);
    
    
    [predict_temp,hyp_temp,consum_temp,inter_temp] = mpng_pca_prod(epoch,sub_xtrain,sub_pcaytrain,sub_ytrain,sub_xtest);
    %sx_train,sypca_train,sy_train,sx_test)
    
    consum = [consum;consum_temp];
    inter = [inter;inter_temp];
    hyp = [hyp,hyp_temp];
    
    sub_px{i} = sub_xtest;
    sub_py{i} = predict_temp;
    sub_ty{i} = sub_yest;
    
    rmse_temp = getRMSE(sub_yest,predict_temp);
    rmse = [rmse;rmse_temp];
end


%% 3) recomposite the interpolated value with the true value
sub_ipy = {};
for i = 1:size_reg
    suby = y{i};subpy = sub_py{i};
    nSize = size(suby,1);
    index_inter = 1;
    for n = samp_inter:samp_inter:nSize
        suby(n,1) = subpy(index_inter);
        index_inter = index_inter+1;
    end
    sub_ipy{i} = suby;
end

%% end) estimate the result
u1_temp = mapReshape(sub_ipy,size_lat,size_lon,sub_row,sub_col,samp);
u0       =	reshape(sy,[size_lat,size_lon]);
u1       =	u1_temp;
disp('whole region mean rmse')
mean(getRMSE(u0,u1))


function [predict,hyp,consum,inter] = mpng_pca_prod(epoch,sx_train,sypca_train,sy_train,sx_test)
size_hyp_4_p = 15 ; %the size of hyperparameters for multi-scale method of pca feature: multi

size_hyp_4_s = 15 ; %the size of hyperparameters for multi-scale for space data/time data
covfunc4_pca = {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};
covfunc4_s =  {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};

covfunc4 = {'covSum',{covfunc4_s,covfunc4_pca}};
% a£© fit the pressure hyperparameters
tic;
hyp4_p.cov = zeros(1,size_hyp_4_p)';  hyp4_p.lik = log(0.1); likfunc4_p = @likGauss; 
hyp4_p = minimize(hyp4_p,@gp,-epoch,@infGaussLik,[],covfunc4_pca,likfunc4_p,sx_train,sypca_train)

% b£© fit the time hyperparameters
hyp4_s.cov = zeros(1,size_hyp_4_s)';  hyp4_s.lik = log(0.1); likfunc4_s = @likGauss; 
hyp4_s = minimize(hyp4_s,@gp,-epoch,@infGaussLik,[],covfunc4_s,likfunc4_s,sx_train,sy_train);
consum = toc;
hyp4.cov = [hyp4_s.cov;hyp4_p.cov];
hyp4.lik = log(exp(hyp4_p.lik) + exp(hyp4_s.lik)) ;
hyp = hyp4.cov;
likfunc4 = @likGauss;

% c) regression and prediction
tic;
[predict s2_4 fmu_4 fs2_4] = gp(hyp4, @infGaussLik, [], covfunc4, likfunc4,sx_train, sy_train, sx_test);
inter = toc;
