% 
basepath = [cd,'/','moi_prac','/','reuse','/','normalday','/mpng/space/time15/'];
% basepath = [cd,'/','moi_prac','/','reuse','/','typhoon','/mpng/space/time15/'];
% filename = 'Inter_vms_reuse_t_regionall';
filename = 'Reuse_mpng_space';
reuse_suffix = '_reuse_p';
mat_suffix = '.mat';
% reuse_suffix,
filename = [basepath,filename,mat_suffix];
load(filename);

ru = []; rv = [];
su = []; sv = [];

reg_size = size(rmse,2);

for i = 1:reg_size    
    ru = [ru,rmse{i}(1,1)];
    rv = [rv,rmse{i}(2,1)];
    su = [su,rmse{i}(1,2)];
    sv = [sv,rmse{i}(2,2)];    
end

figure1 = figure('NumberTitle','off','Name','reused result s time all')
subplot1 = subplot(1,2,1,'Parent',figure1,'GridLineStyle','--',...
    'FontSize',36,...
    'XTick',[]);
box(subplot1,'on');
hold(subplot1,'on');
xx = linspace(1,reg_size,reg_size);
mult = plot(xx,ru,'-+','LineWidth',1.5);
hold on;
sp = plot(xx,su,'-+','LineWidth',1.5);
l1 = legend([mult sp],'ku','su')
h = annotation('textbox',[0.15 0.87 0.02 0.03],...
    'String',{'(a)'},...
    'FitBoxToText','off');
h.LineStyle = 'none';
set(h,'FontSize',36);
xlabel('Region Index');
ylabel('RMSE');
set(l1,'FontSize',48);
disp('======s========');
disp('mean rmse mult u:')
disp(num2str(mean(ru)));
disp('mean rmse spline u:')
disp(num2str(mean(su)))

subplot1 = subplot(1,2,2,'Parent',figure1,'GridLineStyle','--',...
    'FontSize',36,...
    'XTick',[]);
box(subplot1,'on');
hold(subplot1,'on');
xx = linspace(1,reg_size,reg_size);
mult = plot(xx,rv,'-+','LineWidth',1.5);
hold on;
sp = plot(xx,sv,'-+','LineWidth',1.5);
l2 = legend([mult sp],'kv','sv');
xlabel('Region Index');
ylabel('RMSE');
set(l2,'FontSize',48);

h = annotation('textbox',[0.59 0.87 0.02 0.03],...
    'String',{'(b)'},...
    'FitBoxToText','off');
h.LineStyle = 'none';
set(h,'FontSize',36);
disp('mean rmse mult v:')
disp(num2str(mean(rv)));
disp('mean rmse spline v:')
disp(num2str(mean(sv)))

