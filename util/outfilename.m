% generate the outfile name of picked data
function filename = outfilename(varname,lat,lon,time)

time_size = 1462;

tempName='';

if time < time_size
    tempName = strcat('EC_','s_',varname,'LON',num2str(lon));
    