% nc 0.25 degree pick data

%% global variables: the details about data see README.txt in 'D:\Code\Matlab\gpml\moi_prac\origin' file folder
%================ REMARKS : the data file setting ======================

% varname
sst = 'sst';    %sea surface temperature
msl = 'msl';   %mean sea level pressure
uwind = 'u10'; % u wind component
vwind = 'v10'; % v wind component
direct = 'd';   % wind direction
speed = 'speed'; %wind speed

% nc filename
other_filename ='20140901-20140930-sst-mslp-swh.nc';
uv_filename = '20140901-20140930-uv.nc';

% the dimension of data is lon_size * lat_size * time_size
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

% output_filename : generate by function outfilename()

pick_time = 100;
prefix = 'EC25_';
%% pick data according to longitude
pick_lat = 20;
for pick_lon = 40:47
    % 1) sea surface temperature file
    % 1a) space
    filename = outfilename(prefix,sst,pick_lon,0,pick_time,resolution);
    nc2txt(basepath,other_filename,filename,sst,pick_lon,0,pick_time);
   
    
    % 2) mean sea level pressure file
    % 2a) space
    filename = outfilename(prefix,msl,pick_lon,0,pick_time,resolution);
    nc2txt(basepath,other_filename,filename,msl,pick_lon,0,pick_time);

    % 3) u10 wind somponent file
    % 3a) space
    filename = outfilename(prefix,uwind,pick_lon,0,pick_time,resolution);
    nc2txt(basepath,uv_filename,filename,uwind,pick_lon,0,pick_time);


    % 4) v10 wind somponent file
    % 4a) space
    filename = outfilename(prefix,vwind,pick_lon,0,pick_time,resolution);
    nc2txt(basepath,uv_filename,filename,vwind,pick_lon,0,pick_time);


     % 5) wind direction and speed

    % 5a) space

    u_s = load(outfilename(prefix,uwind,pick_lon,0,pick_time,resolution))';
    v_s = load(outfilename(prefix,vwind,pick_lon,0,pick_time,resolution))';

    filename = outfilename(prefix,direct,pick_lon,0,pick_time,resolution);
    d = calDirection(u_s,v_s)';
    data2txt(basepath,filename,d);

    filename = outfilename(prefix,speed,pick_lon,0,pick_time,resolution);
    s = calSpeed(u_s,v_s)';
    data2txt(basepath,filename,s);

%     % 5c) time and space
%     % one logitude
%     u_st = load(outfilename(prefix,uwind,pick_lon,0,0,resolution))';
%     v_st = load(outfilename(prefix,vwind,pick_lon,0,0,resolution))';
% 
%     filename = outfilename(prefix,direct,pick_lon,0,0,resolution);
%     d = calDirection(u_st,v_st)';
%     data2txt(basepath,filename,d);
% 
%     filename = outfilename(prefix,speed,pick_lon,0,0,resolution);
%     s = calDirection(u_st,v_st)';
%     data2txt(basepath,filename,s);
end

%% pick data according to latitude
pick_lon = 40;
for pick_lat = 40:47
    % 1) sea surface temperature file
    % 1a) space
    filename = outfilename(prefix,sst,0,pick_lat,pick_time,resolution);
    nc2txt(basepath,other_filename,filename,sst,0,pick_lat,pick_time);
%     % 1c) time and space
%     filename = outfilename(prefix,sst,0,pick_lat,0,resolution);
%     nc2txt(basepath,other_filename,filename,sst,0,pick_lat,0);

    % 2) mean sea level pressure file
    % 2a) space
    filename = outfilename(prefix,msl,0,pick_lat,pick_time,resolution);
    nc2txt(basepath,other_filename,filename,msl,0,pick_lat,pick_time);


%     % 2c) time and space
% 
%     filename = outfilename(prefix,msl,0,pick_lat,0,resolution);
%     nc2txt(basepath,other_filename,filename,msl,0,pick_lat,0);

    % 3) u10 wind somponent file
    % 3a) space
    filename = outfilename(prefix,uwind,0,pick_lat,pick_time,resolution);
    nc2txt(basepath,uv_filename,filename,uwind,0,pick_lat,pick_time);
    

%     % 3c) time and space
%     filename = outfilename(prefix,uwind,0,pick_lat,0,resolution);
%     nc2txt(basepath,uv_filename,filename,uwind,0,pick_lat,0);

    % 4) v10 wind somponent file
    % 4a) space
    
    filename = outfilename(prefix,vwind,0,pick_lat,pick_time,resolution);
    nc2txt(basepath,uv_filename,filename,vwind,0,pick_lat,pick_time);


%     % 4c) time and space
%     
%     filename = outfilename(prefix,vwind,0,pick_lat,0,resolution);
%     nc2txt(basepath,uv_filename,filename,vwind,0,pick_lat,0);

    % 5) wind direction and speed

    % 5a) space
    % one latitude all longitude
    u_s = load(outfilename(prefix,uwind,0,pick_lat,pick_time,resolution))';
    v_s = load(outfilename(prefix,vwind,0,pick_lat,pick_time,resolution))';

    filename = outfilename(prefix,direct,0,pick_lat,pick_time,resolution);
    d = calDirection(u_s,v_s)';
    data2txt(basepath,filename,d);

    filename = outfilename(prefix,speed,0,pick_lat,pick_time,resolution);
    s = calSpeed(u_s,v_s)';
    data2txt(basepath,filename,s);

%     % 5c) time and space
%     % one latitude
%     u_st = load(outfilename(prefix,uwind,0,pick_lat,0,resolution))';
%     v_st = load(outfilename(prefix,vwind,0,pick_lat,0,resolution))';
% 
%     filename = outfilename(prefix,direct,0,pick_lat,0,resolution);
%     d = calDirection(u_st,v_st)';
%     data2txt(basepath,filename,d);
% 
%     filename = outfilename(prefix,speed,0,pick_lat,0,resolution);
%     s = calDirection(u_st,v_st)';
%     data2txt(basepath,filename,s);
end