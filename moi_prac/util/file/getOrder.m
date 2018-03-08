% get the order of distance and time,cause the ts data are sampled as the
% first day per month of each place. Thus,for one place,there are
% nYear*nDay size data.

% @nYear : for one place,there are nYear size data
% @nDayPerYear : for one place per year,there are nDayPerYear size data
% @x_d: the distance order
% @x_t: the time order
% @x : the raw order data including the time and distance information

function [x_d,x_t] = getOrder(x,y,nYear,nDayPerYear)

sizePerYear = nYear * nDayPerYear;

x_d = floor(x/sizePerYear);
x_t = rem(x,sizePerYear);

