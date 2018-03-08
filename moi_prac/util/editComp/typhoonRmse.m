path = 'D:\Code\Matlab\gpml\moi_prac\reuse\typhoon\';
file1 = 'kamurri\Inter_kamurri_reuse_p_smds.mat';
file2 = 'seagull\Inter_seagull_reuse_p_smds.mat';
file3 = 'fenggod\Inter_fenggod_reuse_p_smds.mat';

f1 = load([path file1]);
f2 = load([path file2]);
f3 = load([path file3]);

rAll = [];

ru = []; rv = []; su = []; sv = []; bu = []; bv = [];

reg_size = size(f1.rmse,2);

for i = 1:reg_size    
    ru = [ru,f1.rmse{i}(1,1)];
    rv = [rv,f1.rmse{i}(2,1)]; 
    su = [su,f1.rmse{i}(1,2)];
    sv = [sv,f1.rmse{i}(2,2)];    
    bu = [bu,f1.rmse{i}(1,3)];
    bv = [bv,f1.rmse{i}(2,3)];  
end

reg_size = size(f2.rmse,2);

for i = 1:reg_size    
    ru = [ru,f2.rmse{i}(1,1)];
    rv = [rv,f2.rmse{i}(2,1)]; 
    su = [su,f2.rmse{i}(1,2)];
    sv = [sv,f2.rmse{i}(2,2)];    
    bu = [bu,f2.rmse{i}(1,3)];
    bv = [bv,f2.rmse{i}(2,3)];  
end

reg_size = size(f3.rmse,2);

for i = 1:reg_size    
    ru = [ru,f3.rmse{i}(1,1)];
    rv = [rv,f3.rmse{i}(2,1)]; 
    su = [su,f3.rmse{i}(1,2)];
    sv = [sv,f3.rmse{i}(2,2)];    
    bu = [bu,f3.rmse{i}(1,3)];
    bv = [bv,f3.rmse{i}(2,3)];  
end

rU = [ru;su;bu];
rV = [rv;sv;bv];

plot_size = size(rU,2);
figure;
subplot(121);
xx = linspace(1,plot_size,plot_size);
scatter(xx,rU(1,:),'filled');
hold on;
scatter(xx,rU(2,:),'filled');
hold on;
scatter(xx,rU(3,:),'filled');
legend({'k','sp','bp'})

subplot(122);
xx = linspace(1,plot_size,plot_size);

scatter(xx,rV(1,:),'filled');
hold on;
scatter(xx,rV(2,:),'filled');
hold on;
scatter(xx,rV(3,:),'filled');
legend({'k','sp','bp'})
