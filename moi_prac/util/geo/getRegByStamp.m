function [minlon,maxlon,minlat,maxlat] = getRegByStamp(stamp)
minlon = 0;maxlon = 4;
minlat = 0.0;maxlat = 0.0;
switch(stamp)
    case 83
        minlat = 20;
        maxlat = 25;
    case 84
        minlat = 21;
        maxlat = 25;
    case 85
        minlat = 23;
        maxlat = 27;    
end