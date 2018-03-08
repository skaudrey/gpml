close all;
offflag = 1;

%% normal day:LAT20-30LON120-130:matPcaProd epoch 80
filename = 'D:\Code\Matlab\gpml\moi_prac\normalday\Inter_s_LON0-10LAT40-30.mat';
load(filename);    %timestamp 21
minlat = 30;    maxlat = 40;
minlon = 120;   maxlon = 130;

regminLat = minlat;     regmaxlat = maxlat;
regminlon = minlon;	regmaxlon = maxlon;

epochIndex = 3; % epochIndex means epoch [20,50,80,100];
method = 8; % 1-7 means 
index = getUVIndex(epochIndex,method);
spIndex = 7;

colorMax = 0;
mapDraw(minlat,minlon,maxlat,maxlon,u,v,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,[]);
diffMapDraw(minlat,minlon,maxlat,maxlon,u,v,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,0,spIndex,[]);


%% typhoon day:LAT20-30LON120-130:matPcaProd epoch 100
filename = 'D:\Code\Matlab\gpml\moi_prac\typhoon\Inter_s_LON0-10LAT20-30.mat';
load(filename);    %timestamp 85
offflag = 0;
minlat = 20;    maxlat = 30;
minlon = 120;   maxlon = 130;

regminLat = minlat;     regmaxlat = maxlat;
regminlon = minlon;	regmaxlon = maxlon;

epochIndex = 4; % epochIndex means epoch [20,50,80,100];
method = 5; % 1-7 means 
index = getUVIndex(epochIndex,method);

colorMax = 0;
mapDraw(minlat,minlon,maxlat,maxlon,u,v,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,[]);
diffMapDraw(minlat,minlon,maxlat,maxlon,u,v,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,[]);