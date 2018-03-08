function result =  nc2mat(basepath,ncfile,varname,lon,lat,time)
ncpath = strcat(basepath,'\',ncfile);

data = ncread(ncpath,varname);
[size_lon, size_lat,size_time] = size(data);

result = [];

% A) the space and time data
% chose all the latitude of one longitude
if (time == 0)&(lat == 0)&(lon ~=0 )
    result = zeros(size_lat*size_time,1);
    for i = 1 : size_lat
        for j = 1: size_time
%             fprintf(f, '%.8f', data(lon,i, j));fprintf(f, ',');
            result(i*size_lon + size_time) = data(lon,i, j);
        end
       
    end
end
% choose all the longitude of one latitude
if (time == 0)&(lat ~= 0)&(lon ==0 )
    result = zeros(size_lon*size_time,1);
    for i = 1 : size_lon
        for j = 1: size_time
%             fprintf(f, '%.8f', data(i,lat, j));fprintf(f, ',');
            result(i*size_lon + size_time) = data(i,lat, j);
        end
        fprintf(f, ',');
    end
end


% B) the time data
if (time == 0)&(lat ~= 0)&(lon ~=0 )
    result = zeros(size_time,1);
    for j = 1: size_time
%         fprintf(f, '%.8f', data(lon,lat, j)); fprintf(f, ',');
         result(j) = data(lon,lat, j);
    end
end

% C) the space data
% chose all the latitude of one longitude
if (time ~= 0) & (lat == 0)
     result = zeros(size_lat,1);
     for j = 1: size_lat
         result(j) = data(lon,j, time);
%         fprintf(f, '%.8f', data(lon,j, time)); 
%         fprintf(f, ',');
     end
end
% choose all the longitude of one latitude
if (time ~= 0) & (lon == 0)
    result = zeros(size_lon,1);
     for j = 1: size_lon
%         fprintf(f, '%.8f', data(j,lat, time)); 
%         fprintf(f, ',');
         result(j) = data(j,lat, time);
     end
end