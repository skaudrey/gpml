% pca feature for GPR
% combine the feature: sst,mslp,d to one feature and train the kernel
% parameters just for this function

function [u0 u1  u2] = mp_pca(prefix_p,prefix_s,lon)
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
size_hyp_4_p = 5 ; %the size of hyperparameters for multi-scale method of pca feature: multi

size_hyp_4_s = 5 ; %the size of hyperparameters for multi-scale for space data/time data

% ====================data preprocessing parameters========================
samp_inter_s = 2;

%% 0)read data and preprocessing the outlier

% space information data
% [sxtemp,sytemp,sxtemp_train,sytemp_train,sxtemp_test,sytemp_test] = data_pre(filename_ts,samp_inter_s);
[sxpca,sypca,sxpca_train,sypca_train,sxpca_test,sypca_test] = data_pre(filename_ps,samp_inter_s);
% [sxd,syd,sxd_train,syd_train,sxd_test,syd_test] = data_pre(filename_ds,samp_inter_s);
[sx,sy,sx_train,sy_train,sx_test,sy_test] = data_pre(filename_ss,samp_inter_s);

% delete the unuseful data to release space
clear sxpca sypca sypca_test  

%% 4) space interpolation for wind speed with other variables:pressure and temp with multi; direction with periodic
covfunc4_pca = {'covSum',{{@covMaterniso,1},'covPeriodic'}};
covfunc4_s = {'covSum',{{@covMaterniso,1},'covPeriodic'}};

% covfunc4 = {'covProd',{covfunc4_s,covfunc4_pca}};

 covfunc4 = {'covSum',{covfunc4_s,covfunc4_pca}};

% 4a£© fit the pressure hyperparameters
hyp4_p.cov = zeros(1,size_hyp_4_p)';  hyp4_p.lik = log(0.1); likfunc4_p = @likGauss; 
hyp4_p = minimize(hyp4_p,@gp,-100,@infGaussLik,[],covfunc4_pca,likfunc4_p,sxpca_train,sypca_train)

% 4d£© fit the time hyperparameters
hyp4_s.cov = zeros(1,size_hyp_4_s)';  hyp4_s.lik = log(0.1); likfunc4_s = @likGauss; 
hyp4_s = minimize(hyp4_s,@gp,-100,@infGaussLik,[],covfunc4_s,likfunc4_s,sx_train,sy_train);

hyp4.cov = [hyp4_s.cov;hyp4_p.cov;];
hyp4.lik = log(exp(hyp4_p.lik) * exp(hyp4_s.lik)) ;
% hyp4.lik = log(exp(hyp4_p.lik) + exp(hyp4_s.lik)) ;

likfunc4 = @likGauss;

% 4e) regression and prediction
[u1_temp s2_4 fmu_4 fs2_4] = gp(hyp4, @infGaussLik, [], covfunc4, likfunc4,sx_train, sy_train, sx_test);

%% 3) spline
u2_temp = spline(sx_train,sy_train,sx_test);

%% end) estimate the result
u0 = sy_test;
u1 = u1_temp;
u2 = u2_temp;
