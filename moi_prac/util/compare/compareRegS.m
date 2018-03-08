%% compare RMSE of one region

%% wind interpolation result comparation
clear all;close all;clc;
s_lat_file = 'D:\Code\Matlab\gpml\moi_prac\reg_inter_odd\reg_s_lat.mat';
s_lon_file = 'D:\Code\Matlab\gpml\moi_prac\reg_inter_odd\reg_s_lon.mat';
% t_lon_file = 't_lon.mat';

load(s_lat_file);
load(s_lon_file);
% load(t_lon_file);

size_datdaset = 1;
size_method = 7;
figIndex = 1;

compV1 = 6;  %compare v1,5 for pcaSum
compV2 = 1; % 2 for mp
varname1 = '2dPcaregMpngProd';varname2 = 'spline';
rmse_slon = [];
rmse_slat = [];
rmse_tlon = [];

baseline = 500;

compareS = 2;


%% plot the overall mean rmse
figure(figIndex);
figIndex = figIndex+1;

x = linspace(1,size_method,size_method);
subplot(121);
sulon = plot(x,rs_u_lon);
hold on;
sulat = plot(x,rs_u_lat);
hold on;
sslon = plot(x,rs_su_lon);
hold on;
sslat = plot(x,rs_su_lat);

title('u mean rmse including recalculated u from speed and direction -- space');
legend([sulon sulat sslon sslat ],'u-lon','u-lat','u of s and d -lon','u of s and d -lat','Location','SouthOutside');

subplot(122);
svlon = plot(x,rs_v_lon);
hold on;
svlat = plot(x,rs_v_lat);
hold on;
sdlon = plot(x,rs_sv_lon);
hold on;
sdlat = plot(x,rs_sv_lat);
title('v mean rmse including recalculated v from speed and direction -- space');
legend([svlon svlat sdlon sdlat ],'v-lon','v-lat','v of s and d -lon','v of s and d -lat','Location','SouthOutside');


%% plot overall mean rmse of one variable
figure(figIndex);
figIndex = figIndex+1;

x = linspace(1,size_method,size_method);
subplot(221);
sulon = plot(x,rs_u_lon);
hold on;
sulat = plot(x,rs_u_lat);
title('u mean rmse -- space');
legend([sulon sulat  ],'u-lon','u-lat','Location','SouthOutside');

subplot(222);
svlon = plot(x,rs_v_lon);
hold on;
svlat = plot(x,rs_v_lat);
title('v mean rmse -- space');
legend([svlon svlat  ],'v-lon','v-lat','Location','SouthOutside');


subplot(223);
sslon = plot(x,rs_su_lon);
hold on;
sslat = plot(x,rs_su_lat);
title('u of s and d mean rmse -- space');
legend([sslon sslat  ],'v of s and d-lon','v of s and d-lat','Location','SouthOutside');


subplot(224);
sdlon = plot(x,rs_sv_lon);
hold on;
sdlat = plot(x,rs_sv_lat);
title('v of s and d mean rmse -- space');
legend([sdlon sdlat  ],'v of s and d-lon','v of s and d-lat','Location','SouthOutside');

%% get min mean rmse and show the percentage increasing from the minimum

figure(figIndex);
figIndex = figIndex+1;

% plot u lon
subplot(221);
[su1,index1] = sort(rs_u_lon);
su1_per  = (su1-su1(1))/su1(1) * 100;

su1_per = su1_per(su1_per<baseline);
index1 = index1(1:size(su1_per,2));
size_M = size(su1_per,2);
x = linspace(1,size_M,size_M);
perulon = bar(x-0.5,su1_per);
text(x-0.8,su1_per+1,getMNameByIndex(index1,compareS));
title('u difference mean rmse percentage lon -- space');

% plot u lat
% clear index1,su1_per,x,size_M;
subplot(222);
[su2,index2] = sort(rs_u_lat);
su2_per  = (su2-su2(1))/su2(1) * 100;

su2_per = su2_per(su2_per<baseline);
index2 = index2(1:size(su2_per,2));
size_M = size(su2_per,2);
x = linspace(1,size_M,size_M);

perulat = bar(x-0.5,su2_per);
text(x-0.8,su2_per+1,getMNameByIndex(index2,compareS));
title('u difference mean rmse percentage lat -- space');
% legend([perulon perulat  ],'sulon','sulat','Location','SouthOutside');

% plot v lon
% clear index2,su2_per,x,size_M;
subplot(223);
[sv1,index1] = sort(rs_v_lon);
sv1_per  = (sv1-sv1(1))/sv1(1) * 100;

sv1_per = sv1_per(sv1_per<baseline);
index1 = index1(1:size(sv1_per,2));
size_M = size(sv1_per,2);
x = linspace(1,size_M,size_M);

pervlon = bar(x-0.5,sv1_per);
text(x-0.8,sv1_per+1,getMNameByIndex(index1,compareS));
title('v difference mean rmse percentage lon -- space');

% plot v lat
% clear index1,sv1_per,x,size_M;
subplot(224);
[sv2,index2] = sort(rs_v_lat);
sv2_per  = (sv2-sv2(1))/sv2(1) * 100;

sv2_per = sv2_per(sv2_per<baseline);
index2 = index2(1:size(sv2_per,2));
size_M = size(sv2_per,2);
x = linspace(1,size_M,size_M);

pervlat = bar(x-0.5,sv2_per);
text(x-0.8,sv2_per+1,getMNameByIndex(index2,compareS));
title('v difference mean rmse percentage lat -- space');
% legend([pervlon pervlat  ],'svlon','svlat','Location','SouthOutside');

% % plot su,sv
% figure(figIndex);
% figIndex = figIndex+1;
% 
% % plot su lon
% % clear index2,sv2_per,x,size_M;
% subplot(221);
% 
% [sv1,index1] = sort(rs_su_lon);
% sv1_per  = (sv1-sv1(1))/sv1(1) * 100;
% 
% sv1_per = sv1_per(sv1_per<baseline);
% index1 = index1(1:size(sv1_per,2));
% size_M = size(sv1_per,2);
% x = linspace(1,size_M,size_M);
% 
% pervlon = bar(x-0.5,sv1_per);
% text(x-0.8,sv1_per+1,getMNameByIndex(index1,compareS));
% title('su mean rmse difference percentage lon -- space');
% 
% subplot(222);
% % clear index2,sv1_per,x,size_M;
% [sv2,index2] = sort(rs_su_lat);
% sv2_per  = (sv2-sv2(1))/sv2(1) * 100;
% 
% sv2_per = sv2_per(sv2_per<baseline);
% index2 = index2(1:size(sv2_per,2));
% size_M = size(sv2_per,2);
% x = linspace(1,size_M,size_M);
% 
% pervlat = bar(x-0.5,sv2_per);
% text(x-0.8,sv2_per+1,getMNameByIndex(index2,compareS));
% title('su mean rmse difference percentage lat -- space');
% % legend([pervlon pervlat  ],'ssulon','ssulat','Location','SouthOutside');
% 
% subplot(223);
% % clear index2,sv2_per,x,size_M;
% [sv1,index1] = sort(rs_sv_lon);
% sv1_per  = (sv1-sv1(1))/sv1(1) * 100;
% 
% sv1_per = sv1_per(sv1_per<baseline);
% index1 = index1(1:size(sv1_per,2));
% size_M = size(sv1_per,2);
% x = linspace(1,size_M,size_M);
% 
% pervlon = bar(x-0.5,sv1_per);
% text(x-0.8,sv1_per+1,getMNameByIndex(index1,compareS));
% title('sv mean rmse difference percentage lon -- space');
% 
% 
% subplot(224);
% % clear index2,sv1_per,x,size_M;
% [sv2,index2] = sort(rs_sv_lat);
% sv2_per  = (sv2-sv2(1))/sv2(1) * 100;
% 
% sv2_per = sv2_per(sv2_per<baseline);
% index2 = index2(1:size(sv2_per,2));
% size_M = size(sv2_per,2);
% x = linspace(1,size_M,size_M);
% 
% pervlat = bar(x-0.5,sv2_per);
% text(x-0.8,sv2_per+1,getMNameByIndex(index2,compareS));
% title('sv mean rmse difference percentage lat -- space');
% % legend([pervlon pervlat  ],'ssvlon','ssvlat','Location','SouthOutside');

%% plot mean rmse
var = {varname1,varname2};


rmse_size = 2;
% lon space--u+v
figure(figIndex);
figIndex = figIndex+1;
subplot(231);
x = linspace(1,rmse_size,rmse_size);
temp = rs_u_lon + rs_v_lon;
rmse = [temp(compV1),temp(compV2)];
rmse_slon = [rmse_slon , rmse];
grid on;
bar(x,rmse);
text(x,rmse+0.002,var);
title('mean rmse lon u+v comparision--space');


% lon space--u
% figure(figIndex);
% figIndex = figIndex+1;
subplot(232);
x = linspace(1,rmse_size,rmse_size);

temp = rs_u_lon;
rmse = [temp(compV1),temp(compV2)];
rmse_slon = [rmse_slon , rmse];
grid on;
bar(x,rmse);
text(x,rmse+0.0002,var);

title('mean rmse lon u comparision--space');


% lon space--u
% figure(figIndex);
% figIndex = figIndex+1;
subplot(233);
x = linspace(1,rmse_size,rmse_size);
temp = rs_v_lon;
rmse = [temp(compV1),temp(compV2)];
rmse_slon = [rmse_slon , rmse];
grid on;
bar(x,rmse);
text(x,rmse+0.0002,var);
title('mean rmse lon v comparision--space');
% lat space
% figure(figIndex);
% figIndex = figIndex+1;
subplot(234);
x = linspace(1,rmse_size,rmse_size);
temp = rs_u_lat + rs_v_lat;
rmse = [temp(compV1),temp(compV2)];
rmse_slat = [rmse_slat , rmse];
grid on;
bar(x,rmse);
text(x,rmse+0.7,var);

title('mean rmse lat u+v comparision--space');

% lat space--u
% figure(figIndex);
% figIndex = figIndex+1;
subplot(235);
x = linspace(1,rmse_size,rmse_size);
temp = rs_u_lat;
rmse = [temp(compV1),temp(compV2)];
rmse_slat = [rmse_slat , rmse];
grid on;
bar(x,rmse);
text(x,rmse+0.5,var);

title('mean rmse lat u comparision--space');

% lat space--v
% figure(figIndex);
% figIndex = figIndex+1;
subplot(236)
x = linspace(1,rmse_size,rmse_size);
temp = rs_v_lat;
rmse = [temp(compV1),temp(compV2)];
rmse_slat = [rmse_slat , rmse];
grid on;
bar(x,rmse);
text(x,rmse+0.007,var);
title('mean rmse lat v comparision--space');


%% show the differences figure of spline and origin,other method and origin

u0_lon = reshape(s_u_lon{1},[240,8]);
u1_lon = reshape(s_u_lon{compV1+1},[240,8]);
u2_lon = reshape(s_u_lon{compV2+1},[240,8]);

v0_lon = reshape(s_v_lon{1},[240,8]);
v1_lon = reshape(s_v_lon{compV1+1},[240,8]);
v2_lon = reshape(s_v_lon{compV2+1},[240,8]);

figure(figIndex);
figIndex = figIndex+1;

lon_size = 8;lat_size = 240;
subplot(221);
[X,Y] = meshgrid(1:8,1:240);
% disp('u1_lon-u0_lon');
% u1_lon-u0_lon
[C,h] = contour(X,Y,u1_lon-u0_lon);
colormap jet
title([varname1 ' ulon -origin ulon' ]);
shading interp;
colorbar;
caxis([-1,1]);

subplot(222);
[X,Y] = meshgrid(1:8,1:240);

% disp('u2_lon-u0_lon');
% u2_lon-u0_lon

[C,h] = contour(X,Y,u2_lon-u0_lon);
colormap jet
title([varname2 ' ulon -origin ulon' ]);
shading interp;
colorbar
caxis([-1,1]);

subplot(223);
[X,Y] = meshgrid(1:8,1:240);
[C,h] = contour(X,Y,v1_lon-v0_lon);
colormap jet
title([varname1 ' vlon -origin vlon' ]);
shading interp;
colorbar;
caxis([-0.6,1.2]);


subplot(224);
[X,Y] = meshgrid(1:8,1:240);
[C,h] = contour(X,Y,v2_lon-v0_lon);
colormap jet
title([varname2 ' vlon -origin vlon' ]);
shading interp;
colorbar;
caxis([-0.6,1.2]);

%% show the figure of spline and origin,other method and origin distribution

u0_lon = reshape(s_u_lon{1},[240,8]);
u1_lon = reshape(s_u_lon{compV1+1},[240,8]);
u2_lon = reshape(s_u_lon{compV2+1},[240,8]);

v0_lon = reshape(s_v_lon{1},[240,8]);
v1_lon = reshape(s_v_lon{compV1+1},[240,8]);
v2_lon = reshape(s_v_lon{compV2+1},[240,8]);

figure(figIndex);
figIndex = figIndex+1;

lon_size = 8;lat_size = 240;
subplot(231);
[X,Y] = meshgrid(1:8,1:240);
% disp('u1_lon-u0_lon');
% u1_lon-u0_lon
[C,h] = contour(X,Y,u0_lon);
colormap jet
title([' origin ulon' ]);
shading interp;
colorbar;
% caxis([-1,1]);

subplot(232);
[X,Y] = meshgrid(1:8,1:240);

% disp('u2_lon-u0_lon');
% u2_lon-u0_lon

[C,h] = contour(X,Y,u1_lon);
colormap jet
title([varname1 'ulon ' ]);
shading interp;
colorbar
% caxis([-1,1]);

subplot(233);
[X,Y] = meshgrid(1:8,1:240);

% disp('u2_lon-u0_lon');
% u2_lon-u0_lon

[C,h] = contour(X,Y,u2_lon);
colormap jet
title([varname2 'ulon ' ]);
shading interp;
colorbar
% caxis([-1,1]);

subplot(234);
[X,Y] = meshgrid(1:8,1:240);
[C,h] = contour(X,Y,v0_lon);
colormap jet
title([' vlon' ]);
shading interp;
colorbar;
% caxis([-0.6,1.2]);


subplot(235);
[X,Y] = meshgrid(1:8,1:240);
[C,h] = contour(X,Y,v1_lon);
colormap jet
title([varname1 'vlon' ]);
shading interp;
colorbar;
% caxis([-0.6,1.2]);

subplot(236);
[X,Y] = meshgrid(1:8,1:240);
[C,h] = contour(X,Y,v2_lon);
colormap jet
title([varname2 ' vlon' ]);
shading interp;
colorbar;
% caxis([-0.6,1.2]);


%% show rmse
clc;
disp([varname1 ' space lon rmse u: ' num2str(rmse_slon(3)) ] );
disp([varname1 ' space lon rmse v: ' num2str(rmse_slon(5)) ] );
disp([varname1 ' space lat rmse u: ' num2str(rmse_slat(3)) ] );
disp([varname1 ' space lat rmse v: ' num2str(rmse_slat(5)) ] );
disp([varname2 ' space lon rmse u: ' num2str(rmse_slon(4)) ] );
disp([varname2 ' space lon rmse v: ' num2str(rmse_slon(6)) ] );
disp([varname2 ' space lat rmse u: ' num2str(rmse_slat(4)) ] );
disp([varname2 ' space lat rmse v: ' num2str(rmse_slat(6)) ] );

%% calculate percentage

p_slon = [];p_slat =[];

p_slon(1) = (rmse_slon(2)- rmse_slon(1))/rmse_slon(1)*100;  %u+v
p_slon(2) = (rmse_slon(4)- rmse_slon(3))/rmse_slon(3)*100;  %u
p_slon(3) = (rmse_slon(6)- rmse_slon(5))/rmse_slon(5)*100;  %v

p_slat(1) = (rmse_slat(2)- rmse_slat(1))/rmse_slat(1)*100;
p_slat(2) = (rmse_slat(4)- rmse_slat(3))/rmse_slat(3)*100;
p_slat(3) = (rmse_slat(6)- rmse_slat(5))/rmse_slat(5)*100;

disp('precentage show: u+v, u , v');
disp([ '(' varname2 '-' varname1 ')/' varname1]);
disp('----------------------');
disp('precentage space lon');
p_slon
disp('----------------------');
disp('precentage space lat');
p_slat