%% compare sp,mp,mult,multv,se,mpv of time

%% wind interpolation result comparation
clear all;close all;clc;
t_lon_file = 't_lon.mat';

load(t_lon_file);

size_datdaset = 8;
size_method = 14;
figIndex = 1;
rmse_size = 2;  % the rmse which need to be compared

compV1 = 1;  %compare v1,5 for pcaSum
compV2 = 11; % 2 for mp
varname1 = 'sp';varname2 = 'auto';
rmse_slon = [];
rmse_slat = [];
rmse_tlon = [];

baseline = 80; % the maximum percentage compared

%% plot the overall mean rmse
figure(figIndex);
figIndex = figIndex+1;

x = linspace(1,size_method,size_method);
sulon = plot(x,mean(rt_u_lon));
hold on;
svlon = plot(x,mean(rt_v_lon));
title('u,v overall mean rmse -- time');
legend([sulon svlon  ],'sulon','svlon','Location','SouthOutside');


%% get min mean rmse and show the percentage increasing from the minimum

figure(figIndex);
figIndex = figIndex+1;

% plot u lon
subplot(121);
[su1,index1] = sort(mean(rt_u_lon));
su1_per  = (su1-su1(1))/su1(1) * 100;

su1_per = su1_per(su1_per<baseline);
index1 = index1(1:size(su1_per,2));
size_M = size(su1_per,2);
x = linspace(1,size_M,size_M);
perulon = plot(x,su1_per,'-s');
text(x,su1_per+0.4,getMNameByIndex(index1));
title('u mean rmse difference percentage lon -- time');

% plot u lat
% clear index1,su1_per,x,size_M;
subplot(122);
[su2,index2] = sort(mean(rt_v_lon));
su2_per  = (su2-su2(1))/su2(1) * 100;

su2_per = su2_per(su2_per<baseline);
index2 = index2(1:size(su2_per,2));
size_M = size(su2_per,2);
x = linspace(1,size_M,size_M);

perulat = plot(x,su2_per,'-o');
text(x,su2_per-0.4,getMNameByIndex(index2));
title('v mean rmse difference percentage lon -- time');
% legend([perulon perulat  ],'sulon','sulat','Location','SouthOutside');

% plot su,sv
figure(figIndex);
figIndex = figIndex+1;

% plot su lon
% clear index2,sv2_per,x,size_M;
subplot(121);

[sv1,index1] = sort(mean(rt_su_lon));
sv1_per  = (sv1-sv1(1))/sv1(1) * 100;

sv1_per = sv1_per(sv1_per<baseline);
index1 = index1(1:size(sv1_per,2));
size_M = size(sv1_per,2);
x = linspace(1,size_M,size_M);

pervlon = plot(x,sv1_per,'-s');
text(x,sv1_per+0.4,getMNameByIndex(index1));
title('su mean rmse difference percentage lon -- time');

subplot(122);
% clear index2,sv1_per,x,size_M;
[sv2,index2] = sort(mean(rt_sv_lon));
sv2_per  = (sv2-sv2(1))/sv2(1) * 100;

sv2_per = sv2_per(sv2_per<baseline);
index2 = index2(1:size(sv2_per,2));
size_M = size(sv2_per,2);
x = linspace(1,size_M,size_M);

pervlat = plot(x,sv2_per,'-o');
text(x,sv2_per-0.4,getMNameByIndex(index2));
title('sv mean rmse difference percentage lon -- time');
% legend([pervlon pervlat  ],'ssulon','ssulat','Location','SouthOutside');

%% plot time
% 1b) plot u--lon
figure(figIndex);
figIndex = figIndex+1;
x = linspace(1,size_datdaset,size_datdaset);

subplot(121);
mpv = plot(x,rt_u_lon(:,compV1));
hold on;
mp = plot(x,rt_u_lon(:,compV2));
title('u lon comparision--time');
legend([mpv mp  ],varname1,varname2,'Location','SouthOutside');

% 2b) plot v--lon
subplot(122);
mpv = plot(x,rt_v_lon(:,compV1));
hold on;
mp = plot(x,rt_v_lon(:,compV2));
hold on;
title('v lon comparision--time');
legend([mpv mp  ],varname1,varname2,'Location','SouthOutside');


%% plot mean rmse

% lon time
figure(figIndex);
figIndex = figIndex+1;
subplot(131);
x = linspace(1,rmse_size,rmse_size);
temp = mean(rt_u_lon)+mean(rt_v_lon);
rmse = [temp(compV1),temp(compV2)];
rmse_tlon = [rmse_tlon , rmse];
grid on;
bar(x,rmse);

title('mean rmse lon u+v comparision--time');
legend({'sp','mp','se','mpv'});

% lon time--u
subplot(132);
x = linspace(1,rmse_size,rmse_size);
temp = mean(rt_u_lon);
rmse = [temp(compV1),temp(compV2)];
rmse_tlon = [rmse_tlon , rmse];
grid on;
bar(x,rmse);

title('mean rmse lon u comparision--time');
legend({'sp','mp','se','mpv'});

% lon time--v
subplot(133);
x = linspace(1,rmse_size,rmse_size);
temp = mean(rt_v_lon);
rmse = [temp(compV1),temp(compV2)];
rmse_tlon = [rmse_tlon , rmse];
grid on;
bar(x,rmse);

title('mean rmse lon v comparision--time');
legend({'sp','mp','se','mpv'});

%% calculate percentage
clc;
p_tlon= [];

p_tlon(1) = (rmse_tlon(2)- rmse_tlon(1))/rmse_tlon(1)*100;
p_tlon(2) = (rmse_tlon(4)- rmse_tlon(3))/rmse_tlon(3)*100;
p_tlon(3) = (rmse_tlon(6)- rmse_tlon(5))/rmse_tlon(5)*100;

disp('----------------------');
disp('precentage time lon');
p_tlon


