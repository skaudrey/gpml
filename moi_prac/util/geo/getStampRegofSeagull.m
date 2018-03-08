%% get region and stamp of phoenix,based on the data in file folder /reuse/typhoon
% 8 REGION
function [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofSeagull(stIndex)
stamp = 0;
minlon = 0;   maxlon = 0;   minlat = 0.0;   maxlat = 0.0;
if(stIndex<=4 )
    stamp = 47 + stIndex;
    minlat = 10;    maxlat = 20;
    minlon = 5;     maxlon = 15;
elseif(stIndex > 4)
    stamp = 47 + stIndex;
    minlat = 10;    maxlat = 20;
    minlon = 0;     maxlon = 10;
end
