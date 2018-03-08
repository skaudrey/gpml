% test multi-dimension
clear all; clc;
basepath =  'D:\Code\Matlab\gpml\moi_prac\origin';

filename = '20140901-20140930-uv.nc';
varname = 'u10';
minlon = 0;
maxlon = 10;
minlat = 10;
maxlat = 20;
resolution = 0.125;
stamp = 70;
epoch = -100;    %epoch

lat_grid = (maxlat-minlat)/resolution+1;
lon_grid = (maxlon-minlon)/resolution+1;
% function multDmp
basepath  = 'D:\Code\Matlab\gpml\moi_prac\td_fea\typhoon';
prefix_s = 'ECreg_s_';
prefix_p = 'ECreg_s_pca';
samp_inter = 2; %interval for sampling from y which load from file and x;


region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat) 'stamp' num2str(stamp)];
filename_ps = strcat(prefix_p,region,'.txt');  %pca data
 
filename_ss = strcat(prefix_s,region,'.mat');   %space data of all variables
size_hyp_2 = 15;% the size of hyperparameters for method2: multi-scale

load(filename_ss);
typeV = 1;
%% 1)read data and reprocessing


x=[];y=[];x_train=[];y_train=[];x_test=[];y_test=[];
switch(typeV)
    case 1
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre([x_mat,d_mat,sst_mat],u,samp_inter);
    case 2
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre([x_mat,d_mat,sst_mat],v,samp_inter);
    case 3 %direction
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre([x_mat,d_mat,sst_mat],d_mat,samp_inter);
    case 6 %direction
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre([x_mat,d_mat,sst_mat],s_mat,samp_inter);   
end


test_size = lat_grid*lon_grid/samp_inter;


%% 2) estimate the hyperparameters of the sum of materniso and periodic kernel
size_hyp_1_2 = 27; %the size of hyperparameters
% {covPEard}: the parameters are 
% covfunc1_2 = {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise'}}
covfunc1_2 = {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};
%   covfunc1_3 = {@covPeriodic};
% 4b) initialize all the hyperparameters
hyp1_2.cov = zeros(1,size_hyp_1_2)';   % set all the hyperparameters to unit(logoarithm)
hyp1_2.lik = log(0.1);

likfunc1 = @likGauss; 
% 4c) estimate the hyperparameters with the maximum epoch 100
hyp1_2 = minimize(hyp1_2,@gp,epoch,@infGaussLik,[],covfunc1_2,likfunc1,x_train,y_train)

% 4d) show the covariance estimated
disp('exp(hyp1.lik):')
exp(hyp1_2.lik)
disp('all the hyperparameters of hyp1:');
disp('');
exp(hyp1_2.cov)

% 4e) regression and prediction
nlml2 = gp(hyp1_2, @infGaussLik, [], covfunc1_2, likfunc1, x_train, y_train)   %negative log probability or the marginal likelihood

[u1_temp s2_2 fmu_2 fs2_2] = gp(hyp1_2, @infGaussLik, [], covfunc1_2, likfunc1, x_train, y_train, x_test);


%% 3)Interpoaltion using spline interpolation

% u2_temp = spline(x_train,y_train,x_test);
% size_n = size(x_train,2);
u2_temp = [];

temp = linspace(1,lat_grid,lat_grid)';%distance matrix

x_train = temp(1:samp_inter:lat_grid)*ones(1,lon_grid);
x_test = temp(samp_inter:samp_inter:lat_grid,:)*ones(1,lon_grid);
y_train = reshape(y_train,lat_grid/samp_inter,lon_grid);

tic;
lat_interval = lat_grid/samp_inter;
for index = 1:lon_grid   
    temp = spline(x_train(:,index),y_train(:,index),x_test(:,index));
    u2_temp = [u2_temp,temp];
end
consum = toc;
% u2_temp = reshape(u2_temp,[test_size,1]);

%% 4) estimate the result: give the mean rmse of all data sets per variable
y_test = reshape(y_test,lat_grid/samp_inter,lon_grid);
u1_temp = reshape(u1_temp,lat_grid/samp_inter,lon_grid);
u0 = y_test;

u1 = u1_temp;
% u2 = [];
u2 = u2_temp;

r1 = mean(getRMSE(u0,u1))
r2 = mean(getRMSE(u0,u2))