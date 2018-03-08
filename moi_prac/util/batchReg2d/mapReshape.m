%% subfunction: reshape the subregion to grid map
function reshaped = mapReshape(rawy,size_lat,size_lon,row_size,col_size,samp)
reshaped = [];
row_reg = size_lat/row_size;    col_reg = size_lon/col_size; 

for i = 0:row_size-1
    temp = [];
    
    for j = 1:col_size    
        index = i*col_size+j;
        
        tempy = rawy{index};
        tempy = reshape(tempy,[row_reg col_reg]);
%         tempy = reshape();
        temp = [temp,tempy];
    end    
    reshaped = [reshaped;temp];
end
