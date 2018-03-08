% choose the self data,one order difference as the train data
function [sx,sy,sx_train,sy_train,sx_test,sy_test] = data_auto(x,y,x_train,y_train,x_test,y_test)

sx = x(2:end);
sy = y(2:end);
sx_train = x_train(2:end);
sy_train = y_train(2:end);
sx_test = x_test(2:end);
sy_test = y_test(2:end);
