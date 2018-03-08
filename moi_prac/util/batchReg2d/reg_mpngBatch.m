function [u0,u1,consum,inter,hyp] = reg_mpngBatch(file_pre,minlon,minlat,maxlon,maxlat,typeV,epoch,samp,sub_row,sub_col)
resolution = 0.125
%% some global variable
region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat)];
filename = strcat(file_pre,region,'.mat');  %space data of all variables


samp_inter = samp; %interval for sampling from y which load from file and x;
load(filename);
hyp = [];consum = []; inter = [];
rmse = [];

%% 1)read data and reprocessing
x=[];y=[];x_train=[];y_train=[];x_test=[];y_test=[];
switch(typeV)
    case 1
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre(x_mat,u,samp_inter);
    case 2
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre(x_mat,v,samp_inter);
    case 3 %direction
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre(x_mat,d_mat,samp_inter);
    case 6 %direction
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre(x_mat,s_mat,samp_inter);   
end

%% 2) estimate the hyperparameters of the multi-scale kernel--u wind
clear x_train y_train x_test y_test
size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;
row_reg = size_lat/sub_row;    col_reg = size_lon/sub_col; 
regGrid = row_reg*col_reg;
[regx,regy] = subReg(x,y,size_lat,size_lon,sub_row,sub_col);

size_reg = size(regx,2);

sub_px = {};sub_py = {};sub_ty = {};

for i = 1:size_reg
    subx = regx{i}; suby = regy{i};
    
    sub_xtrain = subx(1:samp_inter:regGrid,:);
    sub_ytrain = suby(1:samp_inter:regGrid);
    sub_xtest = subx(samp_inter:samp_inter:regGrid,:);
    sub_yest = suby(samp_inter:samp_inter:regGrid);
    
    [predict_temp,hyp_temp,consum_temp,inter_temp] = mpng(epoch,sub_xtrain,sub_ytrain,sub_xtest);
    
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
    suby = regy{i};subpy = sub_py{i};
    nSize = size(suby,1);
    index_inter = 1;
    for n = samp_inter:samp_inter:nSize
        suby(n,1) = subpy(index_inter);
        index_inter = index_inter+1;
    end
    sub_ipy{i} = suby;
end


%% 4) estimate the result: give the mean rmse of all data sets per variable

disp('region mean rmse')
mean(rmse)
u1_temp = mapReshape(sub_ipy,size_lat,size_lon,sub_row,sub_col,samp);
u0       =	reshape(y,[size_lat,size_lon]);
u1       =	u1_temp;
disp('whole region mean rmse')
mean(getRMSE(u0,u1))

function [predict,hyp,consum,inter] = mpng(epoch,x_train,y_train,x_test)
size_hyp_2 = 15;% the size of hyperparameters for method2: multi-scale
% 2a) define the kernel functions 
covfunc2 = {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};

% 2b) initialize all the hyperparameters
hyp2.cov = zeros(1,size_hyp_2)';   % set all the hyperparameters to unit(logoarithm)
hyp2.lik = log(0.1);

likfunc2 = @likGauss; 
% 2c) estimate the hyperparameters with the maximum epoch 
tic;
hyp2 = minimize(hyp2,@gp,-epoch,@infGaussLik,[],covfunc2,likfunc2,x_train,y_train);
consum = toc;
hyp = hyp2.cov;
% 2e) regression and prediction
tic;
[predict ys2 fmu_2 fs2] = gp(hyp2, @infGaussLik, [], covfunc2, likfunc2, x_train, y_train, x_test);
inter = toc;


