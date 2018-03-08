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

typeS = 5;

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

cpu_time = [];
%% interpolation. REMARKS: the u3,v3 are calculated from the multiscale and multi variables interpolated speed and direction£»u4,v4 are calculated from the multiscale and multi variables interpolated speed and direction
% u wind component

if(typeD == 2)
    minlon = 100;
    maxlon = 120;    % latitude === all longitude
    minlat = 15;
    maxlat = 25;
end

typeV = 1;  % the variable type ,see in getPrefixByType, 1 for space 2 for time 3 for time and space

file_prex = getPrefixByType(typeS,typeI,typeV,typeD); % choose the suitable data file, see in getPrefixByType
tic;
[u0_temp u1_temp u2_temp] = matRegInter(file_prex,minlon,minlat,maxlon,maxlat,typeV);
cpu_time(1) = toc;
u0 = [u0,u0_temp];
u1 = [u1,u1_temp];
u2 = [u2,u2_temp];


% v wind component
typeV = 2;  % the variable type ,see in getPrefixByType

file_prex = getPrefixByType(typeS,typeI,typeV,typeD); % choose the suitable data file, see in getPrefixByType
tic;
[v0_temp v1_temp v2_temp] = matRegInter(file_prex,minlon,minlat,maxlon,maxlat,typeV);
cpu_time(2) = toc;
v0 = [v0,v0_temp];
v1 = [v1,v1_temp];
v2 = [v2,v2_temp];


% direction
typeV = 3;  % the variable type ,see in getPrefixByType, 1 for space 2 for time 3 for time and space

ile_prex = getPrefixByType(typeS,typeI,typeV,typeD); % choose the suitable data file, see in getPrefixByType
tic;
[d0_temp d1_temp d2_temp] = matRegInter(file_prex,minlon,minlat,maxlon,maxlat,typeV);
cpu_time(3) = toc;
d0 = [d0,d0_temp];
d1 = [d1,d1_temp];
d2 = [d2,d2_temp];


% speed
typeV = 6;  % the variable type ,see in getPrefixByType

file_prex = getPrefixByType(typeS,typeI,typeV,typeD); % choose the suitable data file, see in getPrefixByType
tic;
[s0_temp s1_temp s2_temp] = matRegInter(file_prex,minlon,minlat,maxlon,maxlat,typeV);
cpu_time(4) = toc;
s0 = [s0,s0_temp];
s1 = [s1,s1_temp];
s2 = [s2,s2_temp];

[u3 v3] = CalUVFromSpeed(s1,d1);    % recalculated u and v direction wind from scalar speed and direction,multi-scale 
[u4 v4] = CalUVFromSpeed(s2,d2);    % recalculated u and v direction wind from scalar speed and direction

%% save file,show result
dir = 'D:\Code\Matlab\gpml\moi_prac\inter_result\';
mkdir(dir);

% region = strcat('t_mult_norm','LON',num2str(minlon),'-',num2str(maxlon));

typeM = 9; % 6 for se
% typeM = 2;    %2 for mult;
% typeNorm = 1; % no norm operation
% regionName(typeI,typeM,typeNorm,typeD,min,max);
region = regionName(typeS,typeI,typeM,typeD,minlat,maxlat);

filename = strcat(dir,region,'.mat');
    
filename

if(size(u2,1) ==0)
    rmse_sp_u = [];
    rmse_sp_v = [];
else
    rmse_sp_u = getRMSE(u0,u2);
    rmse_sp_v = getRMSE(v0,v2);
end
    
if(size(u4,1) ==0)
    rmse_sp_u_s = [];
    rmse_sp_v_d = [];
else
   rmse_sp_u_s = getRMSE(u0,u4);
   rmse_sp_v_d = getRMSE(v0,v4);
end

rmse_m_u = getRMSE(u0,u1);
rmse_m_v = getRMSE(v0,v1);
rmse_m_u_s = getRMSE(u0,u3);
rmse_m_v_d = getRMSE(v0,v3);

rmse_sp = [rmse_sp_u',rmse_sp_v',rmse_sp_u_s',rmse_sp_v_d'];
rmse_m = [rmse_m_u',rmse_m_v',rmse_m_u_s',rmse_m_v_d'];

explain = 'the columns of rmse is u,v,u calculated from s,v calculated from d; 0 for origin,1 for multi-scale or mp,2 for spline'

save(filename,'u0','u1','u2','v0','v1','v2','s0','s1','s2','d0','d1','d2','rmse_sp','rmse_m','explain','cpu_time');
