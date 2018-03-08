function varTrend(rmse)
r_u = rmse(1,:);
r_v = rmse(2,:);
r_su = rmse(3,:);
r_sv = rmse(4,:);

method_size = size(r_u,2);
x = linspae(1,method_size,method_szie);

figure;
u = plot(x,r_u,'-.');
v = plot(x,r_v,'-o');
su = plot(x,r_su,'-d');
sv = plot(x,r_sv,'-+');
title('error trend');
legend([u v su sv],'u','v','su','sv');





