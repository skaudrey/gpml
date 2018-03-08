function index = getIndexByGeo(geo,typeG,resolution)
startLon = 120; %120'E
startLat = 0;   %0'N
if(typeG==1)    %lat
    index = (geo-startLat)/resolution + 1;
elseif(typeG==2)    %longitude
    index = (geo-startLon)/resolution +1;
end