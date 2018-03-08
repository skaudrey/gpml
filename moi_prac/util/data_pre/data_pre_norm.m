% data preprocessing : normalized the data according to the standard
% covariance 
% need to test whether the data get close to the Gaussian distribution
function [x,y,x_train,y_train,x_test,y_test] = data_pre_norm(filename,samp_inter)

thresh = -9998;
%% generate the interpreted variable
% a) read data of target variable
y = load(filename)';
nSize_t = size(y);
nSize = nSize_t(1);

% b) plot the scatter diagram and delete the outlier
%% deal with the outlier
x = linspace(1,nSize,nSize)';
% figure(1)
% set(gca, 'FontSize', 18)
% plot(x,y,'o');
% xlabel('latitude order');
% ylabel('variable');
% title('scatter diagram for checking outlier');
%delete the outlier
outlier_index = find(y < thresh);  %get the index of the outlier,which means is out of the normal case,in this case we suppose it less than zero
y(outlier_index) = [];
% c) update some global variables
nSize_t = size(y);
nSize = nSize_t(1);
% x = linspace(1,nSize,nSize)';
x(outlier_index) = [];
% figure(2)
% disp('after delete the outlier');
% set(gca, 'FontSize', 18)
% plot(x',y','o');
% xlabel('latitude order');
% ylabel('variable');
% title('scatter diagram');

%% normalization-- zero-mean normalization
y_norm = (y - mean(y))./std(y);

%% generate test dataset and train dataset
% d) set train sets and the test sets
x_train = x(1:samp_inter:nSize);
y_train = y(1:samp_inter:nSize);
x_test = x(samp_inter:samp_inter:nSize);
y_test = y(samp_inter:samp_inter:nSize);
%later will be: y_predict¡ª¡ªthe predicted y values which is supposed coming from GPR


% e) plot the distribution of raw data y
figure(3)
set(gca, 'FontSize', 18)
norm1 = normplot(y);
title('Estimated by normplot function--raw data');
figure(4)
norm2 = normplot(y_norm);
title('Estimated by normplot function--normalized data');