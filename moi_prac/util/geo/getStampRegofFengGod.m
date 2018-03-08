%% get region and stamp of phoenix,based on the data in file folder /reuse/typhoon
% 16 REGION
function [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofFengGod(stIndex)
stamp = 0;
minlon = 0;   maxlon = 10;   minlat = 0.0;   maxlat = 0.0;
if(stIndex==1 )
    stamp = 25;
    minlat = 20;    maxlat = 30;
    minlon = 0;     maxlon = 10;
elseif(stIndex>1 & stIndex <= 4)
    stamp = 24 + stIndex;
    minlat = 20;    maxlat = 30;
    minlon = 5;     maxlon = 15;
elseif(stIndex == 5)
    stamp = 29;
    minlat = 20;    maxlat = 30;
    minlon = 10;     maxlon = 20;
elseif(stIndex > 5 & stIndex <= 9)
    stamp = stIndex + 24;
    minlat = 25;    maxlat = 35;
    minlon = 15;     maxlon = 25;
elseif(stIndex > 9 & stIndex <= 11)
    stamp = stIndex + 24;
    minlat = 30;    maxlat = 40;
    minlon = 20;     maxlon = 30;
elseif(stIndex > 11 & stIndex <= 13)
    stamp = stIndex + 24;
    minlat = 30;    maxlat = 40;
    minlon = 25;     maxlon = 35;
elseif(stIndex > 13 & stIndex <= 15)
    stamp = stIndex + 24;
    minlat = 30;    maxlat = 40;
    minlon = 30;     maxlon = 40;
elseif(stIndex > 15)
    stamp = stIndex + 24;
    minlat = 35;    maxlat = 45;
    minlon = 35;     maxlon = 45;
end
end