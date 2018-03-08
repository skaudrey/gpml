% compare wind field
% one is the wind field drawn by the interpolated u wind speed and the interpolated v wind speed??
% one is the true wind field drawn by the raw data
%% global variables
close all;clear all;
% minlon = 30;
% maxlon = 35.25;
% minlat = 30;
% maxlat = 35.25;
% resolution = 0.75;  % for EC data,the resolution is 0.75'

minlon = 10;
maxlon = 11.75;
minlat = 10;
maxlat = 11.75;
resolution = 0.25;  % for EC data,the resolution is 0.75'

typeS = 3;

% u and v for u and v wind component; 0 for raw data, 1 for nulti-scale and
% 2 for spline
u0 = []; 
u1 = [];
u2 = [];
v0 = [];
v1 = [];
v2 = [];

s0 = []; 
s1 = [];
s2 = [];
d0 = [];
d1 = [];
d2 = [];

typeI = 1;  % the interpolation data set type ,see in getPrefixByType,1 for space interpolation 2 for time interpolation
typeD = 2;  % 1 for lon ,2 for lat
%% interpolation. REMARKS: the u3,v3 are calculated from the multiscale and multi variables interpolated speed and direction£»u4,v4 are calculated from the multiscale and multi variables interpolated speed and direction
% u wind component
typeV = 1;  % the variable type ,see in getPrefixByType, 1 for space 2 for time 3 for time and space
for lon = minlon:resolution:maxlon
% for lat = minlat:resolution:maxlat
        file_prex = getPrefixByType(typeS,typeI,typeV,typeD); % choose the suitable data file, see in getPrefixByType
%         [u0_temp u1_temp u2_temp] = multScale(file_prex,lon);
        [u0_temp u1_temp u2_temp] = seInter(file_prex,lon);
%         [u0_temp u1_temp u2_temp] = mp(file_prex,lat);       
%         [u0_temp u1_temp u2_temp] = multScale(file_prex,lon);
        u0 = [u0,u0_temp];
        u1 = [u1,u1_temp];
        u2 = [u2,u2_temp];
end

% v wind component
typeV = 2;  % the variable type ,see in getPrefixByType
for lon = minlon:resolution:maxlon
% for lat = minlat:resolution:maxlat
        file_prex = getPrefixByType(typeS,typeI,typeV,typeD); % choose the suitable data file, see in getPrefixByType
%         [v0_temp v1_temp v2_temp] = mp(file_prex,lon);
%         [v0_temp v1_temp v2_temp] = mp(file_prex,lat);        
%         [v0_temp v1_temp v2_temp] = multScale(file_prex,lon);
        [v0_temp v1_temp v2_temp] = seInter(file_prex,lon);
        v0 = [v0,v0_temp];
        v1 = [v1,v1_temp];
        v2 = [v2,v2_temp];
end

% direction
typeV = 3;  % the variable type ,see in getPrefixByType, 1 for space 2 for time 3 for time and space
for lon = minlon:resolution:maxlon
% for lat = minlat:resolution:maxlat
        file_prex = getPrefixByType(typeS,typeI,typeV,typeD); % choose the suitable data file, see in getPrefixByType
        [d0_temp d1_temp d2_temp] = seInter(file_prex,lon);
        d0 = [d0,d0_temp];
        d1 = [d1,d1_temp];
        d2 = [d2,d2_temp];
end

% speed
typeV = 6;  % the variable type ,see in getPrefixByType
for lon = minlon:resolution:maxlon
% for lat = minlat:resolution:maxlat
        file_prex = getPrefixByType(typeS,typeI,typeV,typeD); % choose the suitable data file, see in getPrefixByType
%         [s0_temp s1_temp s2_temp] = mp(file_prex,lon);
%         [s0_temp s1_temp s2_temp] = mp(file_prex,lat);
%         [s0_temp s1_temp s2_temp] = multScale(file_prex,lon);
        [s0_temp s1_temp s2_temp] = seInter(file_prex,lon);
        s0 = [s0,s0_temp];
        s1 = [s1,s1_temp];
        s2 = [s2,s2_temp];
end
[u3 v3] = CalUVFromSpeed(s1,d1);    % recalculated u and v direction wind from scalar speed and direction,multi-scale 
[u4 v4] = CalUVFromSpeed(s2,d2);    % recalculated u and v direction wind from scalar speed and direction

%% save file,show result
dir = 'D:\Code\Matlab\gpml\moi_prac\inter_result\';
mkdir(dir);

% region = strcat('t_mult_norm','LON',num2str(minlon),'-',num2str(maxlon));

typeM = 6; % 6 for se
% typeM = 2;    %2 for mult;
% typeNorm = 1; % no norm operation
% regionName(typeI,typeM,typeNorm,typeD,min,max);
region = regionName(typeS,typeI,typeM,typeD,minlat,maxlat);

filename = strcat(dir,region,'.mat');
    
filename

rmse_sp_u = getRMSE(u0,u2);
rmse_sp_v = getRMSE(v0,v2);
rmse_sp_u_s = getRMSE(u0,u4);
rmse_sp_v_d = getRMSE(v0,v4);

rmse_m_u = getRMSE(u0,u1);
rmse_m_v = getRMSE(v0,v1);
rmse_m_u_s = getRMSE(u0,u3);
rmse_m_v_d = getRMSE(v0,v3);

rmse_sp = [rmse_sp_u',rmse_sp_v',rmse_sp_u_s',rmse_sp_v_d'];
rmse_m = [rmse_m_u',rmse_m_v',rmse_m_u_s',rmse_m_v_d'];

explain = 'the columns of rmse is u,v,u calculated from s,v calculated from d; 0 for origin,1 for multi-scale or mp,2 for spline'

save(filename,'u0','u1','u2','v0','v1','v2','s0','s1','s2','d0','d1','d2','rmse_sp','rmse_m','explain');

%  load('D:\Code\Matlab\gpml\moi_prac\inter_result\s_LON30-35.25.mat');

% draw picture
figure(1)
i = 60;j=80;
u0 = u0(i:j,:);
u1 = u1(i:j,:);
u2 = u2(i:j,:);
v0 = v0(i:j,:);
v1 = v1(i:j,:);
v2 = v2(i:j,:);

[ySize,xSize] = size(u0);
[x,y] = meshgrid(1:xSize,1:ySize);

origin = quiver(x,y,u0,v0,'-r');
hold on;
spline = quiver(x,y,u2,v2,'-k');
hold on;
multi = quiver(x,y,u1,v1,'-c');

title('Wind field-- true wind field,multi-scale interpolation and spline interpolation')
legend([origin spline multi],'true wind field','spline','multi-scale','Location','SouthOutside')

