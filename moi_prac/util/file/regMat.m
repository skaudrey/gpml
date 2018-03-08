% function pick one region of sst,mslp,d for one latitude or one longitude

function mat = regMat(basepath,filename,varname,pick_lon,pick_lat,pick_time,regRadius)

mat = [];
% chose all the latitude of one longitude
% if (pick_time == 0)&(pick_lat == 0)&(pick_lon ~=0 )
%     minlon = pick_lon-regRadius;maxlon = pick_lon+regRadius;
%     for lon = minlon:maxlon
%         mat_temp = nc2mat(basepath,filename,varname,lon,pick_lat,pick_time);
%         mat = [mat,mat_temp];
%     end
% end
% % choose all the longitude of one latitude
% if (pick_time == 0)&(pick_lat ~= 0)&(pick_lon ==0 )
%    minlat = pick_lat-regRadius;maxlat = pick_lat+regRadius;
%    for lat = minlat:maxlat
%         mat_temp = nc2mat(basepath,filename,varname,pick_lon,lat,pick_time);
%         mat = [mat,mat_temp];
%    end
% end

% B) the time data
% if (pick_time == 0)&(pick_lat ~= 0)&(pick_lon ~=0 )
%     
% end

% C) the space data
% chose all the latitude of one longitude
if (pick_time ~= 0) & (pick_lat == 0)
    minlon = pick_lon-regRadius;maxlon = pick_lon+regRadius;
    for lon = minlon:maxlon
        mat_temp = nc2mat(basepath,filename,varname,lon,pick_lat,pick_time);
        mat = [mat,mat_temp];
    end
end
% choose all the longitude of one latitude
if (pick_time ~= 0) & (pick_lon == 0)
   minlat = pick_lat-regRadius;maxlat = pick_lat+regRadius;
   for lat = minlat:maxlat
        mat_temp = nc2mat(basepath,filename,varname,pick_lon,lat,pick_time);
        mat = [mat,mat_temp];
   end
end