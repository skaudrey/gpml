% save mat to xls
% varname
sst = 'sst';    %sea surface temperature
msl = 'msl';   %mean sea level pressure
uwind = 'u10'; % u wind component
vwind = 'v10'; % v wind component
pca = 'pca';

pressure_filename ='20140901-20140930-sst-mslp-swh.nc';
uv_filename = '20140901-20140930-uv.nc';

resolution = 0.125;

% path of origin nc file
basepath = 'D:\Code\Matlab\gpml\moi_prac\origin';


prefix = 'ECreg_';

excelType = 1;
matType =2;

for i =1:16

[minlon,maxlon,minlat,maxlat,stamp] = getStampRegofFengGod(i);   
saveMat = [];

[x_mat sst_mat] = getRegion(basepath,pressure_filename,sst,minlon,maxlon,minlat,maxlat,resolution,stamp);
[x_mat mslp_mat] = getRegion(basepath,pressure_filename,msl,minlon,maxlon,minlat,maxlat,resolution,stamp);

[x_mat u] = getRegion(basepath,uv_filename,uwind,minlon,maxlon,minlat,maxlat,resolution,stamp);
[x_mat v] = getRegion(basepath,uv_filename,vwind,minlon,maxlon,minlat,maxlat,resolution,stamp);

d_mat = calDirection(u,v);
s_mat = calSpeed(u,v);
u_mat_s = [x_mat sst_mat mslp_mat d_mat u v];

saveMat = [saveMat;u_mat_s];

filename = outRegName(prefix,pca,minlon,minlat,maxlon,maxlat,excelType,stamp);
outpath = 'D:\Code\Matlab\gpml\moi_prac\DL\fenggod\';

outfile = strcat(outpath,filename);

xlswrite(outfile,saveMat);    
end


