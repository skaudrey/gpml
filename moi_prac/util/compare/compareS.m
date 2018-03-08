%% compare sp,mp,mult,multv,se,mpv of space

%% wind interpolation result comparation
clear all;close all;clc;
s_lat_file = 'EC25_s_lat.mat';
s_lon_file = 'EC25_s_lon.mat';
% t_lon_file = 't_lon.mat';

load(s_lat_file);
load(s_lon_file);
% load(t_lon_file);

size_datdaset = 8;
size_method = 20;
figIndex = 1;

compV1 = 5;  %compare v1,5 for pcaSum
compV2 = 20; % 2 for mp
varname1 = 'pcasum';varname2 = 'mpng';
rmse_slon = [];
rmse_slat = [];
rmse_tlon = [];

baseline = 80;

%% plot the overall mean rmse
figure(figIndex);
figIndex = figIndex+1;

x = linspace(1,size_method,size_method);
subplot(121);
sulon = plot(x,mean(rs_u_lon));
hold on;
sulat = plot(x,mean(rs_u_lat));
hold on;
sslon = plot(x,mean(rs_su_lon));
hold on;
sslat = plot(x,mean(rs_su_lat));

title('u overall mean rmse including recalculated u from speed and direction -- space');
legend([sulon sulat sslon sslat ],'sulon','sulat','sslon','sslat','Location','SouthOutside');

subplot(122);
svlon = plot(x,mean(rs_v_lon));
hold on;
svlat = plot(x,mean(rs_v_lat));
hold on;
sdlon = plot(x,mean(rs_sv_lon));
hold on;
sdlat = plot(x,mean(rs_sv_lat));
title('v overall mean rmse including recalculated v from speed and direction -- space');
legend([svlon svlat sdlon sdlat ],'svlon','svlat','sdlon','sdlat','Location','SouthOutside');


%% plot overall mean rmse of one variable
figure(figIndex);
figIndex = figIndex+1;

x = linspace(1,size_method,size_method);
subplot(221);
sulon = plot(x,mean(rs_u_lon));
hold on;
sulat = plot(x,mean(rs_u_lat));
title('u overall mean rmse -- space');
legend([sulon sulat  ],'sulon','sulat','Location','SouthOutside');

subplot(222);
svlon = plot(x,mean(rs_v_lon));
hold on;
svlat = plot(x,mean(rs_v_lat));
title('v overall mean rmse -- space');
legend([svlon svlat  ],'svlon','svlat','Location','SouthOutside');


subplot(223);
sslon = plot(x,mean(rs_su_lon));
hold on;
sslat = plot(x,mean(rs_su_lat));
title('su overall mean rmse -- space');
legend([sslon sslat  ],'sslon','sslat','Location','SouthOutside');


subplot(224);
sdlon = plot(x,mean(rs_sv_lon));
hold on;
sdlat = plot(x,mean(rs_sv_lat));
title('sv overall mean rmse -- space');
legend([sdlon sdlat  ],'sdlon','sdlat','Location','SouthOutside');

%% get min mean rmse and show the percentage increasing from the minimum

figure(figIndex);
figIndex = figIndex+1;

% plot u lon
subplot(221);
[su1,index1] = sort(mean(rs_u_lon));
su1_per  = (su1-su1(1))/su1(1) * 100;

su1_per = su1_per(su1_per<baseline);
index1 = index1(1:size(su1_per,2));
size_M = size(su1_per,2);
x = linspace(1,size_M,size_M);
perulon = plot(x,su1_per,'-s');
text(x,su1_per+0.4,getMNameByIndex(index1));
title('u mean rmse difference percentage lon -- space');

% plot u lat
% clear index1,su1_per,x,size_M;
subplot(222);
[su2,index2] = sort(mean(rs_u_lat));
su2_per  = (su2-su2(1))/su2(1) * 100;

su2_per = su2_per(su2_per<baseline);
index2 = index2(1:size(su2_per,2));
size_M = size(su2_per,2);
x = linspace(1,size_M,size_M);

perulat = plot(x,su2_per,'-o');
text(x,su2_per-0.4,getMNameByIndex(index2));
title('u mean rmse difference percentage lat -- space');
% legend([perulon perulat  ],'sulon','sulat','Location','SouthOutside');

% plot v lon
% clear index2,su2_per,x,size_M;
subplot(223);
[sv1,index1] = sort(mean(rs_v_lon));
sv1_per  = (sv1-sv1(1))/sv1(1) * 100;

sv1_per = sv1_per(sv1_per<baseline);
index1 = index1(1:size(sv1_per,2));
size_M = size(sv1_per,2);
x = linspace(1,size_M,size_M);

pervlon = plot(x,sv1_per,'-s');
text(x,sv1_per+0.4,getMNameByIndex(index1));
title('v mean rmse difference percentage lon -- space');

% plot v lat
% clear index1,sv1_per,x,size_M;
subplot(224);
[sv2,index2] = sort(mean(rs_v_lat));
sv2_per  = (sv2-sv2(1))/sv2(1) * 100;

sv2_per = sv2_per(sv2_per<baseline);
index2 = index2(1:size(sv2_per,2));
size_M = size(sv2_per,2);
x = linspace(1,size_M,size_M);

pervlat = plot(x,sv2_per,'-o');
text(x,sv2_per-0.4,getMNameByIndex(index2));
title('v mean rmse difference percentage lat -- space');
% legend([pervlon pervlat  ],'svlon','svlat','Location','SouthOutside');

% plot su,sv
figure(figIndex);
figIndex = figIndex+1;

% plot su lon
% clear index2,sv2_per,x,size_M;
subplot(221);

[sv1,index1] = sort(mean(rs_su_lon));
sv1_per  = (sv1-sv1(1))/sv1(1) * 100;

sv1_per = sv1_per(sv1_per<baseline);
index1 = index1(1:size(sv1_per,2));
size_M = size(sv1_per,2);
x = linspace(1,size_M,size_M);

pervlon = plot(x,sv1_per,'-s');
text(x,sv1_per+0.4,getMNameByIndex(index1));
title('su mean rmse difference percentage lon -- space');

subplot(222);
% clear index2,sv1_per,x,size_M;
[sv2,index2] = sort(mean(rs_su_lat));
sv2_per  = (sv2-sv2(1))/sv2(1) * 100;

sv2_per = sv2_per(sv2_per<baseline);
index2 = index2(1:size(sv2_per,2));
size_M = size(sv2_per,2);
x = linspace(1,size_M,size_M);

pervlat = plot(x,sv2_per,'-o');
text(x,sv2_per-0.4,getMNameByIndex(index2));
title('su mean rmse difference percentage lat -- space');
% legend([pervlon pervlat  ],'ssulon','ssulat','Location','SouthOutside');

subplot(223);
% clear index2,sv2_per,x,size_M;
[sv1,index1] = sort(mean(rs_sv_lon));
sv1_per  = (sv1-sv1(1))/sv1(1) * 100;

sv1_per = sv1_per(sv1_per<baseline);
index1 = index1(1:size(sv1_per,2));
size_M = size(sv1_per,2);
x = linspace(1,size_M,size_M);

pervlon = plot(x,sv1_per,'-s');
text(x,sv1_per+0.4,getMNameByIndex(index1));
title('sv mean rmse difference percentage lon -- space');


subplot(224);
% clear index2,sv1_per,x,size_M;
[sv2,index2] = sort(mean(rs_sv_lat));
sv2_per  = (sv2-sv2(1))/sv2(1) * 100;

sv2_per = sv2_per(sv2_per<baseline);
index2 = index2(1:size(sv2_per,2));
size_M = size(sv2_per,2);
x = linspace(1,size_M,size_M);

pervlat = plot(x,sv2_per,'-o');
text(x,sv2_per-0.4,getMNameByIndex(index2));
title('sv mean rmse difference percentage lat -- space');
% legend([pervlon pervlat  ],'ssvlon','ssvlat','Location','SouthOutside');

%% plot space
% 1a) plot u--lat
figure(figIndex);
figIndex = figIndex+1;

x = linspace(1,size_datdaset,size_datdaset);
subplot(221);
mpv = plot(x,rs_u_lat(:,compV1));
hold on;
mp = plot(x,rs_u_lat(:,compV2));
% hold on;
% se = plot(x,rs_u_lat(:,7));
% hold on;
% mpv = plot(x,rs_v_lat(:,13));


title('u lat comparision--space');
legend([mpv mp  ],varname1,varname2,'Location','SouthOutside');

% 1b) plot u--lon
% figure(figIndex);
% figIndex = figIndex+1;
subplot(222);
mpv = plot(x,rs_u_lon(:,compV1));
hold on;
mp = plot(x,rs_u_lon(:,compV2));
% hold on;
% se = plot(x,rs_u_lon(:,7));
% hold on;
% mpv = plot(x,rs_v_lat(:,13));
title('u lon comparision--space');
legend([mpv mp  ],varname1,varname2,'Location','SouthOutside');
% 2a) plot v--lat
subplot(223);
mpv = plot(x,rs_v_lat(:,compV1));
hold on;
mp = plot(x,rs_v_lat(:,compV2));

title('v lat comparision--space');
legend([mpv mp  ],varname1,varname2,'Location','SouthOutside');

% 2b) plot v--lon
subplot(224);
mpv = plot(x,rs_v_lon(:,compV1));
hold on;
mp = plot(x,rs_v_lon(:,compV2));
title('v lon comparision--space');
legend([mpv mp  ],varname1,varname2,'Location','SouthOutside');


%% plot mean rmse


rmse_size = 2;
% lon space--u+v
figure(figIndex);
figIndex = figIndex+1;
subplot(231);
x = linspace(1,rmse_size,rmse_size);
temp = mean(rs_u_lon)+mean(rs_v_lon);
rmse = [temp(compV1),temp(compV2)];
rmse_slon = [rmse_slon , rmse];
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
rmse = [temp(compV1),temp(compV2)];
rmse_slon = [rmse_slon , rmse];
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
rmse = [temp(compV1),temp(compV2)];
rmse_slon = [rmse_slon , rmse];
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
rmse = [temp(compV1),temp(compV2)];
rmse_slat = [rmse_slat , rmse];
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
rmse = [temp(compV1),temp(compV2)];
rmse_slat = [rmse_slat , rmse];
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
rmse = [temp(compV1),temp(compV2)];
rmse_slat = [rmse_slat , rmse];
grid on;
bar(x,rmse);

title('mean rmse lat v comparision--space');
legend({'sp','mp','se','mpv'});

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

% p_tlon(1) = (rmse_tlon(2)- rmse_tlon(1))/rmse_tlon(1)*100;
% p_tlon(2) = (rmse_tlon(4)- rmse_tlon(3))/rmse_tlon(3)*100;
% p_tlon(3) = (rmse_tlon(6)- rmse_tlon(5))/rmse_tlon(5)*100;
disp('precentage show: u+v, u , v');
disp([ '(' varname2 '-' varname1 ')/' varname1]);
disp('----------------------');
disp('precentage space lon');
p_slon
disp('----------------------');
disp('precentage space lat');
p_slat
% disp('----------------------');
% disp('precentage time lon');
% p_tlon
