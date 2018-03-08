% 生成 excel 文件
function filename = outExcelName(prefix,varname,lon,lat,time,resolution)


filename = '';

% A) the space and time data
% chose all the latitude of one longitude
if (time == 0)&(lat == 0)&(lon ~=0 )
    region = strrep(num2str(lon*resolution),'.',',');
    filename = strcat(prefix,'st_',varname,'LON',region,'.xls');
end
% choose all the longitude of one latitude
if (time == 0)&(lat ~= 0)&(lon ==0 )
    region = strrep(num2str(lat*resolution),'.',',');
    filename = strcat(prefix,'st_',varname,'LAT',region,'.xls');
end

% B) the time data
if (time == 0)&(lat ~= 0)&(lon ~=0 )
    region = strrep(num2str(lon*resolution),'.',',');
    filename = strcat(prefix,'t_',varname,'LON',region,'.xls');
end

% C) the space data
% chose all the latitude of one longitude
if (time ~= 0) & (lat == 0)
    region = strrep(num2str(lon*resolution),'.',',');
    filename = strcat(prefix,'s_',varname,'LON',region,'.xls');
end
% choose all the longitude of one latitude
if (time ~= 0) & (lon == 0)
    region = strrep(num2str(lat*resolution),'.',',');
    filename = strcat(prefix,'s_',varname,'LAT',region,'.xls');
end