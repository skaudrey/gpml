% consum for train time and inter for interpolation time
function [u0,u1,consum,inter,hyp] = mpRegInter(file_pre,minlon,minlat,maxlon,maxlat,typeV,epoch,samp)
resolution = 0.125;
%% some global variable
region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat)];
filename = strcat(file_pre,region,'.mat');  %space data of all variables

size_hyp_2 = 10;% the size of hyperparameters for method2: multi-scale
samp_inter = samp; %interval for sampling from y which load from file and x;
load(filename);

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


size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;
%% 2) estimate the hyperparameters of the multi-scale kernel--u wind

% 2a) define the kernel functions 
covfunc2 = {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} }};
 inf  = @infGaussLik;

% 2b) initialize all the hyperparameters
hyp2.cov = zeros(1,size_hyp_2)';   % set all the hyperparameters to unit(logoarithm)
hyp2.lik = log(0.1);
likfunc2 = @likGauss; 
% 2c) estimate the hyperparameters with the maximum epoch 100
tic;
hyp2 = minimize(hyp2,@gp,-epoch,inf,[],covfunc2,likfunc2,x_train,y_train);
consum = toc;
% 2e) regression and prediction
tic;
[u1_temp ys2 fmu_2 fs2] = gp(hyp2, inf, [], covfunc2, likfunc2, x_train, y_train, x_test);
inter= toc;

hyp = hyp2;

%% 4) estimate the result: give the mean rmse of all data sets per variable

% 4a)recomposite the u1 and u2(cause interpolation test points are just sampled from raw data of x)

u1 = y;
u0 = reshape(y,[size_lat,size_lon]);
nSize = size_lat*size_lon;
index_inter = 1;
for n = samp_inter:samp_inter:nSize
    u1(n,1) = u1_temp(index_inter);
    index_inter = index_inter+1;
end
u1 = reshape(u1,[size_lat,size_lon]);

