% pca feature for GPR
% combine the feature: sst,mslp,d to one feature and train the kernel
% parameters just for this function

function [u0 u1  consum inter hyp] = reg_mult_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV,epoch,samp)
resolution = 0.125;
%% some global variables for EC data
region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat)];
filename_ps = strcat(prefix_p,region,'.txt');  %pca data
 
filename_ss = strcat(prefix_s,region,'.mat');   %space data of all variables
 
%====================hyperparameters size=========================== 
 % for wind speed interpolation ,the different hyperparameters size of each method
size_hyp_4_p = 15 ; %the size of hyperparameters for multi-scale method of pca feature: multi

size_hyp_4_s = 15 ; %the size of hyperparameters for multi-scale for space data/time data

% ====================data preprocessing parameters========================
samp_inter_s = samp;

%% 0)read data and preprocessing the outlier

% space information data
load(filename_ss);
[sxpca,sypca,sxpca_train,sypca_train,sxpca_test,sypca_test] = filedata_pre(filename_ps,samp_inter_s);
sx=[];sy=[];sx_train=[];sy_train=[];sx_test=[];sy_test=[];

switch(typeV)
    case 1
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,u,samp_inter_s);
    case 2
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,v,samp_inter_s);
    case 3 %direction
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,d_mat,samp_inter_s);
    case 6 %direction
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,s_mat,samp_inter_s);
   
end
% delete the unuseful data to release space
clear sxpca sypca sypca_test  

%% 4) space interpolation for wind speed with other variables:pressure and temp with multi; direction with periodic
 
covfunc4_pca = {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};
covfunc4_s =  {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};

 covfunc4 = {'covSum',{covfunc4_s,covfunc4_pca}};

% 4a£© fit the pressure hyperparameters
tic;
hyp4_p.cov = zeros(1,size_hyp_4_p)';  hyp4_p.lik = log(0.1); likfunc4_p = @likGauss; 
hyp4_p = minimize(hyp4_p,@gp,-epoch,@infGaussLik,[],covfunc4_pca,likfunc4_p,sx_train,sypca_train);

% 4d£© fit the time hyperparameters
hyp4_s.cov = zeros(1,size_hyp_4_s)';  hyp4_s.lik = log(0.1); likfunc4_s = @likGauss; 
hyp4_s = minimize(hyp4_s,@gp,-epoch,@infGaussLik,[],covfunc4_s,likfunc4_s,sx_train,sy_train);
consum = toc;
hyp4.cov = [hyp4_s.cov;hyp4_p.cov];
hyp4.lik = log(exp(hyp4_p.lik) + exp(hyp4_s.lik)) ;

likfunc4 = @likGauss;

% 4e) regression and prediction
tic;
[u1_temp s2_4 fmu_4 fs2_4] = gp(hyp4, @infGaussLik, [], covfunc4, likfunc4,sx_train, sy_train, sx_test);
inter = toc;

hyp = hyp4;
%% end) estimate the result
size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;

u0 = reshape(sy,[size_lat,size_lon]);
u1 = sy;
nSize = size_lat*size_lon;
index_inter = 1;
for n = samp_inter_s:samp_inter_s:nSize
    u1(n,1) = u1_temp(index_inter);
    index_inter = index_inter+1;
end
u1       =	reshape(u1,[size_lat,size_lon]);
