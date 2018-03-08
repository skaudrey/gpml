% preprocessing the data file: deal with the outlier and plot the
% scatter,return the data x and y

function [x,y,x_train,y_train,x_test,y_test] = spline_pre(filename,samp_inter,lon)

%global variables
resolution = 0.25;

% a) read data of target variable
y = load(filename)';
nSize_t = size(y);
nSize = nSize_t(1);

x = linspace(1,nSize,nSize)';
nSize = size(y,1);
% d) set train sets and the test sets
if(rem(lon/resolution,2) == 0)
    x_train = x(1:samp_inter:nSize);
    y_train = y(1:samp_inter:nSize);
    x_test = x(samp_inter:samp_inter:nSize);
    y_test = y(samp_inter:samp_inter:nSize);
else    
    x_train = x(samp_inter:samp_inter:nSize);
    y_train = y(samp_inter:samp_inter:nSize);
    x_test = x(1:samp_inter:nSize);
    y_test = y(1:samp_inter:nSize);
end
