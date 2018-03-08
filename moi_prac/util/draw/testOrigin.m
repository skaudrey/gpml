% draw origin 
function testOrigin()
close all;

uv_filename = '20140901-20140930-uv.nc'; 
basepath = 'D:\Code\Matlab\gpml\moi_prac\origin\';
uall = ncread([basepath uv_filename],'u10');
vall = ncread([basepath uv_filename],'v10');
lat = ncread([basepath uv_filename],'latitude');
lon = ncread([basepath uv_filename],'longitude');
%  figure('NumberTitle','off','Name','FengGod Origin')

%------------------------------------------------------------------------
for i = 1:12
    u = [];	v = []; x_lat = []; x_lon = [];
   figure 
%     minlon = 0; maxlon = 10;
%     minlat = 25; maxlat = 35;
%     stamp = 92;
    
    [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofVMS(i,3);   
    if(maxlon<=40)
        maxlon = minlon+20;
    else
        minlon = 40;
        maxlon  = 60;
    end
    regminLat = minlat;	regmaxlat = maxlat; regminlon = 120+minlon;	regmaxlon = 120+maxlon;
    [u,v,x_lat,x_lon] = getRegMat(lat,lon,uall,vall,minlon,minlat,maxlon,maxlat,stamp);
    
%     subplot(3,4,i)
    axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
        'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
        'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
        'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
    coast = load('coast.mat'); %default file
    % worldmap([regminLat regmaxlat],[regminlon regmaxlon]);
    % load('coast.mat')
    hold on; 
    tightmap
    % spd = sqrt(u.^2+v.^2);    
    d = 5;
    % surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed
    % d=10;
    
    % quiverm for vector
    quiverm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),u(1:d:end,1:d:end),v(1:d:end,1:d:end),'blue',0.5);
    hold on;      
    geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
    

end
end

function [u,v,x_lat,x_lon] = getRegMat(lat,lon,uall,vall,minlon,minlat,maxlon,maxlat,pick_time)
u = [];	v = []; x_lat = []; x_lon = [];
%get index of region
i1 = minlon/0.125+1;
i2 = maxlon/0.125+1;
j1 = 481 - minlat/0.125;
j2 = 481 - maxlat/0.125;

% extend tha latitude and longitude map
 n=size(lat,1);
 m=size(lon,1);
 lat_t=zeros(m,n);
 lon_t=zeros(m,n);
 for j=1:m
     for jj=1:n
         lat_t(j,jj)=double(lat(jj));
         lon_t(j,jj)=double(lon(j));
     end
 end

for lon_ind = i1:i2 %longitude
    u_temp = [];v_temp = []; x_temp = []; y_temp = [];
    for lat_ind = j2:j1 %latitude        
        u_temp = [u_temp;uall(lon_ind,lat_ind,pick_time)];  %why design like this??Don't know 
        v_temp = [v_temp;vall(lon_ind,lat_ind,pick_time)];
        
        x_temp = [x_temp,double(lat_t(lon_ind,lat_ind))];
        y_temp = [y_temp,double(lon_t(lon_ind,lat_ind))];
    end
    u = [u,u_temp];
    v = [v,v_temp];
    x_lat = [x_lat;x_temp];
    x_lon = [x_lon;y_temp];
end
end



    