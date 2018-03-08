% calculate rmse
function rmse = getRMSE(trueMat,compMat)    % the mat is a columns vector
nSize_test = size(trueMat,1);
rmse = sqrt((sum(compMat - trueMat).^2)/nSize_test);
