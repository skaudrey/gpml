function [x,y,x_train,y_train,x_test,y_test] = filedata_pre(filename,samp_inter)

y = load(filename)';
nSize = size(y,1);
x = linspace(1,nSize,nSize)';
nSize = size(y,1);

% d) set train sets and the test sets
x_train = x(1:samp_inter:nSize);
y_train = y(1:samp_inter:nSize);
x_test = x(samp_inter:samp_inter:nSize);
y_test = y(samp_inter:samp_inter:nSize);
