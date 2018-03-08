% filetype: 1 for xls ,2  for mat , 3 for txt
% just for space data
function filename = outRegName(prefix,varname,minlon,minlat,maxlon,maxlat,filetype,stamp)

% no need to consider the time or latitude or longitude
region = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat)];
if(stamp ~= 0)
    region = [region 'stamp' num2str(stamp)];
end
suffix = '';
switch(filetype)
    case 1
        suffix = '.xls';
        region = strrep(region,'.',',');
        filename = strcat(prefix,'s_',varname,region,suffix);
    case 2
        suffix = '.mat';
        filename = strcat(prefix,'s_',region,suffix);
    case 3
        suffix = '.txt';
end        



