function [u0,u1,lat,lon,consum,inter,hyp] = timesplineInter(file_pre,minlon,minlat,maxlon,maxlat,typeV,samp,stamp)
resolution = 0.125;
%% some global variable
region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat) 'stamp' num2str(stamp)];
filename = strcat(file_pre,region,'.mat');  %space data of all variables

size_lat = (maxlat-minlat)/resolution+1;
size_lon = (maxlon-minlon)/resolution+1;
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

%% reshape data for 1d spline



% minLonInd = minlon/0.125+1;
% maxLonInd = maxlon/0.125+1;

temp = linspace(1,size_lat,size_lat)';%distance matrix

xtrain = {}; xtest = {};ytrain = {};

temp_size = fix(size_lat/2);

x_train1 = temp(1:samp_inter:size_lon);
x_train2 = temp(samp_inter:samp_inter:size_lon);

xtrain = repmat(x_train1,[1,temp_size+1]);
xtest = repmat(x_train2,[1,temp_size]);

index = 1;
% yy = reshape(y,[size_lon,size_lat]);
for i = samp_inter:samp_inter:size_lat
    ytrain{index} = y(1:samp_inter:size_lon,i);
%     if(mod(i,2)==0)
%         xtrain{index} = x_train2;
%         xtest{index} = x_train1;
%     
%     else
%         xtrain{index} = x_train1;
%         xtest{index} = x_train2;    
%     end
    index = index+1;
end



%% 3)Interpoaltion using spline interpolation

u2_temp = [];
tic;
for index = 1:temp_size
    temp = spline(xtrain(:,index),ytrain{index},xtest(:,index));
    u2_temp = [u2_temp;temp];
end
consum = toc;
consum = consum/2;
inter = consum;

%% 4) estimate the result: give the mean rmse of all data sets per variable
size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;

u0 = y;
u1 = u0;
% nSize = size_lat*size_lon;
index_inter = 1;

for i = 1:size_lon
    for j = 1:size_lat
        if(mod(i,samp_inter)==0 & mod(j,samp_inter) == 0)
           u1(i,j) = u2_temp(index_inter);
        end
    end
end

lat = reshape(x(:,1), [size_lon,size_lat]);
lon = reshape(x(:,2), [size_lon,size_lat]);
hyp = {};
%% data prepare
function [x,y,x_train,y_train,x_test,y_test] = matdata_pre(x,y,samp_inter,size_lat,size_lon)

x_lat = reshape(x(:,1),size_lon,size_lat);
x_lon = reshape(x(:,2),size_lon,size_lat);
y = reshape(y,size_lon,size_lat);

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

