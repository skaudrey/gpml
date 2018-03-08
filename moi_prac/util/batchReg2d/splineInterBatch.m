function [u0,u1,consum,inter,hyp] = splineInterBatch(file_pre,minlon,minlat,maxlon,maxlat,typeV,samp,sub_row,sub_col)
resolution = 0.125;
%% some global variable
region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat)];
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

temp = linspace(1,size_lat,size_lat)';%distance matrix

x_train = temp(1:samp_inter:size_lat)*ones(1,size_lon);
x_test = temp(samp_inter:samp_inter:size_lat,:)*ones(1,size_lon);
y_train = reshape(y_train,size_lat/samp,size_lon);

y_size = size_lat/samp*size_lon;

%% 3)Interpoaltion using spline interpolation

u1_temp = [];
tic;
for index = 1:size_lon
    temp = spline(x_train(:,index),y_train(:,index),x_test(:,index));
    u1_temp = [u1_temp,temp];
end
consum = toc/2;
inter = toc/2;

%% 4) estimate the result: give the mean rmse of all data sets per variable
u0 = reshape(y,[size_lat,size_lon]);
u1 = y;
nSize = size_lat*size_lon;
index_inter = 1;
for n = samp_inter:samp_inter:nSize
    u1(n,1) = u1_temp(index_inter);
    index_inter = index_inter+1;
end
u1       =	reshape(u1,[size_lat,size_lon]);
disp('whole region mean rmse')
mean(getRMSE(u0,u1))

hyp = [];