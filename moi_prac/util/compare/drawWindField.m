% function for draw wind field

function drawWindField(u,v)

[ySize,xSize] = size(u);

[x,y] = meshgrid(1:xSize,1:ySize);

quiver(x,y,u,v)
