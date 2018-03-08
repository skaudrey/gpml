
% test the processing wind velocity of the direction of d
% Warning: all the data sets are showed as columns vector,input x and the
% result y
% x！！ the space latitude order,from 0 to 181,means from 90'S to 90'N
% y！！ the wind velocity in the direction of d
% nSize！！the size of y
% mu ！！ the predicted value of test cases xs
% nSize！！the size of y


% wierd!!! Is there something different between the u direction and v
% direction??  u has a tendency for the materniso1; v has a tendency for
% multi-scale

% return the interpolation result of multi-scale and spline result
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

function [u0,u1,u2] = multScale(file_pre,lon)
%% some global variable
% filename = strcat(file_pre,'LON',num2str(lon),'.txt');
filename = strcat(file_pre,num2str(lon),'.txt');

size_hyp_2 = 13;% the size of hyperparameters for method2: multi-scale
samp_inter = 2; %interval for sampling from y which load from file and x;

thresh = -9998; % the space doesn't have the value is set to -9999, which 
% will be the outlier, I just delete it and adjust with the distance


%% 1)read data and reprocessing

[x,y,x_train,y_train,x_test,y_test] = data_pre(filename,samp_inter);

%% 2) estimate the hyperparameters of the multi-scale kernel--u wind

% 2a) define the kernel functions 
covfunc2_1 = {@covMaterniso,3};
covfunc2_2 = {'covProd',{{@covMaterniso,3},'covPeriodic'}}
covfunc2_3 = { 'covRQard' };
covfunc2_4 = {'covSum',{{@covMaterniso,3},'covNoise'}};
covfunc2 = {'covSum',{covfunc2_1,covfunc2_2,covfunc2_3,covfunc2_4}};

% 2b) initialize all the hyperparameters
hyp2.cov = zeros(1,size_hyp_2)';   % set all the hyperparameters to unit(logoarithm)
hyp2.lik = log(0.1);

likfunc2 = @likGauss; 
% 2c) estimate the hyperparameters with the maximum epoch 100
hyp2 = minimize(hyp2,@gp,-100,@infGaussLik,[],covfunc2,likfunc2,x_train,y_train);

[u1_temp ys2 fmu_2 fs2] = gp(hyp2, @infGaussLik, [], covfunc2, likfunc2, x_train, y_train, x_test);


%% 3)Interpoaltion using spline interpolation

% u2_temp = spline(x_train,y_train,x_test);
u2_temp = spline(x_train,y_train,x_test);


%% 4) estimate the result: give the mean rmse of all data sets per variable

u0 = y_test;
u1 = u1_temp;
u2 = u2_temp;

