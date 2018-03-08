% show pictures of reused interpolated picture and raw interpolated method
% and origin figure
function compReusedAndMlpDiffPic()
close all
basepath = [cd,'/','moi_prac','/','reuse','/','typhoon','/'];

% prefix_s = 'Inter_seagull';
prefix_s = 'Inter_fenggod';

reuse_suffix = '_reuse_p';
mat_suffix = '.mat';
annot = {'','diff k_{vmp}','spline','BP'};
re_Inter = load([basepath,prefix_s,reuse_suffix,mat_suffix]);
% raw_Inter = load([basepath,prefix_s,mat_suffix]);

reg_size = size(re_Inter.rmse,2);

reg_ind = [1,5];
% for j =1:2
for i = 1:reg_size
%     i = reg_ind(j);
    [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofFengGod(i);
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
    
%     lat = re_Inter.lat_map{i};
%     lon = re_Inter.lon_map{i};
    
    
    u_draw = {u0,reuse_u,sp_u,bp_u};
    v_draw = {v0,reuse_v,sp_v,bp_v};
    
    
    index = 2;
    offflag = 0;
    spIndex = 3;
    colorMax = 0;
%     mapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,annot);
%     diffMapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,0,spIndex,annot);
%     mapDrawManul(lat,lon,minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,annot);
 mapDrawManul(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,annot);
end
end

function mapDraw(x_lat,x_lon,minlat,minlon,maxlat,maxlon,uAll,vAll,regminLat,regminlon,regmaxlat,regmaxlon,offflag,mIndex,colorMax,spIndex,annot)
%% global varaibles
if (offflag == 1)
    close all;
end
rawReso = 0.125;    postReso = 0.25;
[x_lat,x_lon] = latlonMat(minlat,minlon,maxlat,maxlon,rawReso,postReso);

mName = {'A','mult','APS','APP','MPP','MPS','SP','PA','PAP','PAS','MAP','MAS'};
methodIndex = mod(mIndex,size(mName,2))-1;

titlename = mName{methodIndex};
rawReso = 0.125;    postReso = 0.25;
[x_lat,x_lon] = latlonMat(minlat,minlon,maxlat,maxlon,rawReso,postReso);

spd0 = sqrt(uAll{1}.^2+vAll{1}.^2);  

fontSize = 16;

figure1 = figure;
% set(gcf,'position',[0 0 1600 950]);
%------------------------------------------------------------------------
subplot1 = subplot(1,3,1,'Parent',figure1,'GridLineStyle','--',...
    'FontSize',fontSize,...
    'XTick',[]);
box(subplot1,'on');
hold(subplot1,'on');
u = uAll{mIndex};    v = vAll{mIndex};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', fontSize,'MLabelParallel','south','FLineWidth',1.0);
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


h=colorbar('h','Position',...
    [0.138 0.17-0.1 0.2 0.025], 'FontSize', fontSize);
set(get(h,'title'),'string','Speed error', 'FontSize', fontSize);

%------------------------------------------------------------------------
subplot1 = subplot(1,3,2,'Parent',figure1,'GridLineStyle','--',...
    'FontSize',12,...
    'XTick',[]);
box(subplot1,'on');
hold(subplot1,'on');
u = uAll{spIndex};    v = vAll{spIndex};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', fontSize,'MLabelParallel','south','FLineWidth',1.0);
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
h=colorbar('h','Position',...
    [0.42 0.17-0.1 0.2 0.025], 'FontSize', fontSize);
set(get(h,'title'),'string','Speed error', 'FontSize', fontSize);

%------------------------------------------------------------------------
subplot1 = subplot(1,3,3,'Parent',figure1,'GridLineStyle','--',...
    'FontSize',12,...
    'XTick',[]);
box(subplot1,'on');
hold(subplot1,'on');
u = uAll{4};    v = vAll{4};
axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
    'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
    'GLineWidth',1.0,'FontSize', fontSize,'MLabelParallel','south','FLineWidth',1.0);
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
h=colorbar('h','Position',...
    [0.7 0.17-0.1 0.2 0.025],'FontSize',fontSize);
set(get(h,'title'),'string','Speed error', 'FontSize', fontSize);
%------------------------------------------------------------------------


% Create textbox
annotation('textbox',...
    [0.080625 0.8 0.02 0.03],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontSize+4);


% Create textbox
annotation('textbox',...
    [0.361666666666667 0.8 0.02 0.03],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontSize+4);

% Create textbox
annotation('textbox',...
    [0.642708333333333 0.8 0.02 0.03],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',fontSize+4);
end

% function mapDrawManul(x_lat,x_lon,minlat,minlon,maxlat,maxlon,uAll,vAll,regminLat,regminlon,regmaxlat,regmaxlon,offflag,mIndex,colorMax,spIndex,annot)
function mapDrawManul(minlat,minlon,maxlat,maxlon,uAll,vAll,regminLat,regminlon,regmaxlat,regmaxlon,offflag,mIndex,colorMax,spIndex,annot)
    top_margin = 0.01;  
    btm_margin = 0.25;
    left_margin = 0.15;
    right_margin = 0.1;

    subfig_margin = 0.1;  %margin between subfigures

    row = 1;
    col = 3;

    [fig_position,colorbar_position] = sharecolorbar(top_margin,btm_margin,left_margin,right_margin,subfig_margin,row,col);

     u = uAll{1};    v = vAll{1};
     spd = sqrt(u.^2+v.^2);    

     clim = [min(min(spd)),max(max(spd))];
         
     index = [mIndex,spIndex,4];
     fontsize = 12;
     %% global varaibles
    if (offflag == 1)
        close all;
    end
    rawReso = 0.125;    postReso = 0.25;
    [x_lat,x_lon] = latlonMat(minlat,minlon,maxlat,maxlon,rawReso,postReso);

    mName = {'A','mult','APS','APP','MPP','MPS','SP','PA','PAP','PAS','MAP','MAS'};
    methodIndex = mod(mIndex,size(mName,2))-1;

    titlename = mName{methodIndex};
    rawReso = 0.125;    postReso = 0.25;
    [x_lat,x_lon] = latlonMat(minlat,minlon,maxlat,maxlon,rawReso,postReso);

    spd0 = sqrt(uAll{1}.^2+vAll{1}.^2);  

    figure1 = figure;
    set(gcf,'position',[0 0 1000 1000]);
    subfig_index = 1;
    for i = 1:row
        for j = 1:col
            u = uAll{index(subfig_index)};    v = vAll{index(subfig_index)};
            
            axes('position',fig_position{subfig_index},'FontSize',fontsize);
            
            axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
                'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[regminLat regmaxlat],...
                'MapLonLimit',[regminlon regmaxlon],'PLineLocation',2,'MLineLocation',5,...
                'GLineWidth',1.0,'FontSize', fontsize,'MLabelParallel','south','FLineWidth',1.0);
            coast = load('coast.mat'); %default file
            hold on; 
            tightmap
            spd = spd0 - sqrt(u.^2+v.^2);
%             spd = spd';
            d=1;
            surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed
            hold on;      
            geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
            hold on;
            % Put colorbar.
            colormap('Jet');
%             if(colorMax~=0)
%                 caxis([0,colorMax]) % change caxis
%             end
%             h=colorbar('h','Position',...
%                 [0.42 0.17-0.1 0.2 0.025], 'FontSize', fontSize);
%             set(get(h,'title'),'string','Speed error', 'FontSize', fontSize);
        colorbar_position = fig_position{subfig_index};
        colorbar_position(1) =  colorbar_position(1);
        colorbar_position(2) =  colorbar_position(2);
         colorbar_position(4) =  colorbar_position(4)-0.45;
        axes('position',colorbar_position,'FontSize',fontsize);
        axis off% must be added unless you wanna an empty coordinate
       
        h=colorbar('h');
%         set(get(h,'ylabel'),'string','Spd', 'FontSize', fontsize);
        set(get(h,'title'),'string','Speed error', 'FontSize', fontsize);   
%         min(min(spd))
%         max(max(spd))
%         caxis([min(min(spd)) max(max(spd)) ]);
        subfig_index = subfig_index + 1;
        end
    end
        
    % Create textbox
annotation('textbox',...
    [0.080625 0.82 0.02 0.03],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize);


% Create textbox
annotation('textbox',...
    [0.361666666666667 0.82 0.02 0.03],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontsize);

% Create textbox
annotation('textbox',...
    [0.642708333333333 0.82 0.02 0.03],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
    
     
end