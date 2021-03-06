function [u0,u1,consum,inter,ys,x_test,y_test,x_train,y_train] = time_mult_r(file_pre,minlon,minlat,maxlon,maxlat,typeV,samp,stamp,hyp)
resolution = 0.125;
%% some global variable
region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat) 'stamp' num2str(stamp)];
filename = strcat(file_pre,region,'.mat');  %space data of all variables

size_hyp_2 = 15;% the size of hyperparameters for method2: multi-scale
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

%% 2) estimate the hyperparameters of the multi-scale kernel--u wind

% 2a) define the kernel functions 
covfunc2 = {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};

% 2b) initialize all the hyperparameters
hyp2.cov = zeros(1,size_hyp_2)';   % set all the hyperparameters to unit(logoarithm)
hyp2.lik = log(0.1);

likfunc2 = @likGauss; 
% 2c) estimate the hyperparameters with the maximum epoch 
% tic;
% hyp2 = minimize(hyp2,@gp,-epoch,@infGaussLik,[],covfunc2,likfunc2,x_train,y_train);
% % 2e) regression and prediction
% consum = toc;
hyp2.cov = hyp.cov;
hyp2.lik = hyp.lik;
tic;
[u1_temp ys2 fmu_2 fs2] = gp(hyp2, @infGaussLik, [], covfunc2, likfunc2, x_train, y_train, x_test);
inter = toc;

hyp = hyp2;
ys = ys2;

consum = 0;

%% 4) estimate the result: give the mean rmse of all data sets per variable

size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;

% u1 = y;
% u0 = reshape(y,[size_lat,size_lon]);
% nSize = size_lat*size_lon;
% index_inter = 1;
% for n = samp_inter:samp_inter:nSize
%     u1(n,1) = u1_temp(index_inter);
%     index_inter = index_inter+1;
% end

% y_test   =  reshape(y_test,fix(size_lat/samp),size_lon);
% u1_temp  =	reshape(u1_temp,fix(size_lat/samp),size_lon); 
% ys       =  reshape(ys,fix(size_lat/samp),size_lon); 
u0       =  y_test;
u1       =	u1_temp;

