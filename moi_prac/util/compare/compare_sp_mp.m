%% compare sp,mp,mult,multv,se,mpv of space

%% wind interpolation result comparation
clear all;close all;clc;
s_lat_file = 's_lat.mat';
s_lon_file = 's_lon.mat';
t_lon_file = 't_lon.mat';

load(s_lat_file);
load(s_lon_file);
load(t_lon_file);

size_datdaset = 8;
figIndex = 1;
%% plot space
% 1a) plot u--lat
figure(figIndex);
figIndex = figIndex+1;

x = linspace(1,size_datdaset,size_datdaset);
subplot(221);
sp = plot(x,rs_u_lat(:,1));
hold on;
mp = plot(x,rs_u_lat(:,2));
% hold on;
% se = plot(x,rs_u_lat(:,7));
% hold on;
% mpv = plot(x,rs_v_lat(:,13));


title('u lat comparision--space');
legend([sp mp  ],'sp','mp','Location','SouthOutside');

% 1b) plot u--lon
% figure(figIndex);
% figIndex = figIndex+1;
subplot(222);
sp = plot(x,rs_u_lon(:,1));
hold on;
mp = plot(x,rs_u_lon(:,2));
% hold on;
% se = plot(x,rs_u_lon(:,7));
% hold on;
% mpv = plot(x,rs_v_lat(:,13));
title('u lon comparision--space');
legend([sp mp  ],'sp','mp','Location','SouthOutside');
% 2a) plot v--lat
% figure(figIndex);
% figIndex = figIndex+1;
subplot(223);

sp = plot(x,rs_v_lat(:,1));
hold on;
mp = plot(x,rs_v_lat(:,2));
% hold on;
% se = plot(x,rs_v_lat(:,7));
% hold on;
% mpv = plot(x,rs_v_lat(:,13));

title('v lat comparision--space');
legend([sp mp ],'sp','mp','Location','SouthOutside');

% 2b) plot v--lon
% figure(figIndex);
% figIndex = figIndex+1;
subplot(224);
sp = plot(x,rs_v_lon(:,1));
hold on;
mp = plot(x,rs_v_lon(:,2));
% hold on;
% se = plot(x,rs_v_lon(:,7));
% hold on;
% mpv = plot(x,rs_v_lon(:,13));

title('v lon comparision--space');
legend([sp mp ],'sp','mp','Location','SouthOutside');

%% plot time
% 1b) plot u--lon
figure(figIndex);
figIndex = figIndex+1;
subplot(121);
sp = plot(x,rt_u_lon(:,1));
hold on;
% mp = plot(x,rt_u_lon(:,2));
% hold on;
mp = plot(x,rt_u_lon(:,2));
% hold on;
% se = plot(x,rt_u_lon(:,7));
% hold on;
% mpv = plot(x,rs_v_lat(:,13));
% 

title('u lon comparision--time');
legend([sp mp  ],'sp','mp','Location','SouthOutside');
% 2b) plot v--lon
% figure(figIndex);
% figIndex = figIndex+1;
subplot(122);
sp = plot(x,rt_v_lon(:,1));
hold on;
mp = plot(x,rt_v_lon(:,2));
hold on;
% se = plot(x,rt_v_lon(:,7));
% hold on;
% mpv = plot(x,rs_v_lat(:,13));

title('v lon comparision--time');
legend([sp mp ],'sp','mp','Location','SouthOutside');


%% plot mean rmse
rmse_size = 2;
% lon space--u+v
figure(figIndex);
figIndex = figIndex+1;
subplot(231);
x = linspace(1,rmse_size,rmse_size);
temp = mean(rs_u_lon)+mean(rs_v_lon);
rmse = [temp(1),temp(2)];
grid on;
bar(x,rmse);

title('mean rmse lon u+v comparision--space');
legend({'sp','mp','se','mpv'});


% lon space--u
% figure(figIndex);
% figIndex = figIndex+1;
subplot(232);
x = linspace(1,rmse_size,rmse_size);

temp = mean(rs_u_lon);
rmse = [temp(1),temp(2)];
grid on;
bar(x,rmse);

title('mean rmse lon u comparision--space');
legend({'sp','mp','se','mpv'});


% lon space--u
% figure(figIndex);
% figIndex = figIndex+1;
subplot(233);
x = linspace(1,rmse_size,rmse_size);
temp = mean(rs_v_lon);
rmse = [temp(1),temp(2)];
grid on;
bar(x,rmse);

title('mean rmse lon v comparision--space');
legend({'sp','mp','se','mpv'});

% lat space
% figure(figIndex);
% figIndex = figIndex+1;
subplot(234);
x = linspace(1,rmse_size,rmse_size);
temp = mean(rs_u_lat)+mean(rs_v_lat);
rmse = [temp(1),temp(2)];
grid on;
bar(x,rmse);

title('mean rmse lat u+v comparision--space');
legend({'sp','mp','se','mpv'});

% lat space--u
% figure(figIndex);
% figIndex = figIndex+1;
subplot(235);
x = linspace(1,rmse_size,rmse_size);
temp = mean(rs_u_lat);
rmse = [temp(1),temp(2)];
grid on;
bar(x,rmse);

title('mean rmse lat u comparision--space');
legend({'sp','mp','se','mpv'});

% lat space--v
% figure(figIndex);
% figIndex = figIndex+1;
subplot(236)
x = linspace(1,rmse_size,rmse_size);
temp = mean(rs_v_lat);
rmse = [temp(1),temp(2)];
grid on;
bar(x,rmse);

title('mean rmse lat v comparision--space');
legend({'sp','mp','se','mpv'});


% lon time
figure(figIndex);
figIndex = figIndex+1;
subplot(131);
x = linspace(1,rmse_size,rmse_size);
temp = mean(rt_u_lon)+mean(rt_v_lon);
rmse = [temp(1),temp(2)];
grid on;
bar(x,rmse);

title('mean rmse lon u+v comparision--time');
legend({'sp','mp','se','mpv'});

% lon time--u
% figure(figIndex);
% figIndex = figIndex+1;
subplot(132);
x = linspace(1,rmse_size,rmse_size);
temp = mean(rt_u_lon);
rmse = [temp(1),temp(2)];
grid on;
bar(x,rmse);

title('mean rmse lon u comparision--time');
legend({'sp','mp','se','mpv'});

% lon time--v
% figure(figIndex);
% figIndex = figIndex+1;
subplot(133);
x = linspace(1,rmse_size,rmse_size);
temp = mean(rt_v_lon);
rmse = [temp(1),temp(2)];
grid on;
bar(x,rmse);

title('mean rmse lon v comparision--time');
legend({'sp','mp','se','mpv'});
