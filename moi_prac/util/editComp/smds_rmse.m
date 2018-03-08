basepath = [cd,'/moi_prac/reuse/normalday/'];
sapcepath_vms = [basepath 'vms/space/time4/']; % space vms interpolation path
sapce_smd_path = [sapcepath_vms 'smd/']; % space vms interpolation smd path
timepath_vms = [basepath 'vms/time/reg1/']; % time vms interpolation path
time_smd_path = [timepath_vms 'smd/'];  % time vms interpolation smd path
spacepath_mpng = [basepath 'mpng/space/time4/']; % space mpng interpolation path
timepath_mpng = [basepath 'mpng/time/reg1/']; % time mpng interpolation path

regPath = {sapcepath_vms,sapce_smd_path,timepath_vms,time_smd_path,spacepath_mpng,timepath_mpng};
filename = {'Inter_vms_space.mat','Inter_vms_space_smd.mat','Inter_vms_time.mat','Inter_vms_time_smd.mat','Inter_mpng_space.mat','Inter_mpng_time.mat','Inter_vms_nospar_space.mat'};


s1 = load([regPath{1},filename{1}]);
s2 = load([regPath{2},filename{2}]);
s3 = load([regPath{3},filename{3}]);
s4 = load([regPath{4},filename{4}]);
s5 = load([regPath{5},filename{5}]);
s6 = load([regPath{6},filename{6}]);
s7 = load([regPath{1},filename{7}]);
% s7 = load([regPath{6},filename{8}]);

rmse_size = size(s1.rmse,2);

r_vms_s = []; r_vms_s_smd = []; r_mpng_s = []; r_vms_s_nospar_s = [];
r_vms_t = []; r_vms_t_smd = []; r_mpng_t = [];
r_sp_s = [];  
r_sp_t = []; 


for i = 1: rmse_size
    r_sp_s = [r_sp_s s1.rmse{i}(1:2,2)];
    r_sp_t = [r_sp_t s3.rmse{i}(1:2,2)];
    
    r_vms_s = [r_vms_s s1.rmse{i}(1:2,1)];
    r_vms_s_smd = [r_vms_s_smd s2.rmse{i}(1:2,1)];
    r_mpng_s = [r_mpng_s s5.rmse{i}(1:2,1)];
    r_vms_s_nospar_s = [r_vms_s_nospar_s s7.rmse{i}(1:2,1)];
    
    r_vms_t = [r_vms_t s3.rmse{i}(1:2,1)];
    r_vms_t_smd = [r_vms_t_smd s4.rmse{i}(1:2,1)];
    r_mpng_t = [r_mpng_t s6.rmse{i}(1:2,1)];
   
   
%     r_sp_s_smd = [r_sp_s_smd s2.rmse{i}(1:2,1)];
   
%     r_sp_t_smd = [r_sp_t_smd s4.rmse{i}(1:2,1)];
end

% diff
r_vms_s = r_vms_s - r_sp_s;   r_vms_s_smd = r_vms_s_smd - r_sp_s;    r_mpng_s = r_mpng_s - r_sp_s;  r_vms_s_nospar_s = r_vms_s_nospar_s - r_sp_s;
r_vms_t = r_vms_t - r_sp_t;   r_vms_t_smd = r_vms_t_smd - r_sp_t;   r_mpng_t = r_mpng_t - r_sp_t;

x = linspace(1,rmse_size,rmse_size);

%% The RMSE of space interpolation and space smd interpolation -- sparse method
figure;
subplot(221);
% plot(x,r_vms_s(1,:),x,r_vms_s_smd(1,:),x,r_sp_s(1,:),x,r_mpng_s(1,:),x,r_vms_s_nospar_s(1,:),'LineWidth',2);
plot(x,r_vms_s(1,:),x,r_vms_s_smd(1,:),x,r_mpng_s(1,:),x,r_vms_s_nospar_s(1,:),'LineWidth',2);
% hold on;
% p2 = plot(x,);
% hold on;
% p3 = plot(x,);
% legend('vms_smds','vms_smd','spline','mpng_smds','vms_smds_nospar');
legend('vms_smds','vms_smd','mpng_smds','vms_smds_nospar');
title('space interpolation u');

subplot(222);
plot(x,r_vms_s(2,:),x,r_vms_s_smd(2,:),x,r_mpng_s(2,:),x,r_vms_s_nospar_s(2,:),'LineWidth',2);
% hold on;
% p2 = plot(x,);
% hold on;
% p3 = plot(x,);

% legend([p1,p2,p3], {'smds','smd','spline'});
% legend('vms_smds','vms_smd','spline','mpng_smds','vms_smds_nospar');
legend('vms_smds','vms_smd','mpng_smds','vms_smds_nospar');
title('space interpolation u');

subplot(223);
% plot(x,r_vms_t(1,:),x,r_vms_t_smd(1,:),x,r_sp_t(1,:),x,r_mpng_t(1,:),'LineWidth',2);
plot(x,r_vms_t(1,:),x,r_vms_t_smd(1,:),x,r_mpng_t(1,:),'LineWidth',2);
% hold on;
% p2 = plot(x,);
% hold on;
% p3 = plot(x,);
% legend([p1,p2,p3], {'smds','smd','spline'});
% legend('vms_smds','vms_smd','spline','mpng_smds');
legend('vms_smds','vms_smd','mpng_smds');
title('time interpolation u');

subplot(224);
% plot(x,r_vms_t(2,:),x,r_vms_t_smd(2,:),x,r_sp_t(2,:),x,r_mpng_t(2,:),'LineWidth',2);
plot(x,r_vms_t(2,:),x,r_vms_t_smd(2,:),x,r_mpng_t(2,:),'LineWidth',2);
% hold on;
% p2 = plot(x,);
% hold on;
% p3 = plot(x,);
% legend([p1,p2,p3], {'smds','smd','spline'});
% legend('vms_smds','vms_smd','spline','mpng_smds');
legend('vms_smds','vms_smd','mpng_smds');
title('time interpolation v');




