% do interpolation with multi-scale and multi variables for space or time
% interpolation

function [u0 u1  u2] = multSV(prefix_t,prefix_p,prefix_d,prefix_s,lon)

% do interpolation according to the space with multi-scale and
% multi-variables
%4) the forth method will be the space interpolation for wind speed with other variables

%======= Remarks of DATA:the longitude = 7'E; latitude = 90'S--90'N ; time£ºthe firsst day of every month =========
%======= Remarks of kernel choice : see the expirement result in
%space_lon.m and time_fix.m, and the begining of the m file

close all

%% some global variables for EC data
sst = 'sst';    %sea surface temperature
msl = 'msl';   %mean sea level pressure
uwind = 'u10'; % u wind component
vwind = 'v10'; % v wind component
direct = 'd';   % wind direction
speed = 'speed'; %wind speed

resolution = 0.75;
pick_time = 1;

% For EC data, get the name by function outfilename
%  filename_ts = strcat(prefix_t,'LON',num2str(lon),'.txt');  %space data of temperature
%  filename_ps = strcat(prefix_p,'LON',num2str(lon),'.txt');   %space data of pressure
%  filename_ds = strcat(prefix_d,'LON',num2str(lon),'.txt');   %space data of wind direction
%  filename_ss = strcat(prefix_s,'LON',num2str(lon),'.txt');  %space data of wind speed 
 
 filename_ts = strcat(prefix_t,num2str(lon),'.txt');  %space data of temperature
 filename_ps = strcat(prefix_p,num2str(lon),'.txt');   %space data of pressure
 filename_ds = strcat(prefix_d,num2str(lon),'.txt');   %space data of wind direction
 filename_ss = strcat(prefix_s,num2str(lon),'.txt');  %space data of wind speed 
 
%====================hyperparameters size=========================== 
 % for wind speed interpolation ,the different hyperparameters size of each method
size_hyp_4_p = 3 ; %the size of hyperparameters for method4_pressure: multi
size_hyp_4_t = 2 ; %the size of hyperparameters for method4_temperature: multi
size_hyp_4_d = 5 ; %the size of hyperparameters for method3_direction: only materniso,1
size_hyp_4_s = 13 ; %the size of hyperparameters for method3_space: only materniso,1

% ====================data preprocessing parameters========================
samp_inter_s = 2;
thresh = -9998; % the space doesn't have the value is set to -9999, which 
% will be the outlier, I just delete it and adjust with the distance

% ====================plot parameters========================
figIndex = 1;

%  ======size of data file: the year size and the space size in order to get the space information and time information=======
% nYear = 2;  % the datafile contains 3 years data and the first day per month,aka there are 36 points per place
nDay = 365+366;
nHour = 2;
nTimeSize = nHour * nDay;   % the space order is the floor of dataorder/nTimeSize,and the time order is dataorder mod nTimeSize

%% 0)read data and preprocessing the outlier

% space information data
[sxtemp,sytemp,sxtemp_train,sytemp_train,sxtemp_test,sytemp_test] = data_pre(filename_ts,samp_inter_s);
[sxpress,sypress,sxpress_train,sypress_train,sxpress_test,sypress_test] = data_pre(filename_ps,samp_inter_s);
[sxd,syd,sxd_train,syd_train,sxd_test,syd_test] = data_pre(filename_ds,samp_inter_s);
[sx,sy,sx_train,sy_train,sx_test,sy_test] = data_pre(filename_ss,samp_inter_s);

% delete the unuseful data to release space
clear sxtemp sytemp sxtemp_test sxpress sypress sypress_test sxd syd syd_test 

%% 4) space interpolation for wind speed with other variables:pressure and temp with multi; direction with periodic
covfunc4_pres = {'covPeriodic'};
covfunc4_temp = {@covMaterniso,1};
covfunc4_direc = {'covSum',{{@covMaterniso,1},'covPeriodic'}};
covfunc4_s = {'covSum',{{@covMaterniso,3},{'covProd',{{@covMaterniso,3},'covPeriodic'}},{ 'covRQard' },{'covSum',{{@covMaterniso,3},'covNoise'}}}};

covfunc4 = {'covProd',{covfunc4_direc,covfunc4_s,{'covSum',{covfunc4_temp,covfunc4_pres}}}};

% 4a£© fit the pressure hyperparameters
hyp4_p.cov = zeros(1,size_hyp_4_p)';  hyp4_p.lik = log(0.1); likfunc4_p = @likGauss; 
hyp4_p = minimize(hyp4_p,@gp,-100,@infGaussLik,[],covfunc4_pres,likfunc4_p,sxpress_train,sypress_train)

% 4b£© fit the temperature hyperparameters
hyp4_t.cov = zeros(1,size_hyp_4_t)';  hyp4_t.lik = log(0.1); likfunc4_t = @likGauss; 
hyp4_t = minimize(hyp4_t,@gp,-100,@infGaussLik,[],covfunc4_temp,likfunc4_t,sxtemp_train,sytemp_train);

% 4c£© fit the direction hyperparameters
hyp4_d.cov = zeros(1,size_hyp_4_d)';  hyp4_d.lik = log(0.1); likfunc4_d = @likGauss; 
hyp4_d = minimize(hyp4_d,@gp,-100,@infGaussLik,[],covfunc4_direc,likfunc4_d,sxd_train,syd_train);

% 4d£© fit the time hyperparameters
hyp4_s.cov = zeros(1,size_hyp_4_s)';  hyp4_s.lik = log(0.1); likfunc4_s = @likGauss; 
hyp4_s = minimize(hyp4_s,@gp,-100,@infGaussLik,[],covfunc4_s,likfunc4_s,sx_train,sy_train);

hyp4.cov = [hyp4_d.cov;hyp4_s.cov;hyp4_t.cov;hyp4_p.cov;];
hyp4.lik = log(exp(hyp4_d.lik) * exp(hyp4_s.lik) *((1/3) * hyp4_t.lik + (2/3)* hyp4_p.lik)) ;
% hyp4.cov = zeros(1,size_hyp_4)';  hyp4.lik = log(0.1) ;

likfunc4 = @likGauss;

% 4e) regression and prediction
[u1_temp s2_4 fmu_4 fs2_4] = gp(hyp4, @infGaussLik, [], covfunc4, likfunc4,sx_train, sy_train, sx_test);

%% 3) spline
u2_temp = spline(sx_train,sy_train,sx_test);



%% end) estimate the result
u0 = sy_test;
u1 = u1_temp;
u2 = u2_temp;
