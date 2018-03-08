% time and space interpoaltion for single variable

function rmse = t_multV()
%% global variables
samp_inter = 5; %interval for sampling from y which load from file and x;

size_hyp_3_p = 27 ; %the size of hyperparameters for method3_pressure: multi
size_hyp_3_t = 27 ; %the size of hyperparameters for method3_temperature: multi
size_hyp_3_d = 5 ; %the size of hyperparameters for method3_direction: only periodic
size_hyp_3_time = 10 ; %the size of hyperparameters for method3_time: matern+periodic
size_hyp_3 = size_hyp_3_p + size_hyp_3_t + size_hyp_3_d + size_hyp_3_time;

filename = 'ts_windsLON7.txt';
filename_t = 't_tempLON7.txt';
filename_p = 't_pressLON7.txt';
filename_d = 't_winddLON7.txt';
filename_time = 't_windsLON7.txt';

%% read data
[x,y,x_train,y_train,x_test,y_test] = data_pre(filename,samp_inter);
[xtemp,ytemp,xtemp_train,ytemp_train,xtemp_test,ytemp_test] = data_pre(filename_t,samp_inter);
[xpress,ypress,xpress_train,ypress_train,xpress_test,ypress_test] = data_pre(filename_p,samp_inter);
[xd,yd,xd_train,yd_train,xd_test,yd_test] = data_pre(filename_d,samp_inter);
[xt,yt,xt_train,yt_train,xt_test,yt_test] = data_pre(filename_time,samp_inter);


%% covfunc--the ard function which can use the mult dimension

%   covfun_perard = {@covPERard,0.1};

 covfun_perard = {'covSEard'};

covfunc3_pres = {'covSum',{{@covMaternard,3},{'covProd',{{@covMaternard,3},'covSEard'}},{ 'covRQard' },{'covSum',{{@covMaternard,3},'covNoise'}}}};
covfunc3_temp = {'covSum',{{@covMaternard,3},{'covProd',{{@covMaternard,3},'covSEard'}},{ 'covRQard' },{'covSum',{{@covMaternard,3},'covNoise'}}}};
covfunc3_direc = {'covSEard'};
covfunc3_time = {'covSum',{{@covMaternard,1},'covSEard'}};

covfunc3 = {'covProd',{covfunc3_direc,covfunc3_time,{'covSum',{covfunc3_temp,covfunc3_pres}}}};

hyp3.cov = zeros(1,size_hyp_3)';
hyp3.lik = log(0.1) ;
likfunc3 = @likGauss;

x_train  = [xt_train yd_train ytemp_train ypress_train];
y_train = y_train;
x_test = [xt_test yd_test ytemp_test ypress_test];

x = xt;
y = y;
y_test = y_test;

[mu s2 fmu fs2] = gp(hyp3, @infGaussLik, [], covfunc3, likfunc3, x_train, y_train, x_test);

figure(1)
set(gca, 'FontSize', 18)
f = [mu+2*sqrt(s2); flipdim(mu-2*sqrt(s2),1)];

ffill = fill([x_test; flipdim(x_test,1)], f, [191 225 105]/256)
hold on; 
fplot = plot(x_test, mu, 'linestyle','-','color','r','linewidth',3);
truey = plot(x, y,'.','markersize',16,'markeredgecolor',[156 0 181]/256);
% hold on; plot(x_test,y_test,'ro','MarkerSize',10)
grid on
xlabel('input, x_train')
ylabel('output, y_train')
title('multiple variables with time interpolation for wind speed')
% legend([ffill fplot,truey],'95% confidence interval','regression function','true state','Location','NorthWest')

nSize_test = size(y_test,1);

rmse = sqrt((sum(mu-y_test).^2)/nSize_test);

