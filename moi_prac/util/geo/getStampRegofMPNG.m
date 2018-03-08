%% get region and stamp for region
% dataType: indicate time or space; dataType = 1 with stamp change;2 for
% stamp  =10
% dataType = 2 with region change
function [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofMPNG(stIndex,dataType,batchIndex)
stamp = 0;
minlon = 0;   maxlon = 0;   minlat = 0.0;   maxlat = 0.0;

switch dataType
    case 1  %1-30   %region all, stamp 4-15; region 120'E-180'E, 2' longitude per subregion. feature smds
%         minlon = 0;maxlon = 2;
%         minlat = 0;maxlat = 60;
%         stamp = stIndex+1;
        minlon = (stIndex-1)*2;
        maxlon = stIndex*2;
        minlat = 0;maxlat = 60;
        stamp =  batchIndex;
%     case 2  %1-30   %region all, stamp 4-15; region 120'E-180'E, 2' longitude per subregion, feature smd
% %         minlon = (stIndex-1)*1.5;
% %         maxlon = stIndex*1.5;
% %         minlat = 0;maxlat = 60;
% %         stamp = 10;
%         minlon = (stIndex-1)*2;
%         maxlon = stIndex*2;
%         minlat = 0;maxlat = 60;
%         stamp =  3 + batchIndex;
         
    case 2  %1-40   time all, stamp 2-81; region 0-10'E, 2' longitude per subregion, feature smds
        minlon = (batchIndex-1) * 2;
        maxlon = batchIndex * 2;
        minlat = 0; maxlat = 60;
        stamp = stIndex;
%     case 4  %1-40   time all, stamp 2-81; region 0-10'E ,2' longitude per subregion, feature smd
%         minlon = (batchIndex-1) * 2;
%         maxlon = batchIndex * 2;
%         minlat = 0; maxlat = 60;
%         stamp = stIndex+1;
end