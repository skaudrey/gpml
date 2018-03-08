% compPerHyper

basepath = [cd,'/moi_prac/reuse/normalday/vms/space/time4/'];

filename = 'Inter_vms__space.mat';

load([basepath,filename]);

covU = []; covV = [];
likU = []; likV = [];

reg_size = size(rmse,2);
param_size = size(hyper{1}{1}.cov,1);

for i = 1:reg_size    
    covU = [covU,hyper{i}{1}.cov];
    covV = [covV,hyper{i}{1}.cov];
    likU = [likU,hyper{i}{1}.lik];
    likV = [likV,hyper{i}{1}.lik];
end

%% plot scatter of one typhoon
xx = linspace(1,reg_size,reg_size);
figure('NumberTitle','off','Name','typhoon u hyper of cov per parameters')
for i=1:param_size
    subplot(5,6,i)
    scatter(xx,covV(i,:));
    hold on;
end


figure('NumberTitle','off','Name','typhoon v hyper of cov per parameters')
for i=1:param_size
    subplot(5,6,i)
    scatter(xx,covV(i,:));
    hold on;
end

figure('NumberTitle','off','Name','typhoon u hyper of lik per parameters')
subplot(1,2,1)
scatter(xx,likU);
title('u lik');
hold on;
subplot(1,2,2);
scatter(xx,likV);
title('v lik');

%% boxplot one typhoon
% xx = linspace(1,reg_size,reg_size);
% figure('NumberTitle','off','Name','typhoon u hyper of cov per parameters')
% for i=1:param_size
%     subplot(5,6,i)
%     boxplot(covV(i,:),0,'+',1);
%     hold on;
% end
% 
% 
% figure('NumberTitle','off','Name','typhoon v hyper of cov per parameters')
% for i=1:param_size
%     subplot(5,6,i)
%     boxplot(covV(i,:),0,'+',1);
%     hold on;
% end
% 
% figure('NumberTitle','off','Name','typhoon u hyper of lik per parameters')
% subplot(1,2,1)
% boxplot(likU,0,'+',1);
% title('u lik');
% hold on;
% subplot(1,2,2);
% boxplot(likV,0,'+',1);
% title('v lik');

