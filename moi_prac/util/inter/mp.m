
% return the interpolation result of ,at+periodic and spline result
% file_pre for indice the variable name, lon for region and latitude still
% is the whole latitude

% return:
% @u0 : raw data before do interpolation
% @u1 : interpolated result of multi-scale
% @u2 : interpolated result of spline

% FOR DATA OF YH
% multi-scale: humidity,pressure,temperature,vertical wind,v direction wind
% materniso1+periodic : density
% materniso1 : wind direction, scalar wind speed and the u direction wind

% The error pf msl is so huge
% FOR DATA OF EC
% multi-scale: speed
% using multi-scale interpolation for wind field drawing and comparision

function [u0,u1,u2] = mp(file_pre,lon)
%% some global variable
% filename = strcat(file_pre,'LON',num2str(lon),'.txt');
filename = strcat(file_pre,num2str(lon),'.txt');

size_hyp_1_2 = 5 ; %the size of hyperparameters for method1_2: only maetrn+periodic
samp_inter = 2; %interval for sampling from y which load from file and x;

%% 1)read data and reprocessing

[x,y,x_train,y_train,x_test,y_test] = data_pre(filename,samp_inter);

%% 2) estimate the hyperparameters of the sum of materniso and periodic kernel

covfunc1_2 = {'covSum',{{@covMaterniso,1},'covPeriodic'}}
%   covfunc1_3 = {@covPeriodic};
% 4b) initialize all the hyperparameters
hyp1_2.cov = zeros(1,size_hyp_1_2)';   % set all the hyperparameters to unit(logoarithm)
hyp1_2.lik = log(0.1);

likfunc1 = @likGauss; 
% 4c) estimate the hyperparameters with the maximum epoch 100
hyp1_2 = minimize(hyp1_2,@gp,-100,@infGaussLik,[],covfunc1_2,likfunc1,x_train,y_train)

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
u2_temp = spline(x_train,y_train,x_test);


%% 4) estimate the result: give the mean rmse of all data sets per variable

u0 = y_test;
% 4a)recomposite the u1 and u2(cause interpolation test points are just sampled from raw data of x)
% index_inter = 1;
% for n = samp_inter:samp_inter:nSize
%     u1(n) = u1_temp(index_inter);
%     u2(n) = u2_temp(index_inter);
%     index_inter = index_inter + 1;
% end

u1 = u1_temp;
u2 = u2_temp;

