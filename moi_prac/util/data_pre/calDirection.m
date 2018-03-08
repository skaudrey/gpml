% calculate wind direction
% WIERD : The direction I got is bigger than 360 degree,some,why ??

function direc = calDirection(u,v)
[mSize,nSize] = size(u);

direc = zeros(mSize,nSize);

for m = 1: mSize
    for n = 1:nSize
        speed_t=sqrt(u(m,n)^2+ v(m,n)^2);    
        direc(m,n)=asin(u(m,n)/speed_t)/pi*180;

        if(u(m,n)>0 && v(m,n)<=0)
            direc(m,n)=180-direc(m,n);
        end
        if(u(m,n)<=0 && v(m,n)<0)
            direc(m,n)=180-direc(m,n);
        end
        if(u(m,n)<=0 && v(m,n)>=0)
            direc(m,n)=360+direc(m,n);
        end
    
    end
end  
