% distance preprocessing

% cause the dataset I made isn't the region when it comes to space
% interpolation, how to make gpml deal with the region??% This script is for changing the nc file to txt file
%==================== nc2txt function ===========================
%@ncfile: the file name of nc
% REMARKS: the nc file I dowaloaded is from 2009-1-1 to 2010-1-1,day 

function ncReg2txt(basepath,ncfile,outfile,varname,minlon,minlat,maxlon,maxlat,time)

ncpath = strcat(basepath,'\',ncfile);
outpath = strcat(basepath,'\',outfile);

data = ncread(ncpath,varname);
[size_lon, size_lat,size_time] = size(data);
f = fopen(outpath, 'wt');

% the space and time data
if (time == 0)&(lat == 0)&(lon ~=0 )
    for i = 1 : size_lat
        for j = 1: size_time
            fprintf(f, '%.8f', data(lon,i, j));fprintf(f, ',');
        end
        fprintf(f, ',');
    end
end

% the time data
if (time == 0)&(lat ~= 0)&(lon ~=0 )
    for j = 1: size_time
        fprintf(f, '%.8f', data(lon,lat, j)); fprintf(f, ',');
    end
end

% the space data
if time ~= 0
     for j = 1: size_lat
        fprintf(f, '%.8f', data(lon,j, time)); 
        fprintf(f, ',');
     end
end


fclose(f);