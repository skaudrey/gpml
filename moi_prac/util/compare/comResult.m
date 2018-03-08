% compare result, rmse
%% global variables
path = 'D:\Code\Matlab\gpml\moi_prac\inter_result\';

s_mp_lat_file = 's_mp_LAT30-35.25.mat';
s_mp_lon_file = 's_mp_LON30-35.25.mat';
% s_mp_norm_lat_file = 's_mp_normLAT30-35.25.mat';
% s_mp_norm_lon_file = 's_mp_normLON30-35.25.mat';
s_mult_lat_file = 's_mult_LAT30-35.25.mat';
s_mult_lon_file = 's_mult_LON30-35.25.mat';
% s_mult_norm_lat_file = 's_mult_normLAT30-35.25.mat';
% s_mult_norm_lon_file ='s_mult_normLON30-35.25.mat';
s_multv_lat_file = 's_multV_LAT30-35.25.mat';
s_multv_lon_file = 's_multV_LON30-35.25.mat';
% s_multv_norm_lat_file = 's_multV_norm_LAT30-35.25.mat';
s_pca_prod_lat_file = 's_pca_Prod_LAT30-35.25.mat';
s_pca_prod_lon_file = 's_pca_Prod_LON30-35.25.mat';
s_pca_sum_lat_file = 's_pca_Sum_LAT30-35.25.mat';
s_pca_sum_lon_file = 's_pca_Sum_LON30-35.25.mat';
s_rq_lon_file = '';
s_rq_lat_file = '';
s_se_lon_file = '';
s_se_lat_file = '';
s_period_lon_file = '';
s_period_lat_file = '';
s_mat_lon_file = '';
s_mat_lat_file = '';

t_mp_lon_file = 't_mp_LON30-35.25.mat';
% t_mp_norm_lon_file = 't_mp_normLON30-35.25.mat';
t_mult_lon_file = 't_mult_LON30-35.25.mat';
% t_mult_norm_lon_file = 't_mult_normLON30-35.25.mat';
% t_multv_norm_lon = 't_multV_norm_LON30-35.25.mat';
t_multv_lon_file = 't_multV_LON30-35.25.mat';
t_pca_prod_lon = 't_pca_Prod_LON30-35.25.mat';
t_pca_sum_lon = 't_pca_Sum_LON30-35.25.mat';
t_rq_lon_file = '';
t_se_lon_file = '';
t_period_lon_file = '';
t_mat_lon_file = '';


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


explain_rmse = 'from the 1st columns to the end columns are:[spline,spline_norm,mp,mp_norm,mult,mult_norm,multv,pca_prod,pca_sum]';
explain = 'all are the matrix,from the 1st to the end are [origin,spline,spline_norm,mp,mp_norm,mult,mult_norm,multv,pca_prod,pca_sum]';


% for rmse: from the 1st columns to the end columns are spline,spline_norm,mp,mp_norm,mult,mult_norm,multv,pca_prod,pca_sum
% for u,v,s,d: all are the matrix,from the origin,spline, mp,mp norm,
%% read s lon
% sp
load(s_mp_lon_file);
rs_u_lon = [rs_u_lon,rmse_sp(:,1)];
rs_v_lon = [rs_v_lon,rmse_sp(:,2)];
rs_su_lon = [rs_su_lon,rmse_sp(:,3)];
rs_sv_lon = [rs_sv_lon,rmse_sp(:,4)];

s_u_lon(:,:,1) = u0;
s_v_lon(:,:,1) = v0;
s_su_lon(:,:,1) = s0;
s_sv_lon(:,:,1) = d0;

s_u_lon(:,:,2) = u1;
s_v_lon(:,:,2) = v1;
s_su_lon(:,:,2) = s1;
s_sv_lon(:,:,2) = d1;

% % spline norm
% load(s_mp_norm_lon_file);
% rs_u_lon = [rs_u_lon,rmse_sp(:,1)];
% rs_v_lon = [rs_v_lon,rmse_sp(:,2)];
% rs_su_lon = [rs_su_lon,rmse_sp(:,3)];
% rs_sv_lon = [rs_sv_lon,rmse_sp(:,4)];
% 
% s_u_lon(:,:,3) = u2;
% s_v_lon(:,:,3) = v2;
% s_su_lon(:,:,3) = s2;
% s_sv_lon(:,:,3) = d2;
% mp
load(s_mp_lon_file);
rs_u_lon = [rs_u_lon,rmse_m(:,1)];
rs_v_lon = [rs_v_lon,rmse_m(:,2)];
rs_su_lon = [rs_su_lon,rmse_m(:,3)];
rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];

s_u_lon(:,:,3) = u2;
s_v_lon(:,:,3) = v2;
s_su_lon(:,:,3) = s2;
s_sv_lon(:,:,3) = d2;
% % mp norm
% load(s_mp_norm_lon_file);
% rs_u_lon = [rs_u_lon,rmse_m(:,1)];
% rs_v_lon = [rs_v_lon,rmse_m(:,2)];
% rs_su_lon = [rs_su_lon,rmse_m(:,3)];
% rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];
% 
% s_u_lon(:,:,5) = u2;
% s_v_lon(:,:,5) = v2;
% s_su_lon(:,:,5) = s2;
% s_sv_lon(:,:,5) = d2;
% mult
load(s_mult_lon_file);
rs_u_lon = [rs_u_lon,rmse_m(:,1)];
rs_v_lon = [rs_v_lon,rmse_m(:,2)];
rs_su_lon = [rs_su_lon,rmse_m(:,3)];
rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];

s_u_lon(:,:,4) = u2;
s_v_lon(:,:,4) = v2;
s_su_lon(:,:,4) = s2;
s_sv_lon(:,:,4) = d2;
% % mult norm
% load(s_mult_norm_lon_file);
% rs_u_lon = [rs_u_lon,rmse_m(:,1)];
% rs_v_lon = [rs_v_lon,rmse_m(:,2)];
% rs_su_lon = [rs_su_lon,rmse_m(:,3)];
% rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];
% 
% s_u_lon(:,:,7) = u2;
% s_v_lon(:,:,7) = v2;
% s_su_lon(:,:,7) = s2;
% s_sv_lon(:,:,7) = d2;
% multv
load(s_multv_lon_file);
rs_u_lon = [rs_u_lon,rmse_m(:,1)];
rs_v_lon = [rs_v_lon,rmse_m(:,2)];
rs_su_lon = [rs_su_lon,rmse_m(:,3)];
rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];

s_u_lon(:,:,5) = u2;
s_v_lon(:,:,5) = v2;
s_su_lon(:,:,5) = s2;
s_sv_lon(:,:,5) = d2;
% pca prod
load(s_pca_prod_lon_file);
rs_u_lon = [rs_u_lon,rmse_m(:,1)];
rs_v_lon = [rs_v_lon,rmse_m(:,2)];
rs_su_lon = [rs_su_lon,rmse_m(:,3)];
rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];

s_u_lon(:,:,6) = u2;
s_v_lon(:,:,6) = v2;
s_su_lon(:,:,6) = s2;
s_sv_lon(:,:,6) = d2;
% pca sum
load(s_pca_sum_lon_file);
rs_u_lon = [rs_u_lon,rmse_m(:,1)];
rs_v_lon = [rs_v_lon,rmse_m(:,2)];
rs_su_lon = [rs_su_lon,rmse_m(:,3)];
rs_sv_lon = [rs_sv_lon,rmse_m(:,4)];

s_u_lon(:,:,7) = u2;
s_v_lon(:,:,7) = v2;
s_su_lon(:,:,7) = s2;
s_sv_lon(:,:,7) = d2;

%% read s lat
% sp
load(s_mp_lat_file);
rs_u_lat = [rs_u_lat,rmse_sp(:,1)];
rs_v_lat = [rs_v_lat,rmse_sp(:,2)];
rs_su_lat = [rs_su_lat,rmse_sp(:,3)];
rs_sv_lat = [rs_sv_lat,rmse_sp(:,4)];

s_u_lat(:,:,1) = u0;
s_v_lat(:,:,1) = v0;
s_su_lat(:,:,1) = s0;
s_sv_lat(:,:,1) = d0;

s_u_lat(:,:,2) = u1;
s_v_lat(:,:,2) = v1;
s_su_lat(:,:,2) = s1;
s_sv_lat(:,:,2) = d1;
% % spline norm
% load(s_mp_norm_lat_file);
% rs_u_lat = [rs_u_lat,rmse_sp(:,1)];
% rs_v_lat = [rs_v_lat,rmse_sp(:,2)];
% rs_su_lat = [rs_su_lat,rmse_sp(:,3)];
% rs_sv_lat = [rs_sv_lat,rmse_sp(:,4)];
% 
% s_u_lat(:,:,3) = u2;
% s_v_lat(:,:,3) = v2;
% s_su_lat(:,:,3) = s2;
% s_sv_lat(:,:,3) = d2;
% mp
load(s_mp_lat_file);
rs_u_lat = [rs_u_lat,rmse_m(:,1)];
rs_v_lat = [rs_v_lat,rmse_m(:,2)];
rs_su_lat = [rs_su_lat,rmse_m(:,3)];
rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];

s_u_lat(:,:,3) = u2;
s_v_lat(:,:,3) = v2;
s_su_lat(:,:,3) = s2;
s_sv_lat(:,:,3) = d2;
% % mp norm
% load(s_mp_norm_lat_file);
% rs_u_lat = [rs_u_lat,rmse_m(:,1)];
% rs_v_lat = [rs_v_lat,rmse_m(:,2)];
% rs_su_lat = [rs_su_lat,rmse_m(:,3)];
% rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];
% 
% s_u_lat(:,:,5) = u2;
% s_v_lat(:,:,5) = v2;
% s_su_lat(:,:,5) = s2;
% s_sv_lat(:,:,5) = d2;

% mult
load(s_mult_lat_file);
rs_u_lat = [rs_u_lat,rmse_m(:,1)];
rs_v_lat = [rs_v_lat,rmse_m(:,2)];
rs_su_lat = [rs_su_lat,rmse_m(:,3)];
rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];

s_u_lat(:,:,4) = u2;
s_v_lat(:,:,4) = v2;
s_su_lat(:,:,4) = s2;
s_sv_lat(:,:,4) = d2;

% % mult norm
% load(s_mult_norm_lat_file);
% rs_u_lat = [rs_u_lat,rmse_m(:,1)];
% rs_v_lat = [rs_v_lat,rmse_m(:,2)];
% rs_su_lat = [rs_su_lat,rmse_m(:,3)];
% rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];
% 
% s_u_lat(:,:,7) = u2;
% s_v_lat(:,:,7) = v2;
% s_su_lat(:,:,7) = s2;
% s_sv_lat(:,:,7) = d2;

% multv
load(s_multv_lat_file);
rs_u_lat = [rs_u_lat,rmse_m(:,1)];
rs_v_lat = [rs_v_lat,rmse_m(:,2)];
rs_su_lat = [rs_su_lat,rmse_m(:,3)];
rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];

s_u_lat(:,:,5) = u2;
s_v_lat(:,:,5) = v2;
s_su_lat(:,:,5) = s2;
s_sv_lat(:,:,5) = d2;

% pca prod
load(s_pca_prod_lat_file);
rs_u_lat = [rs_u_lat,rmse_m(:,1)];
rs_v_lat = [rs_v_lat,rmse_m(:,2)];
rs_su_lat = [rs_su_lat,rmse_m(:,3)];
rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];

s_u_lat(:,:,6) = u2;
s_v_lat(:,:,6) = v2;
s_su_lat(:,:,6) = s2;
s_sv_lat(:,:,6) = d2;

% pca sum
load(s_pca_sum_lat_file);
rs_u_lat = [rs_u_lat,rmse_m(:,1)];
rs_v_lat = [rs_v_lat,rmse_m(:,2)];
rs_su_lat = [rs_su_lat,rmse_m(:,3)];
rs_sv_lat = [rs_sv_lat,rmse_m(:,4)];

s_u_lat(:,:,7) = u2;
s_v_lat(:,:,7) = v2;
s_su_lat(:,:,7) = s2;
s_sv_lat(:,:,7) = d2;

%% read t lon
% sp
load(t_mp_lon_file);
rt_u_lon = [rt_u_lon,rmse_sp(:,1)];
rt_v_lon = [rt_v_lon,rmse_sp(:,2)];
rt_su_lon = [rt_su_lon,rmse_sp(:,3)];
rt_sv_lon = [rt_sv_lon,rmse_sp(:,4)];

t_u_lon(:,:,1) = u0;
t_v_lon(:,:,1) = v0;
t_su_lon(:,:,1) = s0;
t_sv_lon(:,:,1) = d0;

t_u_lon(:,:,2) = u1;
t_v_lon(:,:,2) = v1;
t_su_lon(:,:,2) = s1;
t_sv_lon(:,:,2) = d1;

% % spline norm
% load(t_mp_norm_lon_file);
% rt_u_lon = [rt_u_lon,rmse_sp(:,1)];
% rt_v_lon = [rt_v_lon,rmse_sp(:,2)];
% rt_su_lon = [rt_su_lon,rmse_sp(:,3)];
% rt_sv_lon = [rt_sv_lon,rmse_sp(:,4)];
% 
% t_u_lon(:,:,3) = u2;
% t_v_lon(:,:,3) = v2;
% t_su_lon(:,:,3) = s2;
% t_sv_lon(:,:,3) = d2;

% mp
load(t_mp_lon_file);
rt_u_lon = [rt_u_lon,rmse_m(:,1)];
rt_v_lon = [rt_v_lon,rmse_m(:,2)];
rt_su_lon = [rt_su_lon,rmse_m(:,3)];
rt_sv_lon = [rt_sv_lon,rmse_m(:,4)];

t_u_lon(:,:,3) = u2;
t_v_lon(:,:,3) = v2;
t_su_lon(:,:,3) = s2;
t_sv_lon(:,:,3) = d2;

% % mp norm
% load(t_mp_norm_lon_file);
% rt_u_lon = [rt_u_lon,rmse_m(:,1)];
% rt_v_lon = [rt_v_lon,rmse_m(:,2)];
% rt_su_lon = [rt_su_lon,rmse_m(:,3)];
% rt_sv_lon = [rt_sv_lon,rmse_m(:,4)];
% 
% t_u_lon(:,:,5) = u2;
% t_v_lon(:,:,5) = v2;
% t_su_lon(:,:,5) = s2;
% t_sv_lon(:,:,5) = d2;

% mult
load(t_mult_lon_file);
rt_u_lon = [rt_u_lon,rmse_m(:,1)];
rt_v_lon = [rt_v_lon,rmse_m(:,2)];
rt_su_lon = [rt_su_lon,rmse_m(:,3)];
rt_sv_lon = [rt_sv_lon,rmse_m(:,4)];

t_u_lon(:,:,4) = u2;
t_v_lon(:,:,4) = v2;
t_su_lon(:,:,4) = s2;
t_sv_lon(:,:,4) = d2;

% % mult norm
% load(t_mult_norm_lon_file);
% rt_u_lon = [rt_u_lon,rmse_m(:,1)];
% rt_v_lon = [rt_v_lon,rmse_m(:,2)];
% rt_su_lon = [rt_su_lon,rmse_m(:,3)];
% rt_sv_lon = [rt_sv_lon,rmse_m(:,4)];
% 
% t_u_lon(:,:,7) = u2;
% t_v_lon(:,:,7) = v2;
% t_su_lon(:,:,7) = s2;
% t_sv_lon(:,:,7) = d2;

% multv
load(t_multv_lon_file);
rt_u_lon = [rt_u_lon,rmse_m(:,1)];
rt_v_lon = [rt_v_lon,rmse_m(:,2)];
rt_su_lon = [rt_su_lon,rmse_m(:,3)];
rt_sv_lon = [rt_sv_lon,rmse_m(:,4)];

t_u_lon(:,:,5) = u2;
t_v_lon(:,:,5) = v2;
t_su_lon(:,:,5) = s2;
t_sv_lon(:,:,5) = d2;

% pca prod
load(t_pca_prod_lon);
rt_u_lon = [rt_u_lon,rmse_m(:,1)];
rt_v_lon = [rt_v_lon,rmse_m(:,2)];
rt_su_lon = [rt_su_lon,rmse_m(:,3)];
rt_sv_lon = [rt_sv_lon,rmse_m(:,4)];

t_u_lon(:,:,6) = u2;
t_v_lon(:,:,6) = v2;
t_su_lon(:,:,6) = s2;
t_sv_lon(:,:,6) = d2;

% pca sum
load(t_pca_sum_lon);
rt_u_lon = [rt_u_lon,rmse_m(:,1)];
rt_v_lon = [rt_v_lon,rmse_m(:,2)];
rt_su_lon = [rt_su_lon,rmse_m(:,3)];
rt_sv_lon = [rt_sv_lon,rmse_m(:,4)];

t_u_lon(:,:,7) = u2;
t_v_lon(:,:,7) = v2;
t_su_lon(:,:,7) = s2;
t_sv_lon(:,:,7) = d2;

% explain_rmse = 'from the 1st columns to the end columns are:[spline,spline_norm,mp,mp_norm,mult,multv,pca_prod,pca_sum]';
% explain = 'all are the matrix,from the 1st to the end are [origin,spline,spline_norm,mp,mp_norm,mult,multv,pca_prod,pca_sum]';

explain_rmse = 'from the 1st columns to the end columns are:[spline,mp,mult,multv,pca_prod,pca_sum]';
explain = 'all are the matrix,from the 1st to the end are [origin,spline,mp,mult,multv,pca_prod,pca_sum]';


%% save file
save([path,'s_lon.mat'], 'rs_u_lon','s_u_lon','rs_v_lon','s_v_lon','rs_su_lon','s_su_lon','rs_sv_lon','s_sv_lon','explain_rmse','explain');

save([path,'s_lat.mat'], 'rs_u_lat','s_u_lat','rs_v_lat','s_v_lat','rs_su_lat','s_su_lat','rs_sv_lat','s_sv_lat','explain_rmse','explain');

save([path,'t_lon.mat'], 'rt_u_lon','t_u_lon','rt_v_lon','t_v_lon','rt_su_lon','t_su_lon','rt_sv_lon','t_sv_lon','explain_rmse','explain');

