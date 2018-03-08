function [u0,u1,v0,v1,s0,s1,d0,d1,lat,lon,consum,inter] = reuseInter(typeS,typeI,typeD,typeM,path,minlon,minlat,maxlon,maxlat,epoch,samp,stamp,hypu,hypv)
%% global variables
typeV_pca = 7;  % pca feature
u0 = [];   u1 = [];   consum1 = 0.0;    inter1 = 0.0;  
v0 = [];   v1 = [];   consum2 = 0.0;    inter2 = 0.0;  
s0 = [];   s1 = [];   consum3 = 0.0;    inter3 = 0.0;   
d0 = [];   d1 = [];   consum4 = 0.0;    inter4 = 0.0;   
lat = []; lon = [];

typeV = [1 2 6 3];  %u10,v10,s,d;aka typeV =1,2,6,3

%% make interpolation for u10,v10,s,d;aka typeV =1,2,6,3

prefix_s = [path getPrefixByType(typeS,typeI,0,typeD)]; % others bariable type,both ok

switch(typeM)
    case 1 %pcareg_m_prod
        [u0 u1 x_lat x_lon consum1 inter1 ] = reuse_mult_pca_prod(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),samp,stamp,hypu);
        [v0 v1 x_lat x_lon consum2 inter2] = reuse_mult_pca_prod(prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),samp,stamp,hypv);
%         [s0 s1 consum3 inter3] = reg_mat_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = reg_mat_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        disp('------------- mat pca prod done ----------------');
    case 2 %spline
        [u0 u1 x_lat x_lon consum1 inter1 ] = timesplineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),samp,stamp);
        [v0 v1 x_lat x_lon consum1 inter2 ] = timesplineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),samp,stamp);
%         [s0 s1 consum3 inter3] = splineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),samp);
%         [d0 d1 consum4 inter4] = splineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),samp);
        disp('------------- spline done ----------------');    
end

consum = [consum1,consum2,consum3,consum4]';
inter = [inter1,inter2,inter3,inter4]';
lat = x_lat;
lon = x_lon;