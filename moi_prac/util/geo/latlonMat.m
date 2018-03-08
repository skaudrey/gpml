function [lat,lon] = latlonMat(minlat,minlon,maxlat,maxlon,rawReso,postReso)
lat_grid = (maxlat-minlat)/rawReso +1;
lon_Grid = (maxlon-minlon)/rawReso +1;
lat = [];lon = [];
x_lat = linspace(maxlat,minlat,lat_grid);

% x_lat = x_lat(2:interval:lat_grid);
for lon_index = 1:lon_Grid
    lat = [lat;x_lat];
end
x_lon = linspace(minlon,maxlon,lon_Grid)';% start from 120'E
for lat_index = 1:lat_grid
    lon = [lon,x_lon];
end

