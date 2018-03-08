function [u0,u1,u2] = rqInter(file_pre,lon)

%% some global variable
% filename = strcat(file_pre,'LON',num2str(lon),'.txt');
filename = strcat(file_pre,num2str(lon),'.txt');

size_hyp_2 = 3;% the size of hyperparameters for method2: multi-scale
samp_inter = 2; %interval for sampling from y which load from file and x;


%% 1)read data and reprocessing

[x,y,x_train,y_train,x_test,y_test] = data_pre(filename,samp_inter);

%% 2) estimate the hyperparameters of the multi-scale kernel--u wind

% 2a) define the kernel functions 

covfunc2 = {'covRQiso'};

% 2b) initialize all the hyperparameters
hyp2.cov = zeros(1,size_hyp_2)';   % set all the hyperparameters to unit(logoarithm)
hyp2.lik = log(0.1);

likfunc2 = @likGauss; 
% 2c) estimate the hyperparameters with the maximum epoch 100
hyp2 = minimize(hyp2,@gp,-100,@infGaussLik,[],covfunc2,likfunc2,x_train,y_train);

% 2d) show the covariance estimated
disp('exp(hyp2.lik):')
exp(hyp2.lik)
disp('all the hyperparameters of hyp2:');
disp('');
exp(hyp2.cov)


% 2e) regression and prediction
disp('nlml2 = gp(hyp, @infGaussLik, [], covfunc, likfunc, x, y)')
nlml2 = gp(hyp2, @infGaussLik, [], covfunc2, likfunc2, x_train, y_train)   %negative log probability or the marginal likelihood
disp('[m s2] = gp(hyp, @infGaussLik, [], covfunc, likfunc, x, y, z);')
% [u1_temp ys2 fmu_2 fs2] = gp(hyp2, @infGaussLik, [], covfunc2, likfunc2, x_train, y_train, x_test);
[u1_temp ys2 fmu_2 fs2] = gp(hyp2, @infGaussLik, [], covfunc2, likfunc2, x_train, y_train, x_test);


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

