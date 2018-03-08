function reg_epoch()
%almost convergent at the epoch 20
size_epoch = 10;

mat_r = {};mpng_r = [];mpprod_r = [];mpsum_r = [];mpngpprod_r = [];mpngpsum_r = []; spline_r = [];

n_reg1 = 'D:\Code\Matlab\gpml\moi_prac\normalday\Inter_s_LON0.125-6LAT20.625-24.25.mat';
n_reg2 = 'D:\Code\Matlab\gpml\moi_prac\normalday\Inter_s_LON0.125-6LAT21.625-25.25.mat';
n_reg3 = 'D:\Code\Matlab\gpml\moi_prac\normalday\Inter_s_LON0.125-6LAT23.625-27.25.mat';
t_reg1 = 'D:\Code\Matlab\gpml\moi_prac\typhoon\Inter_s_LON0.125-6LAT20.625-24.25.mat';
t_reg2 = 'D:\Code\Matlab\gpml\moi_prac\typhoon\Inter_s_LON0.125-6LAT21.625-25.25.mat';
t_reg3 = 'D:\Code\Matlab\gpml\moi_prac\typhoon\Inter_s_LON0.125-6LAT23.625-27.25.mat';

reg = {n_reg1,n_reg2,n_reg3,t_reg1,t_reg2,t_reg3};

size_reg = size(reg,2);

for index = 1:size_reg
    load(reg{index});
    mat = []; mpng = []; mpprod = []; mpsum = []; mpngpprod = [];mpngpsum = [];spline = [];
    for i = 1:size_epoch
        mat = [mat,rmse{i}(:,1)];
        mpng = [mpng,rmse{i}(:,2)];
        mpprod = [mpprod,rmse{i}(:,3)];
        mpsum = [mpsum,rmse{i}(:,4)];
        mpngpprod = [mpngpprod,rmse{i}(:,5)];
        mpngpsum = [mpngpsum,rmse{i}(:,6)];
        spline = [spline,rmse{i}(:,7)];
    end
    mat_r{index} = mat;
    mpng_r{index} = mpng;
    mpprod_r{index} = mpprod;
    mpsum_r{index} = mpsum;
    mpngpprod_r{index} = mpngpprod;
    mpngpsum_r{index} = mpngpsum;
    spline_r{index} = spline;
end




x = linspace(1,size_epoch,size_epoch);

figure
subplot(231)
r1 = plot(x,mat_r{1}(1,:));
hold on;
r4 = plot(x,mat_r{4}(1,:));
legend([r1,r4],'reg1_n','reg1_t');
title('u reg_1 of mat');

subplot(232)
r2 = plot(x,mat_r{2}(1,:));
hold on;
r5 = plot(x,mat_r{5}(1,:));
legend([r2,r5],'reg2_n','reg2_t');
title('u reg_2 of mat');

subplot(233)
r3 = plot(x,mat_r{3}(1,:));
hold on;
r6 = plot(x,mat_r{6}(1,:));
legend([r2,r5],'reg3_n','reg3_t');
title('u reg_3 of mat');

subplot(234)
r1 = plot(x,mat_r{1}(2,:));
hold on;
r4 = plot(x,mat_r{4}(2,:));
legend([r1,r4],'reg1_n','reg1_t');
title('v reg_1 of mat');

subplot(235)
r2 = plot(x,mat_r{2}(2,:));
hold on;
r5 = plot(x,mat_r{5}(2,:));
legend([r2,r5],'reg2_n','reg2_t');
title('v reg_2 of mat');

subplot(236)
r3 = plot(x,mat_r{3}(2,:));
hold on;
r6 = plot(x,mat_r{6}(2,:));
legend([r2,r5],'reg3_n','reg3_t');
title('v reg_3 of mat');