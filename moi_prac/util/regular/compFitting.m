function compFitting()% 
basepath = [cd,'/','moi_prac','/','reuse','/','normalday','/vms/'];
% basepath = [cd,'/','moi_prac','/','td_fea','/','typhoon','/'];
filename = 'Inter_vms_reuse_s_timeall_r';
reuse_suffix = '_reuse_p';
mat_suffix = '.mat';
% reuse_suffix,
filename = [basepath,filename,mat_suffix];
load(filename);

pu = []; pv = [];
spu = []; spv = [];

reg_size = size(rmse,2);
covu = [];
covv = [];
for i = 1:1    
    pu = [pu;u{i}{2}]';
    pv = [pv;v{i}{2}]';
    spu = [spu;u{i}{3}]';
    spv = [spv;v{i}{3}]';    
    covu = [covu;ysu{i}{1}]';
    covv = [covv;ysv{i}{1}]';
end

ptsize = size(pu,2);
figure('NumberTitle','off','Name','reused result s time all')
subplot(121)
xx = linspace(ptsize,1,ptsize);
mult = plot(xx,pu,'-+','LineWidth',1.5);
hold on;
sp = plot(xx,spu,'-+','LineWidth',1.5);
legend([mult sp],'ru','su')
h = annotation('textbox',[0.15 0.87 0.02 0.03],...
    'String',{'(a)'},...
    'FitBoxToText','off');
h.LineStyle = 'none';
set(h,'FontSize',16);
xlabel('Region Index');
ylabel('RMSE');
title('u');

subplot(122)
xx = linspace(ptsize,1,ptsize)';
mult = plot(xx,pv,'-+','LineWidth',1.5);
hold on;
sp = plot(xx,spv,'-+','LineWidth',1.5);
legend([mult sp],'rv','sv')
xlabel('Region Index');
ylabel('RMSE');

title('v')
h = annotation('textbox',[0.59 0.87 0.02 0.03],...
    'String',{'(b)'},...
    'FitBoxToText','off');
h.LineStyle = 'none';
set(h,'FontSize',16);


