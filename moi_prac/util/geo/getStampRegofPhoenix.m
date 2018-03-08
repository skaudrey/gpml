%% get region and stamp of phoenix,based on the data in file folder /reuse/typhoon

function [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofPhoenix(stIndex)
stamp = 0;
minlon = 0;   maxlon = 10;   minlat = 0.0;   maxlat = 0.0;
if(stIndex>=1 & stIndex <=4)
    stamp = 69 + stIndex;
    minlat = 10;    maxlat = 20;
elseif(stIndex>4 & stIndex <= 9)
    stamp = 76 + stIndex;
    minlat = 20;    maxlat = 30;
else
    stamp = 76 + stIndex;
    minlat = 25;    maxlat = 35;
end