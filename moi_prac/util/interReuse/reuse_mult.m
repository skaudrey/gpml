function [u0,u1,lat,lon,consum,inter] = reuse_mult(file_pre,minlon,minlat,maxlon,maxlat,typeV,samp,stamp,hyp)
resolution = 0.125;
size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;
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
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre(x_mat,u,samp_inter,size_lat,size_lon);
    case 2
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre(x_mat,v,samp_inter,size_lat,size_lon);
    case 3 %direction
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre(x_mat,d_mat,samp_inter,size_lat,size_lon);
    case 6 %direction
        [x,y,x_train,y_train,x_test,y_test] = matdata_pre(x_mat,s_mat,samp_inter,size_lat,size_lon); 
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

consum = 0;

%% 4) estimate the result: give the mean rmse of all data sets per variable

u0 = y;
u1 = u0;
index_inter = 1;

for i = 1:size_lon
    for j = 1:size_lat
        if(mod(i,samp_inter)==0 & mod(j,samp_inter) == 0)
           u1(i,j) = u1_temp(index_inter);
        end
    end
end
lat = reshape(x(:,1), [size_lon,size_lat]);
lon = reshape(x(:,2), [size_lon,size_lat]);


function [x,y,x_train,y_train,x_test,y_test] = matdata_pre(x,y,samp_inter,size_lat,size_lon)

x_lat = reshape(x(:,1),size_lon,size_lat);
x_lon = reshape(x(:,2),size_lon,size_lat);
y = reshape(y,size_lon,size_lat);

% x_train = [reshape(x_lat(1:samp_inter:size_lat,1:samp_inter:size_lon),[],1),...
%     reshape(x_lon(1:samp_inter:size_lat,1:samp_inter:size_lon),[],1)];
% y_train = reshape(y(1:samp_inter:size_lat,1:samp_inter:size_lon),[],1);
x_test = [reshape(x_lat(samp_inter:samp_inter:size_lon,samp_inter:samp_inter:size_lat),[],1),...
    reshape(x_lon(samp_inter:samp_inter:size_lon,samp_inter:samp_inter:size_lat),[],1)];
y_test = reshape(y(samp_inter:samp_inter:size_lon,samp_inter:samp_inter:size_lat),[],1);
size_test = size(y,1);

index = 1; x_train = zeros(size_test,2); y_train = zeros(size_test,1);
for i = 1:size_lon
    for j = 1:size_lat
        if(mod(i,samp_inter)~=0 || mod(j,samp_inter) ~= 0)
            x_train(index,:) = [x_lat(i,j)  x_lon(i,j)];
            y_train(index,:) = y(i,j);
            index = index+1;
        end
    end
end


