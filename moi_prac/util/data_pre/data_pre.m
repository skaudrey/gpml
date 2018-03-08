% preprocessing the data file: deal with the outlier and plot the
% scatter,return the data x and y

function [x,y,x_train,y_train,x_test,y_test] = data_pre(filename,samp_inter)
thresh = -9998;
% a) read data of target variable
y = load(filename)';
nSize_t = size(y);
nSize = nSize_t(1);

% b) plot the scatter diagram and delete the outlier
% =====£¿£¿£¿£¿£¿Problem:is it right I just delete the outlier£¿£¿£¿£¿£¿=====
% =====2017.9.30 The outlier is just the data that is not existed which is placed by -9999,I just change the 
% order for x which means change the space distance based on it.=====
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

% d) set train sets and the test sets
x_train = x(1:samp_inter:nSize);
y_train = y(1:samp_inter:nSize);
x_test = x(samp_inter:samp_inter:nSize);
y_test = y(samp_inter:samp_inter:nSize);
%later will be: y_predict¡ª¡ªthe predicted y values which is supposed coming from GPR

% e) plot the distribution of raw data y
% figure(3)
% set(gca, 'FontSize', 18)
% normplot(y);
% title('Estimated by normplot function');