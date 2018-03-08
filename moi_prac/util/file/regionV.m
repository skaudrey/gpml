% regionV 2 xls

%for one latitude or logitude, get one region of sst,mslp and d and
%distract the principle component

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
pca = 'pcareg';

% nc filename
% sp_filename = '_grib2netcdf-atls05-98f536083ae965b31b0d04811be6f4c6-067xI2.nc';
% sst_filename = '_grib2netcdf-atls04-95e2cf679cd58ee9b4db4dd119a05a8d-F99RKC.nc';
% msl_filename = '_grib2netcdf-atls06-98f536083ae965b31b0d04811be6f4c6-m_2nOj.nc';
% u_filename = '_grib2netcdf-atls06-a82bacafb5c306db76464bc7e824bb75-FXFIlm.nc';
% v_filename = '_grib2netcdf-atls06-a82bacafb5c306db76464bc7e824bb75-tzNG_N.nc';
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
regRadius = 2;

%% pick multi variable for space data
% one longitude
pick_lat = 20;   
for pick_lon = 40:47
    sst_mat_s = regMat(basepath,other_filename,sst,pick_lon,0,pick_time,regRadius);
    mslp_mat_s = regMat(basepath,other_filename,msl,pick_lon,0,pick_time,regRadius);
    
    u = regMat(basepath,uv_filename,uwind,pick_lon,0,pick_time,regRadius);
    v = regMat(basepath,uv_filename,vwind,pick_lon,0,pick_time,regRadius);
    
    d_mat_s = calDirection(u,v);
    
%     distance = linspace(1,lat_size,lat_size)';    
    
    u_mat_s = [sst_mat_s mslp_mat_s d_mat_s];

    filename = outExcelName(prefix,pca,pick_lon,0,pick_time,resolution);

    outfile = strcat(outpath,filename);

    xlswrite(outfile,u_mat_s);    
end

% one latitude
pick_lon = 40;   
for pick_lat = 40:47
    sst_mat_s = regMat(basepath,other_filename,sst,0,pick_lat,pick_time,regRadius);
    mslp_mat_s = regMat(basepath,other_filename,msl,0,pick_lat,pick_time,regRadius);
    
    u = regMat(basepath,uv_filename,uwind,0,pick_lat,pick_time,regRadius);
    v = regMat(basepath,uv_filename,vwind,0,pick_lat,pick_time,regRadius);
    
    d_mat_s = calDirection(u,v);

%     distance = linspace(1,lon_size,lon_size)';    
    
%     u_mat_s = [distance sst_mat_s mslp_mat_s d_mat_s];
    u_mat_s = [sst_mat_s mslp_mat_s d_mat_s];

    filename = outExcelName(prefix,pca,0,pick_lat,pick_time,resolution);

    outfile = strcat(outpath,filename);

    xlswrite(outfile,u_mat_s);    
end

% %% pick multi variable for time data
% % different point
% pick_lat = 20;   
% for pick_lon = 40:47
%     sst_mat_s = nc2mat(basepath,other_filename,sst,pick_lon,pick_lat,0);
%     mslp_mat_s = nc2mat(basepath,other_filename,msl,pick_lon,pick_lat,0);
%     
%     u = nc2mat(basepath,uv_filename,uwind,pick_lon,pick_lat,0);
%     v = nc2mat(basepath,uv_filename,vwind,pick_lon,pick_lat,0);
%     
%     d_mat_s = calDirection(u,v);
% 
% %     distance = linspace(1,time_size,time_size)';    
%     
% %     u_mat_s = [distance sst_mat_s mslp_mat_s d_mat_s];
%     u_mat_s = [sst_mat_s mslp_mat_s d_mat_s];
% 
%     filename = outExcelName(prefix,pca,pick_lon,pick_lat,0,resolution);
% 
%     outfile = strcat(outpath,filename);
% 
%     xlswrite(outfile,u_mat_s);    
% end
