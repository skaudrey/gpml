function epoch(rmse)

size_epoch = size(rmse,2);

mat = [];mpng = [];mpprod = [];mpsum = [];mpngpprod = [];mpngpsum = []; spline = [];


for i = 1:size_epoch
    mat = [mat,rmse{i}(:,1)];
    mpng = [mpng,rmse{i}(:,2)];
    mpprod = [mpprod,rmse{i}(:,3)];
    mpsum = [mpsum,rmse{i}(:,4)];
    mpngpprod = [mpngpprod,rmse{i}(:,5)];
    mpngpsum = [mpngpsum,rmse{i}(:,6)];
    spline = [spline,rmse{i}(:,7)];
end

x = linspace(1,size_epoch,size_epoch);

figure
subplot(221)
m1 = plot(x,mat(1,:));
hold on;
m2 = plot(x,mpng(1,:));
hold on;
m3 = plot(x,mpprod(1,:));
hold on;
m4 = plot(x,mpsum(1,:));
hold on;
m5 = plot(x,mpngpprod(1,:));
hold on;
m6 = plot(x,mpngpsum(1,:));
hold on;
m7 = plot(x,spline(1,:));
legend([m1,m2,m3,m4,m5,m6,m7],'mat','mpng','mpprod','mpsum','mpngpprod','mpngpsum','spline');
% legend([m1,m7],'mat','spline');
title('u epoch dynamic each method');

subplot(222)
m1 = plot(x,mat(2,:));
hold on;
m2 = plot(x,mpng(2,:));
hold on;
m3 = plot(x,mpprod(2,:));
hold on;
m4 = plot(x,mpsum(2,:));
hold on;
m5 = plot(x,mpngpprod(2,:));
hold on;
m6 = plot(x,mpngpsum(2,:));
hold on;
m7 = plot(x,spline(2,:));
legend([m1,m2,m3,m4,m5,m6,m7],'mat','mpng','mpprod','mpsum','mpngpprod','mpngpsum','spline');
% legend([m1,m7],'mat','spline');
title('v epoch dynamic each method');

subplot(223)
m1 = plot(x,mat(3,:));
hold on;
m2 = plot(x,mpng(3,:));
hold on;
m3 = plot(x,mpprod(3,:));
hold on;
m4 = plot(x,mpsum(3,:));
hold on;
m5 = plot(x,mpngpprod(3,:));
hold on;
m6 = plot(x,mpngpsum(3,:));
hold on;
m7 = plot(x,spline(3,:));
legend([m1,m2,m3,m4,m5,m6,m7],'mat','mpng','mpprod','mpsum','mpngpprod','mpngpsum','spline');
% legend([m1,m7],'mat','spline');
title('su epoch dynamic each method');

subplot(224)
m1 = plot(x,mat(4,:));
hold on;
m2 = plot(x,mpng(4,:));
hold on;
m3 = plot(x,mpprod(4,:));
hold on;
m4 = plot(x,mpsum(4,:));
hold on;
m5 = plot(x,mpngpprod(4,:));
hold on;
m6 = plot(x,mpngpsum(4,:));
hold on;
m7 = plot(x,spline(4,:));
legend([m1,m2,m3,m4,m5,m6,m7],'mat','mpng','mpprod','mpsum','mpngpprod','mpngpsum','spline');
% legend([m1,m7],'mat','spline');
title('sv epoch dynamic each method');

figure
subplot(221)
m1 = plot(x,mat(1,:));
hold on;
m7 = plot(x,spline(1,:));
legend([m1,m7],'mat','spline');
title('u epoch dynamic each method');

subplot(222)
m1 = plot(x,mat(2,:));
hold on;
m7 = plot(x,spline(2,:));
legend([m1,m7],'mat','spline');
title('v epoch dynamic each method');

subplot(223)
m1 = plot(x,mat(3,:));
hold on;
m7 = plot(x,spline(3,:));
legend([m1,m7],'mat','spline');
title('su epoch dynamic each method');

subplot(224)
m1 = plot(x,mat(4,:));
hold on;
m7 = plot(x,spline(4,:));
legend([m1,m7],'mat','spline');
title('sv epoch dynamic each method');
