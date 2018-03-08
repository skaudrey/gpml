function [x,y] = getRegion(basepath,filename,varname,minlon,maxlon,minlat,maxlat,resolution,time)
ncpath = strcat(basepath,'\',filename);

data = ncread(ncpath,varname);
[size_lon, size_lat,size_time] = size(data);

longitude = ncread(ncpath,'longitude');
latitude = ncread(ncpath,'latitude');

minlon = minlon/resolution+1;
maxlon = maxlon/resolution+1;
max_lat = size_lat - minlat/resolution;
min_lat = size_lat - maxlat/resolution;

xlon= [];y = [];

[lat,lon] = meshgrid(latitude,longitude);


xlon = lon(minlon:maxlon,min_lat:max_lat);
xlat = lat(minlon:maxlon,min_lat:max_lat);
y = data(minlon:maxlon,min_lat:max_lat,time);

xlon = reshape(xlon,[],1);
xlat = reshape(xlat,[],1);

x = [xlat,xlon];

y = reshape(y,[],1);

