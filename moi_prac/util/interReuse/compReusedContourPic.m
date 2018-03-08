% show pictures of reused interpolated picture and raw interpolated method
% and origin figure
function compReusedContourPic()
close all
basepath = [cd,'/','moi_prac','/','reuse','/','typhoon','/'];

prefix_s = 'Inter_kamurri';

reuse_suffix = '_reuse_p';
mat_suffix = '.mat';
annot = {'','diff k_{vmp}','spline','BP'};
re_Inter = load([basepath,prefix_s,reuse_suffix,mat_suffix]);
raw_Inter = load([basepath,prefix_s,mat_suffix]);

reg_size = size(re_Inter.rmse,2);

for i =1:reg_size
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
    
    
    u_draw = {u0,reuse_u,sp_u,bp_u};
    v_draw = {v0,reuse_v,sp_v,bp_v};
    
    
    index = 2;
    offflag = 0;
    spIndex = 3;
    colorMax = 0;
    mapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,annot);
%     diffMapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,0,spIndex,annot);

end

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
rawReso = 0.125;    postReso = 0.25;
[x_lat,x_lon] = latlonMat(minlat,minlon,maxlat,maxlon,rawReso,postReso);

spd0 = sqrt(uAll{1}.^2+vAll{1}.^2);  

figure;
%------------------------------------------------------------------------
subplot(221)
u = uAll{1};    v = vAll{1};
spd = sqrt(u.^2+v.^2);    
d=1;
contour(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end)); %% scalar wind speed

% Put colorbar.
colormap('Jet');
% caxis([0,5]) % change caxis
h=colorbar('v');
set(get(h,'ylabel'),'string','Spd', 'FontSize', 16);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', 16, 'FontWeight','normal', ...
    'Interpreter', 'none');
%------------------------------------------------------------------------
subplot(222)
u = uAll{mIndex};    v = vAll{mIndex};
spd = sqrt(u.^2+v.^2);         
d=1;
contour(x_lat,x_lon,spd); %% scalar wind speed

% Put colorbar.
colormap('Jet');
% caxis([0,5]) % change caxis
h=colorbar('v');
set(get(h,'ylabel'),'string','Spd', 'FontSize', 16);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', 16, 'FontWeight','normal', ...
    'Interpreter', 'none');
%------------------------------------------------------------------------

subplot(223)
u = uAll{spIndex};    v = vAll{spIndex};
spd = sqrt(u.^2+v.^2);              
%                  spd( flag == 0)     = NaN;
d=1;
contour(x_lat,x_lon,spd); %% scalar wind speed

% Put colorbar.
colormap('Jet');
% caxis([0,5]) % change caxis
h=colorbar('v');
set(get(h,'ylabel'),'string','Spd', 'FontSize', 20);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', 16, 'FontWeight','normal', ...
    'Interpreter', 'none');
%--------------------------------------------------------------------------
subplot(224)
u = uAll{4};    v = vAll{4};
spd = sqrt(u.^2+v.^2);              
%                  spd( flag == 0)     = NaN;
d=1;
contour(x_lat,x_lon,spd); %% scalar wind speed
% Put colorbar.
colormap('Jet');
% caxis([0,5]) % change caxis
h=colorbar('v');
set(get(h,'ylabel'),'string','Spd', 'FontSize', 16);
% Set unit's title.
units='m/s';
set(get(h, 'title'), 'string', units, ...
    'FontSize', 16, 'FontWeight','normal', ...
    'Interpreter', 'none');

% set index
% Create textbox
annotation('textbox',...
    [0.16 0.9 0.02 0.03],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FitBoxToText','off');

% Create textbox
annotation('textbox',...
    [0.6 0.9 0.02 0.03],'String','(b)',...
    'LineStyle','none',...
    'FontSize',16,...
    'FitBoxToText','off');

% Create textbox
annotation('textbox',...
    [0.16 0.42 0.02 0.03],...
    'String','(c)',...
    'LineStyle','none',...
    'FontSize',16,...
    'FitBoxToText','off');

% Create textbox
annotation('textbox',...
    [0.6 0.42 0.02 0.03],...
    'String','(d)',...
    'LineStyle','none',...
    'FontSize',16,...
    'FitBoxToText','off');

