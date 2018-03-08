% @dayIndex = [1-30] for the dataset of '20140901-20140930-uv.nc'
% @hIndex = [1-4] for time 00:00:00;06:00:00;12:00:00;18:00:00

function stamp = getTimeStamp(dayIndex,hIndex)
stamp = (dayIndex - 1) * 4 + hIndex;