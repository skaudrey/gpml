%% combine ECred and the space,combine the spline,and five method of 2d
% just one dimension based on distance,the whole region,
% although spline was done one latitude by latitude and one longitude by one longitude

%% some global variables

clear all;close all;clc;

minlon = 10;
maxlon = 11.75;
minlat = 10;
maxlat = 11.75;
resolution = 0.25;  % for EC data,the resolution is 0.75'

path = 'D:\Code\Matlab\gpml\moi_prac\reg_inter_odd\';

rs_u_lon = [];rs_u_lat = [];  
rs_v_lon = [];rs_v_lat = [];  
rs_su_lon = [];rs_su_lat = [];  
rs_sv_lon = [];rs_sv_lat = [];  


s_u_lon = {};s_u_lat = {};  
s_v_lon = {};s_v_lat = {};  
s_su_lon = {};s_su_lat = {};  
s_sv_lon = {};s_sv_lat = {};  


% typeM of regionName: 9 for mat,19 for mpng,20 for pcareg_m_sum,21 for
% pcareg_m_prod,22 for pcareg_mpng_prod,23 for pcareg_mpng_sum,

explain_rmse = 'from the 1st columns to the 7th columns are:[1d spline-mean of region,2d mat,2d mpng,2d pcareg_m_sum,2d pcareg_m_prod,2d pcareg_mpng_prod,,2d pcareg_mpng_sum]';
explain = 'all are the matrix,from the 1st to the 8th are [origin,spline,2d mat,2d mpng,2d pcareg_m_sum,2d pcareg_m_prod,2d pcareg_mpng_prod,,2d pcareg_mpng_sum]';

iSize = 1;  % EC25 dataset just consider space



%% spline firstly
typeS = 3;
for typeI = 1:iSize
    for typeD = 1:2 %1 for longitude , 2 for latitude
        
        if(typeI == 1 & typeD == 1) %s-lon
            
            for typeM = 24:24
                
                filename = strcat(path,regionName(typeS,typeI,typeM,typeD,minlon,maxlon),'.mat');
                load(filename);
               % spline
                rs_u_lon = [rs_u_lon,mean(rmse_sp(:,1))];
                rs_v_lon = [rs_v_lon,mean(rmse_sp(:,2))];                
                rs_su_lon = [rs_su_lon,mean(rmse_sp(:,3))];
                rs_sv_lon = [rs_sv_lon,mean(rmse_sp(:,4))];
%                 
%                 rs_u_lon = [rs_u_lon,mean(rmse_m(:,1))];
%                 rs_v_lon = [rs_v_lon,mean(rmse_m(:,2))];
%                 rs_su_lon = [rs_su_lon,mean(rmse_m(:,3))];
%                 rs_sv_lon = [rs_sv_lon,mean(rmse_m(:,4))];
                
                %origin
                s_u_lon{1} = u0;
                s_v_lon{1} = v0;
                s_su_lon{1} = s0;
                s_sv_lon{1} = d0;
                % spline
                s_u_lon{2} = u2;
                s_v_lon{2} = v2;
                s_su_lon{2} = s2;
                s_sv_lon{2} = d2;               
            end          
     
        end       
        
        if(typeI == 1 & typeD == 2) %s-lat
            
             for typeM = 24:24
                
                filename = strcat(path,regionName(typeS,typeI,typeM,typeD,minlon,maxlon),'.mat');
                load(filename);
                
                rs_u_lat = [rs_u_lat,mean(rmse_sp(:,1))];
                rs_v_lat = [rs_v_lat,mean(rmse_sp(:,2))];
                rs_su_lat = [rs_su_lat,mean(rmse_sp(:,3))];
                rs_sv_lat = [rs_sv_lat,mean(rmse_sp(:,4))];
                
%                 rs_u_lat = [rs_u_lat,mean(rmse_m(:,1))];
%                 rs_v_lat = [rs_v_lat,mean(rmse_m(:,2))];
%                 rs_su_lat = [rs_su_lat,mean(rmse_m(:,3))];
%                 rs_sv_lat = [rs_sv_lat,mean(rmse_m(:,4))];
                
                s_u_lat{1} = u0;
                s_v_lat{1} = v0;
                s_su_lat{1} = s0;
                s_sv_lat{1} = d0;
                
                s_u_lat{2} = u2;
                s_v_lat{2} = v2;
                s_su_lat{2} = s2;
                s_sv_lat{2} = d2;             
                
             end           
             
        end   
               
    end
end

%% 2d method
typeS = 4;

% origin firstly,cause the origin in reg is different from the spline
% method



% 1) matern firstly
for typeI = 1:iSize
    for typeD = 1:2 %1 for longitude , 2 for latitude
        
        if(typeI == 1 & typeD == 1) %s-lon
            
            for typeM = 9:9
                
                filename = strcat(path,regionName(typeS,typeI,typeM,typeD,minlon,maxlon),'.mat');
                load(filename);
                % matern
                rs_u_lon = [rs_u_lon,rmse_m(:,1)];
                rs_v_lon = [rs_v_lon,rmse_m(:,2)];
                rs_su_lon = [rs_su_lon,rmse_m(:,3)];
                rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];
                
               
                % matern
                s_u_lon{3} = u1;
                s_v_lon{3} = v1;
                s_su_lon{3} = s1;
                s_sv_lon{3} = d1;               
            end          
     
        end       
        
        if(typeI == 1 & typeD == 2) %s-lat
            
             for typeM = 9:9
                
                filename = strcat(path,regionName(typeS,typeI,typeM,typeD,minlon,maxlon),'.mat');
                load(filename);
               
                rs_u_lat = [rs_u_lat,rmse_m(:,1)];
                rs_v_lat = [rs_v_lat,rmse_m(:,2)];
                rs_su_lat = [rs_su_lat,rmse_m(:,3)];
                rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];
                               
                s_u_lat{3} = u1;
                s_v_lat{3} = v1;
                s_su_lat{3} = s1;
                s_sv_lat{3} = d1;             
                
             end           
             
        end   
               
    end
end


% 2) others

for typeI = 1:iSize
    for typeD = 1:2 %1 for longitude , 2 for latitude
        
        if(typeI == 1 & typeD == 1) %s-lon
            index = 4;
            for typeM = 19:23
                
                filename = strcat(path,regionName(typeS,typeI,typeM,typeD,minlon,maxlon),'.mat');
                load(filename);
                % matern
                rs_u_lon = [rs_u_lon,rmse_m(:,1)];
                rs_v_lon = [rs_v_lon,rmse_m(:,2)];
                rs_su_lon = [rs_su_lon,rmse_m(:,3)];
                rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];
                
               
                % matern
                s_u_lon{index} = u1;
                s_v_lon{index} = v1;
                s_su_lon{index} = s1;
                s_sv_lon{index} = d1;    
                
                index = index + 1;
            end          
     
        end       
        
        if(typeI == 1 & typeD == 2) %s-lat
            index = 4;
             for typeM = 19:23
                
                filename = strcat(path,regionName(typeS,typeI,typeM,typeD,minlon,maxlon),'.mat');
                load(filename);
               
                rs_u_lat = [rs_u_lat,rmse_m(:,1)];
                rs_v_lat = [rs_v_lat,rmse_m(:,2)];
                rs_su_lat = [rs_su_lat,rmse_m(:,3)];
                rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];
                               
                s_u_lat{index} = u1;
                s_v_lat{index} = v1;
                s_su_lat{index} = s1;
                s_sv_lat{index} = d1;             
                
                index = index + 1;
             end           
             
        end   
               
    end
end

%% save file
save([path,'reg_s_lon.mat'], 'rs_u_lon','s_u_lon','rs_v_lon','s_v_lon','rs_su_lon','s_su_lon','rs_sv_lon','s_sv_lon','explain_rmse','explain');

save([path,'reg_s_lat.mat'], 'rs_u_lat','s_u_lat','rs_v_lat','s_v_lat','rs_su_lat','s_su_lat','rs_sv_lat','s_sv_lat','explain_rmse','explain');


