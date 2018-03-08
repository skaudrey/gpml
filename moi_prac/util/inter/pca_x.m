% pca feature for GPR
% combine the feature: sst,mslp,d to one feature and train the kernel
% parameters just for this function

function [u0 u1  u2] = pca_x(prefix_p,prefix_s,lon)
% do interpolation according to the space with multi-scale and
% multi-variables
%4) the forth method will be the space interpolation for wind speed with other variables

%======= Remarks of DATA:the longitude = 7'E; latitude = 90'S--90'N ; time£ºthe firsst day of every month =========
%======= Remarks of kernel choice : see the expirement result in
%space_lon.m and time_fix.m, and the begining of the m file

close all

%% some global variables for EC data
 filename_ps = strcat(prefix_p,num2str(lon),'.txt');  %space data 
 filename_ss = strcat(prefix_s,num2str(lon),'.txt');   %space data of pca
 
%====================hyperparameters size=========================== 
 % for wind speed interpolation ,the different hyperparameters size of each method
% size_hyp_4_p = 13 ; %the size of hyperparameters for multi-scale method of pca feature: multi

size_hyp_4 = 13 ; %the size of hyperparameters for multi-scale for space data/time data

% ====================data preprocessing parameters========================
samp_inter_s = 2;

%% 0)read data and preprocessing the outlier

% space information data
% [sxtemp,sytemp,sxtemp_train,sytemp_train,sxtemp_test,sytemp_test] = data_pre(filename_ts,samp_inter_s);
[sxpca,sypca,sxpca_train,sypca_train,sxpca_test,sypca_test] = data_pre(filename_ps,samp_inter_s);
% [sxd,syd,sxd_train,syd_train,sxd_test,syd_test] = data_pre(filename_ds,samp_inter_s);
[sx,sy,sx_train,sy_train,sx_test,sy_test] = data_pre(filename_ss,samp_inter_s);

% delete the unuseful data to release space
clear sxpca sypca

%% 4) space interpolation for wind speed with other variables:pressure and temp with multi; direction with periodic

covfunc4 = {'covSum',{{@covMaterniso,3},{'covProd',{{@covMaterniso,3},'covPeriodic'}},{ 'covRQard' },{'covSum',{{@covMaterniso,3},'covNoise'}}}};

% 4d£© fit the time hyperparameters
hyp4.cov = zeros(1,size_hyp_4)';  hyp4.lik = log(0.1); likfunc4 = @likGauss; 
hyp4 = minimize(hyp4,@gp,-100,@infGaussLik,[],covfunc4,likfunc4,sypca_train,sy_train);

% 4e) regression and prediction
[u1_temp s2_4 fmu_4 fs2_4] = gp(hyp4, @infGaussLik, [], covfunc4, likfunc4,sypca_train, sy_train, sypca_test);

%% 3) spline
u2_temp = spline(sx_train,sy_train,sx_test);

%% end) estimate the result
u0 = sy_test;
u1 = u1_temp;
u2 = u2_temp;
