% show pictures of reused interpolated picture and raw interpolated method
% and origin figure
function compReusedAndMlpPic()
close all
basepath = [cd,'/moi_prac/reuse/typhoon/kamurri/'];

prefix_s = 'Inter_kamurri';
tyName = 'kam';

reuse_suffix = '_reuse_p_smds';
mat_suffix = '.mat';
annot = {'true','k_{vmp}','spline','BP'};

suffix = '-k-bp-sp';
re_Inter = load([basepath,prefix_s,reuse_suffix,mat_suffix]);
% raw_Inter = load([basepath,prefix_s,mat_suffix]);

reg_size = size(re_Inter.rmse,2);
reg_ind = [5];
for i =1:reg_size
% for j = 1:size(reg_ind,2)
%     i = reg_ind(j);
    [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofKamurri(i);
    minlon = 120+minlon;    maxlon = 120+maxlon;
    regminLat = minlat;     regmaxlat = maxlat;
    regminlon = minlon;	regmaxlon = maxlon;
    
    u0 = re_Inter.u{i}{1};
    reuse_u = re_Inter.u{i}{2};
    sp_u = re_Inter.u{i}{3};
    bp_u = re_Inter.u{i}{4};
    v0 = re_Inter.v{i}{1};
    reuse_v = re_Inter.v{i}{2};
    sp_v = re_Inter.v{i}{3};
    bp_v = re_Inter.v{i}{4};
    
    lat = double(re_Inter.lat_map{i});
    lon = double(re_Inter.lon_map{i});
    
    
    u_draw = {u0,reuse_u,sp_u,bp_u};
    v_draw = {v0,reuse_v,sp_v,bp_v};
    
    
    index = 2;
    offflag = 0;
    spIndex = 3;
    colorMax = 0;
%     mapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,annot,tyName,suffix,i,basepath);
%     diffMapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,0,spIndex,annot);
%     drawInsub(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,annot,tyName,suffix,i,basepath);
      drawManualPosition(lat,lon,minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,annot,tyName,suffix,i,basepath);
end
end

function mapDraw(x_lat,x_lon,minlat,minlon,maxlat,maxlon,uAll,vAll,regminLat,regminlon,regmaxlat,regmaxlon,offflag,mIndex,colorMax,spIndex,annot,tyName,suffix,regInd,basepath)
%% global varaibles
if (offflag == 1)
    close all;
end

rawReso = 0.125;    postReso = 0.25;
% [x_lat,x_lon] = latlonMat(minlat,minlon,maxlat,maxlon,rawReso,postReso);

mName = {'A','mult','APS','APP','MPP','MPS','SP','PA','PAP','PAS','MAP','MAS'};
methodIndex = mod(mIndex,size(mName,2))-1;

titlename = mName{methodIndex};
fontsize = 12;
%% quiver
figure;
%------------------------------------------------------------------------
% subplot(221)
set(gcf,'position',[0 0 1200 950]);
u = uAll{1};    v = vAll{1};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', fontsize,'MLabelParallel','south','FLineWidth',1.0);
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
h=colorbar('v','FontSize',fontsize);
% set(get(h,'ylabel'),'string','Spd', 'FontSize', 36);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', fontsize, 'FontWeight','normal', ...
    'Interpreter', 'none');
annotation('textbox',...
     [0.0015 0.94 0.05 0.064],...
    'String','(a)',...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');
axis normal
% filename  = [basepath,tyName,'-',num2str(regInd),suffix,'-1.eps'];
% saveas(gca,filename,'psc2');
%------------------------------------------------------------------------
figure
set(gcf,'position',[0 0 1500 1000]);
% subplot(222)
u = uAll{mIndex};    v = vAll{mIndex};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize',fontsize,'MLabelParallel','south','FLineWidth',1.0);
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
h=colorbar('v','FontSize',fontsize);
% set(get(h,'ylabel'),'string','Spd', 'FontSize', 36);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', fontsize, 'FontWeight','normal', ...
    'Interpreter', 'none');
annotation('textbox',...
     [0.0015 0.94 0.05 0.064],...
    'String','(b)',...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');
axis normal
% filename  = [basepath,tyName,'-',num2str(regInd),suffix,'-2.eps'];
% saveas(gca,filename,'psc2');
%------------------------------------------------------------------------
figure
set(gcf,'position',[0 0 1600 950]);
% subplot(223)
u = uAll{spIndex};    v = vAll{spIndex};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize',fontsize,'MLabelParallel','south','FLineWidth',1.0);
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
h=colorbar('v','FontSize',fontsize);
% set(get(h,'ylabel'),'string','Spd', 'FontSize', 36);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', fontsize, 'FontWeight','normal', ...
    'Interpreter', 'none');
annotation('textbox',...
     [0.0015 0.94 0.05 0.064],...
    'String','(c)',...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');
axis normal
% filename  = [basepath,tyName,'-',num2str(regInd),suffix,'-3.eps'];
% saveas(gca,filename,'psc2');
%--------------------------------------------------------------------------
figure;
set(gcf,'position',[0 0 1500 1000]);
% subplot(224)
u = uAll{4};    v = vAll{4};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize',fontsize,'MLabelParallel','south','FLineWidth',1.0);
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
h=colorbar('v','FontSize',fontsize);
% set(get(h,'ylabel'),'string','Spd', 'FontSize', 36);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize',fontsize, 'FontWeight','normal', ...
    'Interpreter', 'none');
annotation('textbox',...
    [0.0015 0.94 0.05 0.064],...
    'String','(d)',...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');
axis normal
% filename  = [basepath,tyName,'-',num2str(regInd),suffix,'-4.eps'];
% saveas(gca,filename,'psc2');
% % set index
% % Create textbox
% annotation('textbox',...
%     [0.16 0.9 0.02 0.03],...
%     'String',{'(a)'},...
%     'LineStyle','none',...
%     'FontSize',36,...
%     'FitBoxToText','off');
% 
% % Create textbox
% annotation('textbox',...
%     [0.6 0.9 0.02 0.03],'String','(b)',...
%     'LineStyle','none',...
%     'FontSize',36,...
%     'FitBoxToText','off');
% 
% % Create textbox
% annotation('textbox',...
%     [0.16 0.42 0.02 0.03],...
%     'String','(c)',...
%     'LineStyle','none',...
%     'FontSize',36,...
%     'FitBoxToText','off');
% 
% % Create textbox
% annotation('textbox',...
%     [0.6 0.42 0.02 0.03],...
%     'String','(d)',...
%     'LineStyle','none',...
%     'FontSize',36,...
%     'FitBoxToText','off');
end

function drawInsub(x_lat,x_lon,minlat,minlon,maxlat,maxlon,uAll,vAll,regminLat,regminlon,regmaxlat,regmaxlon,offflag,mIndex,colorMax,spIndex,annot,tyName,suffix,regInd,basepath)
%% global varaibles
close all;

rawReso = 0.125;    postReso = 0.25;
% [x_lat,x_lon] = latlonMat(minlat,minlon,maxlat,maxlon,rawReso,postReso);

mName = {'A','mult','APS','APP','MPP','MPS','SP','PA','PAP','PAS','MAP','MAS'};
methodIndex = mod(mIndex,size(mName,2))-1;

titlename = mName{methodIndex};
%% quiver
figure1 = figure;
set(gcf,'position',[0 0 1100 1000]);
%------------------------------------------------------------------------
subplot1 = subplot(2,2,1,'Parent',figure1)
u = uAll{1};    v = vAll{1};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', fontsize,'MLabelParallel','south','FLineWidth',1.0);

% text('Parent',subplot1,'Tag','MLabel','VerticalAlignment','baseline',...
%     'HorizontalAlignment','center',...
%     'FontSize',30,...
%     'String',{'',' 145^{\circ} E'},...
%     'Position',[-0.0453449841058553 0.261799387799149 0],...
%     'Color',[0.15 0.15 0.15]);
% 
% % Create text
% text('Parent',subplot1,'Tag','MLabel','VerticalAlignment','baseline',...
%     'HorizontalAlignment','center',...
%     'FontSize',30,...
%     'String',{'',' 150^{\circ} E'},...
%     'Position',[0.0302299894039037 0.261799387799149 0],...
%     'Color',[0.15 0.15 0.15]);

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
% h=colorbar('v','FontSize',30);
% % set(get(h,'xlabel'),'string','Spd', 'FontSize', 24);
% % Set unit's title.
% units='m/s';
% set(get(h, 'title'), 'string', units, ...
%     'FontSize',30, 'FontWeight','normal', ...
%     'Interpreter', 'none');

axis normal
% filename  = [basepath,tyName,'-',num2str(regInd),suffix,'-1.eps'];
% saveas(gca,filename,'psc2');
%------------------------------------------------------------------------

subplot(222)
u = uAll{mIndex};    v = vAll{mIndex};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', 9,'MLabelParallel','south','FLineWidth',1.0);
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
% h=colorbar('v','FontSize',30);
% % set(get(h,'xlabel'),'string','Spd', 'FontSize', 24);
% % Set unit's title.
% units='m/s';
% set(get(h, 'title'), 'string', units, ...
%     'FontSize', 30, 'FontWeight','normal', ...
%     'Interpreter', 'none');

axis normal
% filename  = [basepath,tyName,'-',num2str(regInd),suffix,'-2.eps'];
% saveas(gca,filename,'psc2');
%------------------------------------------------------------------------

subplot3 = subplot(223)
u = uAll{spIndex};    v = vAll{spIndex};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize',9,'MLabelParallel','south','FLineWidth',1.0);

% setm(gca,'Tag','MLabel','VerticalAlignment','baseline');

% ('VerticalAlignment','center','HorizontalAlignment','center');
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

% % caxis([0,5]) % change caxis
% h=colorbar('v','FontSize',30);
% % set(get(h,'xlabel'),'string','Spd', 'FontSize', 24);
% % Set unit's title.
% units='m/s';
% set(get(h, 'title'), 'string', units, ...
%     'FontSize', 30, 'FontWeight','normal', ...
%     'Interpreter', 'none');

axis normal
% filename  = [basepath,tyName,'-',num2str(regInd),suffix,'-3.eps'];
% saveas(gca,filename,'psc2');
%--------------------------------------------------------------------------

subplot(224)
u = uAll{4};    v = vAll{4};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize',9,'MLabelParallel','south','FLineWidth',1.0);
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
% h=colorbar('v','FontSize',30);
% % set(get(h,'xlabel'),'string','Spd', 'FontSize', 24);
% % Set unit's title.
% units='m/s';
% set(get(h, 'title'), 'string', units, ...
%     'FontSize', 30, 'FontWeight','normal', ...
%     'Interpreter', 'none');

axis normal




% % set index
% % Create textbox
annotation('textbox',...
    [0.085 0.96 0.02 0.03],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');

% Create textbox
annotation('textbox',...
    [0.522 0.96 0.02 0.03],'String','(b)',...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');

% Create textbox
annotation('textbox',...
    [0.085 0.485 0.02 0.03],...
    'String','(c)',...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');

% Create textbox
annotation('textbox',...
    [0.522 0.485 0.02 0.03],...
    'String','(d)',...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');

% Put colorbar.
colormap('Jet');

% caxis([0,5]) % change caxis
h=colorbar('h','FontSize',fontsize,'Position',[0.33,0.05,0.35,0.03]);
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', fontsize, 'FontWeight','normal', ...
    'Interpreter', 'none');
end

function drawManualPosition(x_lat,x_lon,minlat,minlon,maxlat,maxlon,uAll,vAll,regminLat,regminlon,regmaxlat,regmaxlon,offflag,mIndex,colorMax,spIndex,annot,tyName,suffix,regInd,basepath)

top_margin = 0.08;  
btm_margin = 0.25;
left_margin = 0.15;
right_margin = 0.1;

subfig_margin = 0.1;  %margin between subfigures

row = 2;
col = 2;

[fig_position,colorbar_position] = sharecolorbar(top_margin,btm_margin,left_margin,right_margin,subfig_margin,row,col);

 u = uAll{1};    v = vAll{1};
 spd = sqrt(u.^2+v.^2);    
 
 clim = [min(min(spd)),max(max(spd))];
% close all;

rawReso = 0.125;    postReso = 0.25;
% [x_lat,x_lon] = latlonMat(minlat,minlon,maxlat,maxlon,rawReso,postReso);

mName = {'A','mult','APS','APP','MPP','MPS','SP','PA','PAP','PAS','MAP','MAS'};
methodIndex = mod(mIndex,size(mName,2))-1;
fontsize = 12;
titlename = mName{methodIndex};
%% quiver
figure;
set(gcf,'position',[0 0 1000 1000]);
%------------------------------------------------------------------------
subfig_index = 1;
for i = 1:row
    for j = 1:col

%         subplot1 = subplot(row,col,i,'Parent',figure1)

        u = uAll{subfig_index};    v = vAll{subfig_index};
        
        axes('position',fig_position{subfig_index});
        
        axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
            'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
            'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
            'GLineWidth',1.0,'FontSize', fontsize,'MLabelParallel','south','FLineWidth',1.0);

        coast = load('coast.mat'); %default file
        hold on; 
        tightmap
        spd = sqrt(u.^2+v.^2);    
        d=1;
        spd = spd';
        surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed

        % d=10;

        % quiverm for vector
        d=3;
        quiverm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),u(1:d:end,1:d:end)',v(1:d:end,1:d:end)','black',0.5);
%         m_quiver(x_lon(1:d:end,1:d:end),x_lat(1:d:end,1:d:end),u(1:d:end,1:d:end),v(1:d:end,1:d:end),3);
        hold on;      
        geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
        % Put colorbar.
        colormap('Jet');
%        axis normal
       
        subfig_index = subfig_index + 1;
        
    end
end

% draw colorbar
axes('position',colorbar_position);
axis off% must be added unless you wanna an empty coordinate
h=colorbar('h','FontSize',fontsize);
% Set unit's title.
set(get(h,'ylabel'),'string','Spd', 'FontSize', fontsize);
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize',fontsize, 'FontWeight','normal', ...
    'Interpreter', 'none');
caxis([0,clim(2)]);

annotation('textbox',...
    [0.085-0.05 0.96 0.02 0.03],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');

% Create textbox
annotation('textbox',...
    [0.522-0.05 0.96 0.02 0.03],'String','(b)',...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');

% Create textbox
annotation('textbox',...
    [0.085-0.05 0.578 0.02 0.03],...
    'String','(c)',...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');

% Create textbox
annotation('textbox',...
    [0.522-0.05 0.578 0.02 0.03],...
    'String','(d)',...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');

end