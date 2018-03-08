% generate filename of picked data

% the lat = 0 means all the latitude
% time = 0 means the all the time size
% the parameter lon won't be 0 cause always choose data based on longitude

function filename = outfilename(prefix,varname,lon,lat,time,resolution)

filename = '';
% prefix = 'EC_';

% A) the space and time data
% chose all the latitude of one longitude
if (time == 0)&(lat == 0)&(lon ~=0 )
    filename = strcat(prefix,'st_',varname,'LON',num2str(lon*resolution),'.txt');
end
% choose all the longitude of one latitude
if (time == 0)&(lat ~= 0)&(lon ==0 )
    filename = strcat(prefix,'st_',varname,'LAT',num2str(lat*resolution),'.txt');
end

% B) the time data
if (time == 0)&(lat ~= 0)&(lon ~=0 )
    filename = strcat(prefix,'t_',varname,'LON',num2str(lon*resolution),'.txt');
end

% C) the space data
% chose all the latitude of one longitude
if (time ~= 0) & (lat == 0)
    filename = strcat(prefix,'s_',varname,'LON',num2str(lon*resolution),'.txt');
end
% choose all the longitude of one latitude
if (time ~= 0) & (lon == 0)
    filename = strcat(prefix,'s_',varname,'LAT',num2str(lat*resolution),'.txt');
end