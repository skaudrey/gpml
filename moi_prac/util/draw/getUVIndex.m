% @methodIndex : for 1-7 means
% mat,mpng,matpcasum,matpcaprod,mpngPcaProd,mpngPcaSum,spline

% @epoch : epochIndex is limited in size([20,50,80,100],2)

function index = getUVIndex(epoch,methodIndex)
index = (epoch-1)*12+methodIndex + 1;