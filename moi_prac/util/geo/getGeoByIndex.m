function geo = getGeoByIndex(index,typeG,resolution)
startLon = 120; %120'E
startLat = 0;   %0'N
if(typeG==1)    %lat
    geo = (index-1)*resolution + startLat;
elseif(typeG==2)    %longitude
    geo = (index-1)*resolution + startLon;
end