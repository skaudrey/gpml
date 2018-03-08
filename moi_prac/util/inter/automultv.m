function [u0 u1  u2] = automultv(prefix_p,prefix_s,lon)

% pca feature for GPR
% according to the self-regression and the strong linearity characteristic
% of u self, I'd like to choose the difference 

%======= Remarks of DATA:the longitude = 7'E; latitude = 90'S--90'N ; time£ºthe firsst day of every month =========
%======= Remarks of kernel choice : see the expirement result in
%space_lon.m and time_fix.m, and the begining of the m file

close all

%% some global variables for EC data
 filename_ss = strcat(prefix_s,num2str(lon),'.txt');   %space data of pca
 
%====================hyperparameters size=========================== 
 % for wind speed interpolation ,the different hyperparameters size of each method
size_hyp_4 = 13 ; %the size of hyperparameters for multi-scale for space data/time data

% ====================data preprocessing parameters========================
samp_inter_s = 2;

%% 0)read data and preprocessing the outlier

% space information data
% [sxtemp,sytemp,sxtemp_train,sytemp_train,sxtemp_test,sytemp_test] = data_pre(filename_ts,samp_inter_s);
[sx,sy,sx_train,sy_train,sx_test,sy_test] = data_pre(filename_ss,samp_inter_s);
% [sxd,syd,sxd_train,syd_train,sxd_test,syd_test] = data_pre(filename_ds,samp_inter_s);
[sxauto,syauto,sxauto_train,syauto_train,sxauto_test,syauto_test] = data_auto(sx,sy,sx_train,sy_train,sx_test,sy_test);

% delete the unuseful data to release space
clear sxauto syauto 

%% 4) space interpolation for wind speed with other variables:pressure and temp with multi; direction with periodic
covfunc4 = {'covSum',{{@covMaterniso,3},{'covProd',{{@covMaterniso,3},'covPeriodic'}},{ 'covRQard' },{'covSum',{{@covMaterniso,3},'covNoise'}}}};


% 4a£© fit the auto hyperparameters
hyp4.cov = zeros(1,size_hyp_4)';  hyp4.lik = log(0.1); likfunc4 = @likGauss; 
hyp4 = minimize(hyp4,@gp,-100,@infGaussLik,[],covfunc4,likfunc4,sx_train,sy_train);

% 4e) regression and prediction
[u1_temp s2_4 fmu_4 fs2_4] = gp(hyp4, @infGaussLik, [], covfunc4, likfunc4,syauto_train, sy_train(1:end-1), syauto_test);

%% 3) spline
u2_temp = spline(sx_train,sy_train,sx_test(2:end));

%% end) estimate the result
u0 = sy_test(1:end-1);
u1 = u1_temp;
u2 = u2_temp;
