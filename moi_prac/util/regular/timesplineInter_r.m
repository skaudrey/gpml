function [u0,u1,consum,inter,hyp] = timesplineInter_r(file_pre,minlon,minlat,maxlon,maxlat,typeV,samp,stamp)
resolution = 0.125;
%% some global variable
region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat) 'stamp' num2str(stamp)];
filename = strcat(file_pre,region,'.mat');  %space data of all variables

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

%% reshape data for 1d spline


size_lat = (maxlat-minlat)/resolution+1;
size_lon = (maxlon-minlon)/resolution+1;

minLonInd = minlon/0.125+1;
maxLonInd = maxlon/0.125+1;

temp = linspace(1,size_lat,size_lat)';%distance matrix

xtrain = {}; xtest = {};ytrain = {};

temp_size = fix(size_lat/2);

x_train1 = temp(1:samp_inter:size_lat);
x_train2 = temp(samp_inter:samp_inter:size_lat);

index = 1;
for i = minLonInd:maxLonInd
    ytrain{index} = y_train(find(x_train(:,1) == i));
    if(mod(i,2)==0)
        xtrain{index} = x_train2;
        xtest{index} = x_train1;
    
    else
        xtrain{index} = x_train1;
        xtest{index} = x_train2;    
    end
    index = index+1;
end

% xtrain = temp(1:samp_inter:size_lat)*ones(1,size_lon);
% xtest = temp(samp_inter:samp_inter:size_lat,:)*ones(1,size_lon);
% ytrain = reshape(ytrain,size_lat/samp,size_lon);
% 
% y_size = size_lat/samp*size_lon;

%% 3)Interpoaltion using spline interpolation

u2_temp = [];
tic;
for index = 1:size_lon
    temp = spline(xtrain{index},ytrain{index},xtest{index});
    u2_temp = [u2_temp;temp];
end
consum = toc;
consum = consum/2;
inter = consum;

%% 4) estimate the result: give the mean rmse of all data sets per variable
size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;

% u0 = reshape(y,[size_lat,size_lon]);
% u1 = y;
% nSize = size_lat*size_lon;
% index_inter = 1;
% for n = samp_inter:samp_inter:nSize
%     u1(n,1) = u2_temp(index_inter);
%     index_inter = index_inter+1;
% end
% u1       =	reshape(u1,[size_lat,size_lon]);


% y_test   =  reshape(sy_test,fix(size_lat/samp),size_lon);
u0       =  y_test;
u1       =	u2_temp;

hyp = {};
