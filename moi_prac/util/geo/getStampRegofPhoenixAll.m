%% get region and stamp of phoenix,based on the data in file folder /reuse/typhoon
% 26 REGION
function [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofPhoenixAll(stIndex)
stamp = 0;
minlon = 0;   maxlon = 10;   minlat = 0.0;   maxlat = 0.0;
if(stIndex>=1 & stIndex <=4)
    stamp = 69 + stIndex;
    minlat = 10;    maxlat = 20;
elseif(stIndex>4 & stIndex <= 11)
    stamp = 69 + stIndex;
    minlat = 15;    maxlat = 25;
elseif(stIndex>11 & stIndex <= 16)
    stamp = 69 + stIndex;
    minlat = 20;    maxlat = 30;
elseif(stIndex>16 & stIndex <= 23)
    stamp = 69 + stIndex;
    minlat = 25;    maxlat = 35;
else
    stamp = 69 + stIndex;
    minlat = 30;    maxlat = 40;
end