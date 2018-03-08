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
typeD = 1;  % data set,1 for longitude , 2 for latitude
typeV_pca = 8;  % pca feature

%% interpolation. REMARKS: the u3,v3 are calculated from the multiscale and multi variables interpolated speed and direction£»u4,v4 are calculated from the multiscale and multi variables interpolated speed and direction
% u wind component

typeV = 1;
for lon = minlon:resolution:maxlon
% for lat = minlat:resolution:maxlat
       prefix_p = getPrefixByType(typeS,typeI,typeV_pca,typeD); % pca
       prefix_s = getPrefixByType(typeS,typeI,typeV,typeD); % u10
      
        [u0_temp u1_temp u2_temp] = mult_pca(prefix_p,prefix_s,lon);
        u0 = [u0,u0_temp];
        u1 = [u1,u1_temp];
        u2 = [u2,u2_temp];
end

% v wind component
typeV = 2;  % the variable type ,see in getPrefixByType
for lon = minlon:resolution:maxlon
% for lat = minlat:resolution:maxlat
       prefix_p = getPrefixByType(typeS,typeI,typeV_pca,typeD); % pca
       prefix_s = getPrefixByType(typeS,typeI,typeV,typeD); % v10
       
        [v0_temp v1_temp v2_temp] = mult_pca(prefix_p,prefix_s,lon);
        v0 = [v0,v0_temp];
        v1 = [v1,v1_temp];
        v2 = [v2,v2_temp];
end

% speed
typeV = 6;  % the variable type ,see in getPrefixByType
% for lat = minlat:resolution:maxlat
for lon = minlon:resolution:maxlon
       prefix_p = getPrefixByType(typeS,typeI,typeV_pca,typeD); % pca
       prefix_s = getPrefixByType(typeS,typeI,typeV,typeD); % speed
       
        [s0_temp s1_temp s2_temp] = mult_pca(prefix_p,prefix_s,lon);
        s0 = [s0,s0_temp];
        s1 = [s1,s1_temp];
        s2 = [s2,s2_temp];
end

% wind direction,just using the mult-scale
% direction
typeV = 3;  % the variable type ,see in getPrefixByType, 1 for space 2 for time 3 for time and space
%  for lat = minlat:resolution:maxlat
for lon = minlon:resolution:maxlon
       prefix_p = getPrefixByType(typeS,typeI,typeV_pca,typeD); % pca
       prefix_s = getPrefixByType(typeS,typeI,typeV,typeD); % direction
       
        [d0_temp d1_temp d2_temp] = mult_pca(prefix_p,prefix_s,lon);
        d0 = [d0,d0_temp];
        d1 = [d1,d1_temp];
        d2 = [d2,d2_temp];
end

% recalculate u and v wind component from speed and direction
[u3 v3] = CalUVFromSpeed(s1,d1);    % recalculated u and v direction wind from scalar speed and direction,multi-scale 
[u4 v4] = CalUVFromSpeed(s2,d2);    % recalculated u and v direction wind from scalar speed and direction


%% save file,show result
dir = 'D:\Code\Matlab\gpml\moi_prac\inter_result\';
mkdir(dir);
% if(typeD == 1)
%     region = strcat('s_pca_Sum','LON',num2str(minlon),'-',num2str(maxlon));
% else
%     region = strcat('s_pca_'
typeM = 14; % 4 for pca_sum,5 for pca_prod; 10-13 also need to be reoperate
% typeM = 5;
% typeNorm = 1; % no norm operation
% regionName(typeI,typeM,typeNorm,typeD,min,max);
region = regionName(typeS,typeI,typeM,typeD,minlon,maxlon);

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

save(filename,'u0','u1','u2','v0','v1','v2','s0','s1','s2','d0','d1','d2','rmse_sp','rmse_m');

% load('D:\Code\Matlab\gpml\moi_prac\inter_result\s_mvLON30-35.25.mat');


% draw picture
figure(1)
%  i = 1,j=20;
%  u0 = u0(i:j,:);
%  u0 = u0(i:j,:);
% 
%  u1 = u1(i:j,:);
%  u2 = u2(i:j,:);
%  v0 = v0(i:j,:);
%   
%  v1 = v1(i:j,:);
%  v2 = v2(i:j,:);

[ySize,xSize] = size(u0);
[x,y] = meshgrid(1:xSize,1:ySize);
close all
% origin = quiver(x,y,u0,v0,'-r');
% hold on;
spline = quiver(x,y,u2-u0,v2-v0,'-k');
hold on;
multi = quiver(x,y,u1-u0,v1-v0,'-c');

% title('Wind field-- true wind field,multi-scale interpolation and spline interpolation')
% legend([origin spline multi],'true wind field','spline','multi-scale','Location','SouthOutside')
title('derivation with the true Wind field,multi-scale interpolation and spline interpolation')
legend([spline multi],'spline','multi-scale','Location','SouthOutside')

% figure(2)
% subplot(131)
% plot(u0(1:240,1),u0(2:241,1),'.'); % It's showed that there is a strong linear relationship between the distance sieries of u
% title('distance series self-correlation of u-- 1 order')
% subplot(132)
% plot(u0(1:239,1),u0(3:241,1),'.'); % It's showed that there is a strong linear relationship between the distance sieries of u
% title('distance series self-correlation of u-- 2 order')
% subplot(133)
% plot(u0(1:238,1),u0(4:241,1),'.'); % It's showed that there is a strong linear relationship between the distance sieries of u
% title('distance series self-correlation of u-- 3 order')
% 
% figure(3)
% subplot(131)
% plot(v0(1:240,1),v0(2:241,1),'.'); % It's showed that there is a strong linear relationship between the distance sieries of u
% title('distance series self-correlation of v-- 1 order')
% subplot(132)
% plot(v0(1:239,1),v0(3:241,1),'.'); % It's showed that there is a strong linear relationship between the distance sieries of u
% title('distance series self-correlation of v-- 2 order')
% subplot(133)
% plot(v0(1:238,1),v0(4:241,1),'.'); % It's showed that there is a strong linear relationship between the distance sieries of u
% title('distance series self-correlation of v-- 3 order')
% 
% % show the correlation of interpolated result
% figure(4)
% index = linspace(1,241,241)';
% subplot(221)
% plot(index,u0,'.'); % It's showed that there is a strong linear relationship between the distance sieries of u
% title('distance series correlation of u and distance')
% subplot(222)
% plot(index,v0,'.'); % It's showed that there is a strong linear relationship between the distance sieries of u
% title('distance series correlation of v and distance')
% subplot(223)
% normplot(u0);
% title('gaussian distribution test of u0')
% subplot(224)
% normplot(v0);
% title('Gaussian distribution test of v0')

