function mapDraw(minlat,minlon,maxlat,maxlon,uAll,vAll,regminLat,regminlon,regmaxlat,regmaxlon,offflag,mIndex,colorMax,spIndex,annot)
%% global varaibles
if (offflag == 1)
    close all;
end
rawReso = 0.125;    postReso = 0.25;
[x_lat,x_lon] = latlonMat(minlat,minlon,maxlat,maxlon,rawReso,postReso);

mName = {'A','mult','APS','APP','MPP','MPS','SP','PA','PAP','PAS','MAP','MAS'};
methodIndex = mod(mIndex,size(mName,2))-1;

titlename = mName{methodIndex};
% %% draw
% 
% 
% figure;
% %------------------------------------------------------------------------
% subplot(131)
% u = uAll{1};    v = vAll{1};
% axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
%     'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
%     'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
%     'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
% coast = load('coast.mat'); %default file
% hold on; 
% tightmap
% spd = sqrt(u.^2+v.^2);    
% d=1;
% surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed
% 
% d=10;
% 
% % quiverm for vector
% %                  quiverm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),-u_ret(1:d:end,1:d:end),v_ret(1:d:end,1:d:end),'blue',0.5);
% hold on;      
% geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
% % Put colorbar.
% colormap('Jet');
% if(colorMax~=0)
%     caxis([0,colorMax]) % change caxis
% end
% h=colorbar('v');
% set(get(h,'ylabel'),'string','Spd', 'FontSize', 10);
% % Set unit's title.
% units='m/s';
% set(get(h, 'title'), 'string', units, ...
%     'FontSize', 10, 'FontWeight','normal', ...
%     'Interpreter', 'none');
% if(size(annot) == 0)
%     title('origin');
% else
%     title(annot{1});
% end
% %------------------------------------------------------------------------
% subplot(132)
% u = uAll{mIndex};    v = vAll{mIndex};
% axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
%     'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
%     'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
%     'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
% coast = load('coast.mat'); %default file
% hold on; 
% tightmap
% spd = sqrt(u.^2+v.^2);         
% d=1;
% surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed
% % surfm(xlat(1:d:end,1:d:end),xlon(1:d:end,1:d:end),pgrd(1:d:end,1:d:end));
% d=10;
% 
% % quiverm for vector
% %                  quiverm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),-u_ret(1:d:end,1:d:end),v_ret(1:d:end,1:d:end),'blue',0.5);
% hold on;      
% geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
% % Put colorbar.
% colormap('Jet');
% if(colorMax~=0)
%     caxis([0,colorMax]) % change caxis
% end
% h=colorbar('v');
% set(get(h,'ylabel'),'string','Spd', 'FontSize', 10);
% % Set unit's title.
% units='m/s';
% set(get(h, 'title'), 'string', units, ...
%     'FontSize', 10, 'FontWeight','normal', ...
%     'Interpreter', 'none');
% if(size(annot) == 0)
%    title(titlename);
% else
%     title(annot{2});
% end
% 
% %------------------------------------------------------------------------
% subplot(133)
% u = uAll{spIndex};    v = vAll{spIndex};
% axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
%     'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
%     'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
%     'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
% coast = load('coast.mat'); %default file
% hold on; 
% tightmap
% spd = sqrt(u.^2+v.^2);              
% %                  spd( flag == 0)     = NaN;
% d=1;
% surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed
% % surfm(xlat(1:d:end,1:d:end),xlon(1:d:end,1:d:end),pgrd(1:d:end,1:d:end));
% d=10;
% 
% % quiverm for vector
% %                  quiverm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),-u_ret(1:d:end,1:d:end),v_ret(1:d:end,1:d:end),'blue',0.5);
% hold on;      
% geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
% % Put colorbar.
% colormap('Jet');
% if(colorMax~=0)
%     caxis([0,colorMax]) % change caxis
% end
% h=colorbar('v');
% set(get(h,'ylabel'),'string','Spd', 'FontSize', 10);
% % Set unit's title.
% units='m/s';
% set(get(h, 'title'), 'string', units, ...
%     'FontSize', 10, 'FontWeight','normal', ...
%     'Interpreter', 'none');
% if(size(annot) == 0)
%    title('spline');
% else
%     title(annot{3});
% end

%% quiver
figure;
%------------------------------------------------------------------------
subplot(231)
u = uAll{1};    v = vAll{1};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
coast = load('coast.mat'); %default file
hold on; 
tightmap
spd = sqrt(u.^2+v.^2);    
d=1;
surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed

% d=10;

% quiverm for vector
d=3;
quiverm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),u(1:d:end,1:d:end),v(1:d:end,1:d:end),'blue',0.5);
hold on;      
geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
% Put colorbar.
colormap('Jet');
% caxis([0,5]) % change caxis
h=colorbar('v');
set(get(h,'ylabel'),'string','Spd', 'FontSize', 10);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', 10, 'FontWeight','normal', ...
    'Interpreter', 'none');
if(size(annot) == 0)
   title('origin');
else
    title(annot{1});
end
%------------------------------------------------------------------------
subplot(232)
u = uAll{mIndex};    v = vAll{mIndex};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
coast = load('coast.mat'); %default file
hold on; 
tightmap
spd = sqrt(u.^2+v.^2);         
d=1;
surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed
% quiverm for vector
d = 3;
quiverm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),u(1:d:end,1:d:end),v(1:d:end,1:d:end),'blue',0.5);
hold on;      
geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
% Put colorbar.
colormap('Jet');
% caxis([0,5]) % change caxis
h=colorbar('v');
set(get(h,'ylabel'),'string','Spd', 'FontSize', 10);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', 10, 'FontWeight','normal', ...
    'Interpreter', 'none');
if(size(annot) == 0)
   title(titlename);
else
    title(annot{2});
end
%------------------------------------------------------------------------
subplot(233)
u = uAll{spIndex};    v = vAll{spIndex};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
coast = load('coast.mat'); %default file
hold on; 
tightmap
spd = sqrt(u.^2+v.^2);              
%                  spd( flag == 0)     = NaN;
d=1;
surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed
% quiverm for vector
d = 3;
quiverm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),u(1:d:end,1:d:end),v(1:d:end,1:d:end),'blue',0.5);
hold on;      
geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
% Put colorbar.
colormap('Jet');
% caxis([0,5]) % change caxis
h=colorbar('v');
set(get(h,'ylabel'),'string','Spd', 'FontSize', 10);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', 10, 'FontWeight','normal', ...
    'Interpreter', 'none');
if(size(annot) == 0)
   title('spline');
else
    title(annot{3});
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% draw diff
mName = {'A','mult','APS','APP','MPP','MPS','SP','PA','PAP','PAS','MAP','MAS'};
methodIndex = mod(mIndex,size(mName,2))-1;
titlename = mName{methodIndex};

spd0 = sqrt(uAll{1}.^2+vAll{1}.^2);  
%------------------------------------------------------------------------
subplot(234)
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
subplot(235)
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

subplot(236)
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
   title('diff spline');
else
    title(['diff ',annot{3}]);
end