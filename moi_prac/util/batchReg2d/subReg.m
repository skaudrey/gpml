% test
% size_lat = 162;
% size_lon = 122;
% row_size = 9;col_size =2;
function [subreg_x,subreg_y] = subReg(x,y,size_lat,size_lon,row_size,col_size)
row_reg = size_lat/row_size;
col_reg = size_lon/col_size;

x_temp = [];y_temp = [];
subreg_x = {};subreg_y = {};

for row = 0:row_size-1
    for col = 0:col_size-1
        start = col*col_reg;
        x_temp = [];y_temp= [];
        for lon = start:start+col_reg-1
            i1 = lon*size_lat+1+row_reg*row;
            i2 = i1+row_reg-1;
            x_temp = [x_temp;x(i1:i2,:)];
            y_temp = [y_temp;y(i1:i2,:)];
        end
    index = row*col_size+col+1;
    subreg_x{index} = x_temp;
    subreg_y{index} = y_temp;
    end
end



