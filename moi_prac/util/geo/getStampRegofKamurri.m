%% get region and stamp of phoenix,based on the data in file folder /reuse/typhoon
% 16 REGION
function [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofKamurri(stIndex)
stamp = 0;
minlon = 0;   maxlon = 0;   minlat = 0.0;   maxlat = 0.0;
if(stIndex <= 2 )
    stamp = 96 + stIndex;
    minlat = 15;    maxlat = 25;
    minlon = 25;     maxlon = 35;
elseif(stIndex > 2 & stIndex <= 5)
    stamp = 96 + stIndex;
    minlat = 15;    maxlat = 25;
    minlon = 23;     maxlon = 33;
elseif(stIndex == 6 )
    stamp = 96 + stIndex;
    minlat = 15;    maxlat = 25;
    minlon = 20;     maxlon = 30;
elseif(stIndex > 6 & stIndex <= 12)
    stamp = 96 + stIndex;
    minlat = 20;    maxlat = 30;
    minlon = 20;     maxlon = 30;
else
    stamp = 96 + stIndex;
    minlat = 25;    maxlat = 35;
    minlon = 20;     maxlon = 30;
end