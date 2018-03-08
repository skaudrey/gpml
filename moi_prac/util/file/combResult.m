%% define some global varaibles
% minlat = 30;
% minlon = 30;
% maxlat = 35.25;
% maxlon = 35.25;

minlon = 10;
maxlon = 11.75;
minlat = 10;
maxlat = 11.75;
resolution = 0.25;  % for EC data,the resolution is 0.75'

path = 'D:\Code\Matlab\gpml\moi_prac\inter_result\';

rs_u_lon = [];rs_u_lat = [];  
rs_v_lon = [];rs_v_lat = [];  
rs_su_lon = [];rs_su_lat = [];  
rs_sv_lon = [];rs_sv_lat = [];  
rt_u_lon = [];rt_v_lon = [];
rt_su_lon = [];rt_sv_lon = [];

s_u_lon = [];s_u_lat = [];  
s_v_lon = [];s_v_lat = [];  
s_su_lon = [];s_su_lat = [];  
s_sv_lon = [];s_sv_lat = [];  
t_u_lon = [];t_v_lon = [];
t_su_lon = [];t_sv_lon = [];


explain_rmse = 'from the 1st columns to the 19th columns are:[spline,mp,mult,multv,pca_sum,pca_prod,se,rq,period,mat,auto,pca_x,mpv,pca_mp,pcareg_Sum,pcareg_Prod,pcareg_auto,pcareg_x,pcareg_mp]';
explain = 'all are the matrix,from the 1st to the 20th are [origin,spline,mp,mult,multv,pca_sum,pca_prod,se,rq,period,mat,auto,pca_x,mpv,pca_mp,pcareg_Sum,pcareg_Prod,pcareg_auto,pcareg_x,pcareg_mp]';

% typeNorm = 1;   % no norm operation

mSize_0 = 1;
mSize = 18;
iSize = 1;  % EC25 dataset just consider space
typeS = 3;
nan = 9999; % for the auto method,the last point value is null,just give 9999;
specialM1 = 10;       % pcareg_auto
specialM2 = 16;
%% read data and combine to file

for typeI = 1:iSize
    for typeD = 1:2 %1 for longitude , 2 for latitude
        
        if(typeI == 1 & typeD == 1) %s-lon
            
            for typeM = mSize_0:mSize
                
                filename = strcat(path,regionName(typeS,typeI,typeM,typeD,minlon,maxlon),'.mat');
                load(filename);
                if(typeM == 1)
                    rs_u_lon = [rs_u_lon,rmse_sp(:,1)];
                    rs_v_lon = [rs_v_lon,rmse_sp(:,2)];
                    rs_su_lon = [rs_su_lon,rmse_sp(:,3)];
                    rs_sv_lon = [rs_sv_lon,rmse_sp(:,4)];
                    
                    rs_u_lon = [rs_u_lon,rmse_m(:,1)];
                    rs_v_lon = [rs_v_lon,rmse_m(:,2)];
                    rs_su_lon = [rs_su_lon,rmse_m(:,3)];
                    rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];

%                     s_u_lon(:,:,1) = u0;
%                     s_v_lon(:,:,1) = v0;
%                     s_su_lon(:,:,1) = s0;
%                     s_sv_lon(:,:,1) = d0;
% 
%                     s_u_lon(:,:,2) = u2;
%                     s_v_lon(:,:,2) = v2;
%                     s_su_lon(:,:,2) = s2;
%                     s_sv_lon(:,:,2) = d2;

%                 elseif(typeM == specialM1 | typeM == specialM2)    % auto method, y is the 1:end-1 dataset ,not the whole         
%                     
%                     sizeP = size(u0,1);
%                     
%                     u1 = [u1,[u1(:,end);nan]];
%                     
%                     v1 = [v1,[v1(:,end);nan]];s1 = [s1,[s1(:,end);nan]];d1 = [d1,[d1(:,end);nan]];
%                     
%                     rs_u_lon = [rs_u_lon,rmse_m(:,1)];
%                     rs_v_lon = [rs_v_lon,rmse_m(:,2)];
%                     rs_su_lon = [rs_su_lon,rmse_m(:,3)];
%                     rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];
%                     
%                     s_u_lon(:,:,typeM+1) = u1;
%                     s_v_lon(:,:,typeM+1) = v1;
%                     s_su_lon(:,:,typeM+1) = s1;
%                     s_sv_lon(:,:,typeM+1) = d1;
                else
                    rs_u_lon = [rs_u_lon,rmse_m(:,1)];
                    rs_v_lon = [rs_v_lon,rmse_m(:,2)];
                    rs_su_lon = [rs_su_lon,rmse_m(:,3)];
                    rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];
% 
%                     s_u_lon(:,:,typeM+1) = u1;
%                     s_v_lon(:,:,typeM+1) = v1;
%                     s_su_lon(:,:,typeM+1) = s1;
%                     s_sv_lon(:,:,typeM+1) = d1;
                end
                
            end
            
            % load the method mpng
             filename = strcat(path,regionName(typeS,typeI,23,typeD,minlon,maxlon),'.mat');
             load(filename);
             rs_u_lon = [rs_u_lon,rmse_m(:,1)];
             rs_v_lon = [rs_v_lon,rmse_m(:,2)];
             rs_su_lon = [rs_su_lon,rmse_m(:,3)];
             rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];
             
%              s_u_lon(:,:,typeM+1) = u1;
%              s_v_lon(:,:,typeM+1) = v1;
%              s_su_lon(:,:,typeM+1) = s1;
%              s_sv_lon(:,:,typeM+1) = d1;
        end
        
        
        if(typeI == 1 & typeD == 2) %s-lat
            
             for typeM = mSize_0:mSize
                
                filename = strcat(path,regionName(typeS,typeI,typeM,typeD,minlon,maxlon),'.mat');
                load(filename);
                if(typeM == 1)
                    rs_u_lat = [rs_u_lat,rmse_sp(:,1)];
                    rs_v_lat = [rs_v_lat,rmse_sp(:,2)];
                    rs_su_lat = [rs_su_lat,rmse_sp(:,3)];
                    rs_sv_lat = [rs_sv_lat,rmse_sp(:,4)];
                    
                    rs_u_lat = [rs_u_lat,rmse_m(:,1)];
                    rs_v_lat = [rs_v_lat,rmse_m(:,2)];
                    rs_su_lat = [rs_su_lat,rmse_m(:,3)];
                    rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];

%                    
%                     s_u_lat(:,:,1) = u0;
%                     s_v_lat(:,:,1) = v0;
%                     s_su_lat(:,:,1) = s0;
%                     s_sv_lat(:,:,1) = d0;
% 
%                     s_u_lat(:,:,2) = u2;
%                     s_v_lat(:,:,2) = v2;
%                     s_su_lat(:,:,2) = s2;
%                     s_sv_lat(:,:,2) = d2;

%                  elseif(typeM == specialM1 | typeM == specialM2)    % auto method, y is the 1:end-1 dataset ,not the whole         
%                     
%                     sizeP = size(u0,1);
%                     
%                     u1 = [u1;nan];v1 = [v1;nan];s1 = [s1;nan];d1 = [d1;nan];
%                     
%                     rs_u_lat = [rs_u_lat,rmse_m(:,1)];
%                     rs_v_lat = [rs_v_lat,rmse_m(:,2)];
%                     rs_su_lat = [rs_su_lat,rmse_m(:,3)];
%                     rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];
%                     
%                     s_u_lon(:,:,typeM+1) = u1;
%                     s_v_lon(:,:,typeM+1) = v1;
%                     s_su_lon(:,:,typeM+1) = s1;
%                     s_sv_lon(:,:,typeM+1) = d1;
                
                else
                    rs_u_lat = [rs_u_lat,rmse_m(:,1)];
                    rs_v_lat = [rs_v_lat,rmse_m(:,2)];
                    rs_su_lat = [rs_su_lat,rmse_m(:,3)];
                    rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];

%                     s_u_lat(:,:,typeM+1) = u1;
%                     s_v_lat(:,:,typeM+1) = v1;
%                     s_su_lat(:,:,typeM+1) = s1;
%                     s_sv_lat(:,:,typeM+1) = d1;
                end
                
             end
            
              % load the method mpng
             filename = strcat(path,regionName(typeS,typeI,23,typeD,minlon,maxlon),'.mat');
             load(filename);
             rs_u_lat = [rs_u_lat,rmse_m(:,1)];
             rs_v_lat = [rs_v_lat,rmse_m(:,2)];
             rs_su_lat = [rs_su_lat,rmse_m(:,3)];
             rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];
             
%              s_u_lat(:,:,typeM+1) = u1;
%              s_v_lat(:,:,typeM+1) = v1;
%              s_su_lat(:,:,typeM+1) = s1;
%              s_sv_lat(:,:,typeM+1) = d1;
        end
        
        
        if(typeI == 2 & typeD == 1) %t-lon
            for typeM = mSize_0:mSize
                
                filename = strcat(path,regionName(typeS,typeI,typeM,typeNorm,typeD,minlon,maxlon),'.mat');
                load(filename);
                if(typeM == 1)
                    rt_u_lon = [rt_u_lon,rmse_sp(:,1)];
                    rt_v_lon = [rt_v_lon,rmse_sp(:,2)];
                    rt_su_lon = [rt_su_lon,rmse_sp(:,3)];
                    rt_sv_lon = [rt_sv_lon,rmse_sp(:,4)];

                    rt_u_lon = [rt_u_lon,rmse_m(:,1)];
                    rt_v_lon = [rt_v_lon,rmse_m(:,2)];
                    rt_su_lon = [rt_su_lon,rmse_m(:,3)];
                    rt_sv_lon = [rt_sv_lon,rmse_m(:,4)];
                   
%                     t_u_lon(:,:,1) = u0;
%                     t_v_lon(:,:,1) = v0;
%                     t_su_lon(:,:,1) = s0;
%                     t_sv_lon(:,:,1) = d0;
% 
%                     t_u_lon(:,:,2) = u2;
%                     t_v_lon(:,:,2) = v2;
%                     t_su_lon(:,:,2) = s2;
%                     t_sv_lon(:,:,2) = d2;
%                     
%                  elseif(typeM == specialM1 | typeM == specialM2)
%                     
%                     sizeP = size(u0,1);
%                     
%                     u1 = [u1;nan];v1 = [v1;nan];s1 = [s1;nan];d1 = [d1;nan];
%                     
%                     rt_u_lon = [rt_u_lon,rmse_m(:,1)];
%                     rt_v_lon = [rt_v_lon,rmse_m(:,2)];
%                     rt_su_lon = [rt_su_lon,rmse_m(:,3)];
%                     rt_sv_lon = [rt_sv_lon,rmse_m(:,4)];
%                     
%                     t_u_lon(:,:,typeM+1) = u1;
%                     t_v_lon(:,:,typeM+1) = v1;
%                     t_su_lon(:,:,typeM+1) = s1;
%                     t_sv_lon(:,:,typeM+1) = d1;
                else
                   rt_u_lon = [rt_u_lon,rmse_m(:,1)];
                   rt_v_lon = [rt_v_lon,rmse_m(:,2)];
                   rt_su_lon = [rt_su_lon,rmse_m(:,3)];
                   rt_sv_lon = [rt_sv_lon,rmse_m(:,4)];


%                     t_u_lon(:,:,typeM+1) = u1;
%                     t_v_lon(:,:,typeM+1) = v1;
%                     t_su_lon(:,:,typeM+1) = s1;
%                     t_sv_lon(:,:,typeM+1) = d1;
                end
                
            end
             % load the method mpng
             filename = strcat(path,regionName(typeS,typeI,23,typeD,minlon,maxlon),'.mat');
             load(filename);
             rt_u_lon = [rt_u_lon,rmse_m(:,1)];
             rt_v_lon = [rt_v_lon,rmse_m(:,2)];
             rt_su_lon = [rt_su_lon,rmse_m(:,3)];
             rt_sv_lon = [rt_sv_lon,rmse_m(:,4)];
             
%              t_u_lon(:,:,typeM+1) = u1;
%              t_v_lon(:,:,typeM+1) = v1;
%              t_su_lon(:,:,typeM+1) = s1;
%              t_sv_lon(:,:,typeM+1) = d1;
        end
    end
end


%% save file
save([path,'EC25_s_lon.mat'], 'rs_u_lon','s_u_lon','rs_v_lon','s_v_lon','rs_su_lon','s_su_lon','rs_sv_lon','s_sv_lon','explain_rmse','explain');

save([path,'EC25_s_lat.mat'], 'rs_u_lat','s_u_lat','rs_v_lat','s_v_lat','rs_su_lat','s_su_lat','rs_sv_lat','s_sv_lat','explain_rmse','explain');

save([path,'EC25_t_lon.mat'], 'rt_u_lon','t_u_lon','rt_v_lon','t_v_lon','rt_su_lon','t_su_lon','rt_sv_lon','t_sv_lon','explain_rmse','explain');

