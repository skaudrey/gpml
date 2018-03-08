% show pictures of reused interpolated picture and raw interpolated method
% and origin figure

%% some specific parameters
% seagull : colormin = -1;colormax = 1;
% kamurri : colormin = -0.1;corlormax = 0.1;

function compReusedContourDiffPic()
close all
basepath = [cd,'/','moi_prac','/','reuse','/','typhoon','/'];

prefix_s = 'Inter_seagull';

reuse_suffix = '_reuse_p';
mat_suffix = '.mat';
annot = {'','diff k_{vmp}','spline','BP'};
%reuse_suffix,
re_Inter = load([basepath,prefix_s,reuse_suffix,mat_suffix]);
raw_Inter = load([basepath,prefix_s,mat_suffix]);

reg_size = size(re_Inter.rmse,2);

for i =1:reg_size
    [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofSeagull(i);
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
    
    
    u_draw = {u0,reuse_u,sp_u,bp_u};
    v_draw = {v0,reuse_v,sp_v,bp_v};
%     
%     u_draw = {u0,reuse_u,sp_u};
%     v_draw = {v0,reuse_v,sp_v};
    
    
    index = 2;
    offflag = 0;
    spIndex = 3;
    colorMax = 1;
    colormin = -1;
%     mapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colormin,colorMax,spIndex,annot);
%     diffMapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,0,spIndex,annot);
    mapDrawManul(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colormin,colorMax,spIndex,annot);

end
end
function mapDraw(minlat,minlon,maxlat,maxlon,uAll,vAll,regminLat,regminlon,regmaxlat,regmaxlon,offflag,mIndex,colormin,colorMax,spIndex,annot)
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
lat_size = minlat:0.125:maxlat;
lon_size = minlon:0.125:maxlon;
[x_lat,x_lon] = meshgrid(lon_size,lat_size);

spd0 = sqrt(uAll{1}.^2+vAll{1}.^2);  

figure1 = figure;
%------------------------------------------------------------------------
subplot1 = subplot(1,2,1,'Parent',figure1,'BoxStyle','full','Layer','top',...
    'FontSize',20);
box(subplot1,'on');
hold(subplot1,'on');
u = uAll{mIndex};    v = vAll{mIndex};
spd = spd0 - sqrt(u.^2+v.^2);    
d=1;
contourf(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end),10); %% scalar wind speed
ax = gca;
ax.XTickLabel = compositeTickLabe(ax.XTick,1);
ax.YTickLabel = compositeTickLabe(ax.YTick,2);
% Put colorbar.
colormap('Jet');
if(colorMax~=0)
    caxis([colormin,colorMax]) % change caxis
end
h=colorbar('h','Position',...
   [0.1359375 0.0235825545171338 0.321875 0.025]);
set(get(h,'title'),'string','Speed error', 'FontSize', 20);
%------------------------------------------------------------------------
subplot1 = subplot(1,2,2,'Parent',figure1,'BoxStyle','full','Layer','top',...
    'FontSize',20);
box(subplot1,'on');
hold(subplot1,'on');
u = uAll{spIndex};    v = vAll{spIndex};
spd = spd0 - sqrt(u.^2+v.^2);      
d=1;
contourf(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end),10); %% scalar wind speed

ax = gca;

ax.XTickLabel = compositeTickLabe(ax.XTick,1);
ax.YTickLabel = compositeTickLabe(ax.YTick,2);

% Put colorbar.
colormap('Jet');
if(colorMax~=0)
    caxis([colormin,colorMax]) % change caxis
end
h=colorbar('h','Position',...
     [0.577083333333334 0.0235825545171338 0.321875 0.025]);

set(get(h,'title'),'string','Speed error', 'FontSize', 20);

%------------------------------------------------------------------------
% Create textbox
annotation('textbox',...
    [0.0795833333333333-0.03 0.911838006230529 0.02 0.03],...
    'String',{'(a)'},...
    'LineStyle','none',...
     'FontSize', 20);

% Create textbox
annotation('textbox',...
   [0.516041666666666-0.03 0.911838006230529 0.02 0.03],...
    'String',{'(b)'},...
     'LineStyle','none',...
     'FontSize', 20);
end


function mapDrawManul(minlat,minlon,maxlat,maxlon,uAll,vAll,regminLat,regminlon,regmaxlat,regmaxlon,offflag,mIndex,colormin,colorMax,spIndex,annot)
top_margin = 0.08;  
btm_margin = 0.25;
left_margin = 0.15;
right_margin = 0.1;

subfig_margin = 0.1;  %margin between subfigures

row = 1;
col = 3;

[fig_position,colorbar_position] = sharecolorbar(top_margin,btm_margin,left_margin,right_margin,subfig_margin,row,col);

 u = uAll{1};    v = vAll{1};
 spd = sqrt(u.^2+v.^2);    
 

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
lat_size = minlat:0.125:maxlat;
lon_size = minlon:0.125:maxlon;
[x_lat,x_lon] = meshgrid(lon_size,lat_size);

spd0 = sqrt(uAll{1}.^2+vAll{1}.^2);  
index = [mIndex,spIndex,4];
figure;
set(gcf,'position',[0 0 1500 600]);
%------------------------------------------------------------------------
subfig_index = 1;
for i = 1:row
    for j = 1:col

        u = uAll{index(j)};    v = vAll{index(j)};
        spd = spd0 - sqrt(u.^2+v.^2);    
%         m_proj('Equidistant','lat',[minlat maxlat],'lon',[minlon maxlon],'aspect',.8);
% %     m_coast('patch',[.9 .9 .9],'edgecolor','none');
%     m_grid('tickdir','out','yticklabels',[],...
%            'xticklabels',[],'linestyle','none','ticklen',.02);
%     hold on;
        axes('position',fig_position{subfig_index},'FontSize',fontsize);
        
        d=1;
        contourf(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end),10); % scalar wind speed
        ax = gca;
        ax.XTickLabel = compositeTickLabe(ax.XTick,1);
        ax.YTickLabel = compositeTickLabe(ax.YTick,2);
        ax.FontSize = fontsize;
        
%         if(col>1)
%             ax.
%         end
        
        % Put colorbar.
        colormap('jet');
       
        colorbar_position = fig_position{subfig_index};
        colorbar_position(1) =  colorbar_position(1);
        colorbar_position(2) =  colorbar_position(2)-0.2;
        colorbar_position(4) =  colorbar_position(4)-0.3;
        axes('position',colorbar_position,'FontSize',fontsize);
        axis off% must be added unless you wanna an empty coordinate
       
        h=colorbar('h');
        set(get(h,'title'),'string','Speed error', 'FontSize', fontsize);      
%         if(j<3)
%             caxis([colormin,colorMax]);
%         end
        subfig_index = subfig_index + 1;        
    end
end

%------------------------------------------------------------------------
% Create textbox
annotation('textbox',...
    [0.0795833333333333 0.911838006230529+0.05 0.02 0.03],...
    'String',{'(a)'},...
    'LineStyle','none',...
     'FontSize', fontsize);
% Create textbox
annotation('textbox',...
   [0.332041666666661+0.03 0.911838006230529+0.05 0.02 0.03],...
    'String',{'(b)'},...
     'LineStyle','none',...
     'FontSize', fontsize);
 annotation('textbox',...
    [0.612708333333315+0.03 0.911838006230529+0.05 0.02 0.03],...
    'String','(c)',...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FitBoxToText','off');


end

% tickType: 1 for xLabel(E), 2 for yLabel(N);
function tickLabel =  compositeTickLabe(tickCoor,tickType)
tickLabel = {};
tickSuffix = '';

switch(tickType)
    case 1
        tickSuffix = '\circE';
        
    case 2
        tickSuffix = '\circN';
        
end
 nlen = size(tickCoor,2);
for i = 1:nlen
    tickLabel{i} = strcat(num2str(tickCoor(i)),tickSuffix);
end

end