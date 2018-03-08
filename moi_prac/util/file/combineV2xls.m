% make the file of multi variables
% @typeI : the interpolation method,1 for space,2 for time

function combineV2xls(typeI,typeV)

% varname
sst = 'sst';    %sea surface temperature
sp = 'sp';  %surface pressure
msl = 'msl';   %mean sea level pressure
uwind = 'u10'; % u wind component
vwind = 'v10'; % v wind component
direct = 'd';   % wind direction
speed = 'speed'; %wind speed
pca = 'pca';

% nc filename
other_filename ='20140901-20140930-sst-mslp-swh.nc';
uv_filename = '20140901-20140930-uv.nc';


% the dimension of data is lon_size * lat_size * time_size
% time_size = 1462;   
% lon_size = 480;
% lat_size = 241;
time_size = 241;
lon_size = 481;
lat_size = 481;


% the resolution of longitude and latitude
% longitude  = lon_index * resolution; latitude = lat_index * resolution;
resolution = 0.25;
lon_total = 360;
lat_total = 180;

% path of origin nc file
basepath = 'D:\Code\Matlab\gpml\moi_prac\origin';
outpath = 'D:\Code\Matlab\gpml\moi_prac\pca\';
pick_time = 100;

prefix = 'EC25_';

%% pick multi variable for space data
% one longitude
pick_lat = 20;   
for pick_lon = 40:47
    sst_mat_s = nc2mat(basepath,other_filename,sst,pick_lon,0,pick_time);
    mslp_mat_s = nc2mat(basepath,other_filename,msl,pick_lon,0,pick_time);
    
    u = nc2mat(basepath,uv_filename,uwind,pick_lon,0,pick_time);
    v = nc2mat(basepath,uv_filename,vwind,pick_lon,0,pick_time);
    
    d_mat_s = calDirection(u,v);
    s_mat_s = sqrt(u^2+v^2);
    
%     distance = linspace(1,lat_size,lat_size)';    
    
    u_mat_s = [sst_mat_s mslp_mat_s d_mat_s s_mat_s];

    filename = outExcelName(prefix,pca,pick_lon,0,pick_time,resolution);

    outfile = strcat(outpath,filename);

    xlswrite(outfile,u_mat_s);    
end

% one latitude
pick_lon = 40;   
for pick_lat = 40:47
    sst_mat_s = nc2mat(basepath,other_filename,sst,0,pick_lat,pick_time);
    mslp_mat_s = nc2mat(basepath,other_filename,msl,0,pick_lat,pick_time);
    
    u = nc2mat(basepath,uv_filename,uwind,0,pick_lat,pick_time);
    v = nc2mat(basepath,uv_filename,vwind,0,pick_lat,pick_time);
    
    d_mat_s = calDirection(u,v);

%     distance = linspace(1,lon_size,lon_size)';    
    
%     u_mat_s = [distance sst_mat_s mslp_mat_s d_mat_s];
    u_mat_s = [sst_mat_s mslp_mat_s d_mat_s];

    filename = outExcelName(prefix,pca,0,pick_lat,pick_time,resolution);

    outfile = strcat(outpath,filename);

    xlswrite(outfile,u_mat_s);    
end