% calculate u and v from direction and scalar speed

function [u v] = CalUVFromSpeed(speed,direc)

[mSize,nSize] = size(speed);

u = zeros(mSize,nSize);
v = zeros(mSize,nSize);

for m = 1:mSize
    for n = 1:nSize
        u(m,n) = speed(m,n) * sin(direc(m,n)/180*pi);
        v(m,n) = speed(m,n) * cos(direc(m,n)/180*pi);
    end
end
    
 