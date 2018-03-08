%% 2d region and make it to xls,then get principle component

function regMV2xls()

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



%% pick multi variable for normal day
minlat = 0;
maxlat = 60;
% maxlon = 10;
% minlon = 8;
for i = 1:5
    minlon = (i-1)*2;
    maxlon = i*2;
    
    outpath = 'D:\Code\Matlab\gpml\moi_prac\reuse\normalday\mpng\time\reg';    
    for pick_time = 2:81  
        outpath = 'D:\Code\Matlab\gpml\moi_prac\reuse\normalday\mpng\time\reg';  
        outpath = [outpath, num2str(i),'\smd\'];
        stamp= pick_time;
        [x_mat sst_mat] = getRegion(basepath,pressure_filename,sst,minlon,maxlon,minlat,maxlat,resolution,pick_time);
        [x_mat mslp_mat] = getRegion(basepath,pressure_filename,msl,minlon,maxlon,minlat,maxlat,resolution,pick_time);

        [x_mat u] = getRegion(basepath,uv_filename,uwind,minlon,maxlon,minlat,maxlat,resolution,pick_time);
        [x_mat v] = getRegion(basepath,uv_filename,vwind,minlon,maxlon,minlat,maxlat,resolution,pick_time);

        d_mat = calDirection(u,v);
        s_mat = calSpeed(u,v);

        u_mat_s = [sst_mat mslp_mat d_mat s_mat];

        filename = outRegName(prefix,pca,minlon,minlat,maxlon,maxlat,excelType,stamp);

        outfile = strcat(outpath,filename);

        xlswrite(outfile,u_mat_s);    

%         matName = outRegName(prefix,pca,minlon,minlat,maxlon,maxlat,matType,stamp);
% 
%         save([outpath matName],'x_mat','sst_mat','mslp_mat','u','v','d_mat','s_mat');
    
    end
end
%% pick multi variable for typhoon day
% minlon=0;maxlon=0;minlat=0;maxlat=0;pick_time=0;
% for j = 1:4
%     reg_size = 0; subpath = '';
%     switch(j)
%         case 1 
%             reg_size = 26;
%             subpath = 'phoenix';
%         case 2
%             reg_size = 16;
%             subpath = 'kamurri';
%         case 3
%             reg_size = 16;
%             subpath = 'fenggod';
%         case 4
%             reg_size = 8;
%             subpath = 'seagull';
%     end  
%     
%     for i =1:reg_size
%         
%         switch(j)
%             case 1       
%                 [minlon,maxlon,minlat,maxlat,pick_time] = getStampRegofPhoenixAll(i);  
%             case 2         
%                 [minlon,maxlon,minlat,maxlat,pick_time] = getStampRegofKamurri(i);  
%             case 3
%                 [minlon,maxlon,minlat,maxlat,pick_time] = getStampRegofFengGod(i);  
%             case 4
%                 [minlon,maxlon,minlat,maxlat,pick_time] = getStampRegofSeagull(i);  
%         end  
%         
%          
%         stamp = pick_time;
%         [x_mat sst_mat] = getRegion(basepath,pressure_filename,sst,minlon,maxlon,minlat,maxlat,resolution,pick_time);
%         [x_mat mslp_mat] = getRegion(basepath,pressure_filename,msl,minlon,maxlon,minlat,maxlat,resolution,pick_time);
% 
%         [x_mat u] = getRegion(basepath,uv_filename,uwind,minlon,maxlon,minlat,maxlat,resolution,pick_time);
%         [x_mat v] = getRegion(basepath,uv_filename,vwind,minlon,maxlon,minlat,maxlat,resolution,pick_time);
% 
%         d_mat = calDirection(u,v);
%         s_mat = calSpeed(u,v);
% 
%         u_mat_s = [sst_mat mslp_mat d_mat];
% 
%         filename = outRegName(prefix,pca,minlon,minlat,maxlon,maxlat,excelType,stamp);
%         outpath = ['D:\Code\Matlab\gpml\moi_prac\reuse\typhoon\' subpath '\smd\'];
% 
%         outfile = strcat(outpath,filename);
% 
%         xlswrite(outfile,u_mat_s);    
%     
% %     matName = outRegName(prefix,pca,minlon,minlat,maxlon,maxlat,matType,stamp);
% %     
% %     save([outpath matName],'x_mat','sst_mat','mslp_mat','u','v','d_mat','s_mat');
%     end
% end
