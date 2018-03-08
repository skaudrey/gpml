% This function is for getting the prefix of file based on the
% interpolation type and variable type,just for the appropriate datafile

%@typeS : the data source type: 1 means reanalysis data from NUDT, 2 means the data from ECMWF
% @typeI : the interpolation type: 1 for space,2 for time,3 for space and time
% @typeV : the variable type: 1 for winds,2 for windu,3 for windv,4 for wind direction, 5 for vertical wind, 6 for humidity, 7 for pressure, 8 for temperature,9 for density
% @typeD : the dataset type : 1 for lon,2 for lat
function prefix = getPrefixByType(typeS,typeI,typeV,typeD)

% disp('@typeS : the data source type: 1 means reanalysis data from NUDT, 2 means the data from ECMWF');
% disp('@typeI : the interpolation type: 1 for space,2 for time,3 for space and time');
% disp('@typeV : the variable type: if typeS==1,then 1 for winds,2 for windu,3 for windv,4 for wind direction, 5 for vertical wind, 6 for humidity, 7 for pressure, 8 for temperature,9 for density; else if typeS==2, 1 for u10,2 for v10,3 for d,4 for msl,5 for sst');

prefix_S = '';prefix_I = '';prefix_V = '';prefix_D = '';

switch(typeS)
    case 1
        prefix_S = '';
    case 2
        prefix_S = 'EC_';
    case 3
        prefix_S = 'EC25_';
    case 4
        prefix_S = 'ECreg_';        
    case 5
        prefix_S = 'ECreg_';
end

switch(typeI)
    case 1
        prefix_I = 's_';
    case 2
        prefix_I = 't_';
    case 3
        prefix_I = 'st_';
end

if typeS == 1
    switch(typeV)
        case 1
            prefix_V = 'winds';
        case 2
            prefix_V = 'windu';
        case 3
            prefix_V = 'windv';
        case 4
            prefix_V = 'windd';
        case 5
            prefix_V = 'verti';
        case 6
            prefix_V = 'humity';
        case 7
            prefix_V = 'press';
        case 8
            prefix_V = 'temp';
        case 9
            prefix_V = 'dens';
    end
end
if typeS > 1 & typeS < 4
    switch(typeV)
        case 1
            prefix_V = 'u10';
        case 2
            prefix_V = 'v10';
        case 3
            prefix_V = 'd';
        case 4
            prefix_V = 'msl';
        case 5
            prefix_V = 'sst';
        case 6
            prefix_V = 'speed';
        case 7
            prefix_V = 'pca';
        case 8
            prefix_V = 'pcareg';
    end
end

if typeS>=4
    if typeV == 0
        prefix_V = '';
    elseif typeV == 7
        prefix_V = 'pca';
    end
end

% switch(typeD)
% %     case 1
% %         prefix_D = 'LON';
% %     case 2
% %         prefix_D = 'LAT';
% end
prefix_D = 'LON';

if(typeS >= 4)
    prefix_D = '';
end

prefix = strcat(prefix_S,prefix_I,prefix_V,prefix_D);