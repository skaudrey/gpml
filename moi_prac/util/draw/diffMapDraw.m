function diffMapDraw(minlat,minlon,maxlat,maxlon,uAll,vAll,regminLat,regminlon,regmaxlat,regmaxlon,offflag,mIndex,colorMax,spIndex,annot)

mName = {'A','mult','APS','APP','MPP','MPS','SP','PA','PAP','PAS','MAP','MAS'};
methodIndex = mod(mIndex,size(mName,2))-1;


titlename = mName{methodIndex};

% if (offflag == 1)
%     close all;
% end
rawReso = 0.125;    postReso = 0.25;
[x_lat,x_lon] = latlonMat(minlat,minlon,maxlat,maxlon,rawReso,postReso);

spd0 = sqrt(uAll{1}.^2+vAll{1}.^2);  
figure;
%------------------------------------------------------------------------
subplot(131)
u = uAll{mIndex};    v = vAll{mIndex};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
coast = load('coast.mat'); %default file
hold on; 
tightmap
spd = spd0 - sqrt(u.^2+v.^2);    
d=1;
surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed
hold on;      
geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
% Put colorbar.
colormap('Jet');
if(colorMax~=0)
    caxis([0,colorMax]) % change caxis
end
h=colorbar('v');
set(get(h,'ylabel'),'string','Spd', 'FontSize', 10);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', 10, 'FontWeight','normal', ...
    'Interpreter', 'none');
if(size(annot) == 0)
   title(['diff ',titlename]);
else
    title(['diff ',annot{2}]);
end
%------------------------------------------------------------------------
subplot(132)
u = uAll{spIndex};    v = vAll{spIndex};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
coast = load('coast.mat'); %default file
hold on; 
tightmap
spd = spd0 - sqrt(u.^2+v.^2);      
d=1;
surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed
hold on;      
geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
hold on;
% Put colorbar.
colormap('Jet');
if(colorMax~=0)
    caxis([0,colorMax]) % change caxis
end
h=colorbar('v');
set(get(h,'ylabel'),'string','Spd', 'FontSize', 10);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', 10, 'FontWeight','normal', ...
    'Interpreter', 'none');
if(size(annot) == 0)
   title('diff spline');
else
    title(['diff ',annot{3}]);
end
%------------------------------------------------------------------------
subplot(133)
u = uAll{4};    v = vAll{4};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
coast = load('coast.mat'); %default file
hold on; 
tightmap
spd = spd0 - sqrt(u.^2+v.^2);      
d=1;
surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed
hold on;      
geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
hold on;
% Put colorbar.
colormap('Jet');
if(colorMax~=0)
    caxis([0,colorMax]) % change caxis
end
h=colorbar('v');
set(get(h,'ylabel'),'string','Spd', 'FontSize', 10);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', 10, 'FontWeight','normal', ...
    'Interpreter', 'none');
if(size(annot) == 0)
   title('diff BP');
else
    title(['diff ',annot{4}]);
end
%------------------------------------------------------------------------