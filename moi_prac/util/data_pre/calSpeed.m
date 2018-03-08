% calcluate speed

function speed = calSpeed(u,v)

[mSize,nSize] = size(u);

speed = zeros(mSize,nSize);

for m = 1: mSize
    for n = 1:nSize
        speed(m,n)=sqrt(u(m,n)^2+ v(m,n)^2);
    end
end