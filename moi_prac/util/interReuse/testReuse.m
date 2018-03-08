% interpolate using the old hyperparameters
function testReuse()
basepath = [cd,'/','moi_prac','/','reuse','/','typhoon','/'];

filename_uv = {'ECreg_s_LON0-10LAT10-20.mat','ECreg_s_LON0-10LAT20-30.mat'};
hypfilename = {'Inter_fenggod.mat','Inter_phoenix.mat'};

gInter = load([basepath,hypfilename{1}]);
pInter = load([basepath,hypfilename{2}]);

samp = 2;
epIndex = 4;    mIndex = 5; 
uvIndex = getUVIndex(epIndex,mIndex);    %the fifth method(mult_pca_prod)
hypIndex = uvIndex-1;

g_hyp_u = gInter.hyper{hypIndex}{1};    %1 for u10
g_hyp_v = gInter.hyper{hypIndex}{2};    %2 for v10
p_hyp_u = pInter.hyper{hypIndex}{1};    %1 for v10
p_hyp_v = pInter.hyper{hypIndex}{2};    %2 for v10

annot = {'true','reuse','primal'};


%============================================sea gull====================================================
spIndex = 7;
% set filename for interpolating data,reusing the hyper of phoenix to gull
minlon = 0;maxlon = 10;minlat = 10;maxlat = 20;
interFile = [basepath,filename_uv{1}];
typeV = 1;  %u10
hyp = p_hyp_u;
[u0,g_reuse_u1,consum,inter] = Inter(interFile,minlon,minlat,maxlon,maxlat,typeV,samp,hyp);
disp('sea gull u0 and predicted sea gull u1 using hyper of phoenix:')
disp(num2str(mean(getRMSE(u0,g_reuse_u1))));
disp('sea gull u0 and predicted sea gull u1 using hyper of sea gull:')
disp(num2str(gInter.rmse{epIndex}(typeV,mIndex)));
disp('sea gull u0 and spline predicted sea gull u1 in spline')
disp(num2str(gInter.rmse{epIndex}(typeV,spIndex)));
% u_temp_re = {u0,g_reuse_u1,};


typeV = 2;  %v10

hyp = p_hyp_v;
[v0,g_reuse_v1,consum,inter] = Inter(interFile,minlon,minlat,maxlon,maxlat,typeV,samp,hyp);
disp('sea gull v0 and predicted sea gull v1 using hyper of phoenix:')
disp(num2str(mean(getRMSE(v0,g_reuse_v1))));
disp('sea gull v0 and predicted sea gull v1 using hyper of sea gull:')
disp(num2str(gInter.rmse{epIndex}(typeV,mIndex)));
disp('sea gull v0 and spline predicted sea gull v1 in spline')
disp(num2str(gInter.rmse{epIndex}(typeV,spIndex)));

u_draw = {u0,g_reuse_u1,gInter.u{uvIndex}};
v_draw = {v0,g_reuse_v1,gInter.v{uvIndex}};
minlon = 120;maxlon = 130;minlat = 10;maxlat = 20;
regminLat = minlat;     regmaxlat = maxlat;
regminlon = minlon;	regmaxlon = maxlon;

index = 2;
offflag = 0;
spIndex = 3;
colorMax = 0;
mapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,annot);
diffMapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,0,spIndex,annot);


%============================================phoenix===================================================
minlon = 0;maxlon = 10;minlat = 20;maxlat = 30;
spIndex = 7;
% set filename for interpolating data,reusing the hyper of gull to phoenix
interFile = [basepath,filename_uv{2}];
typeV = 1;  %u10
hyp = g_hyp_u;
[u0,p_reuse_u1,consum,inter] = Inter(interFile,minlon,minlat,maxlon,maxlat,typeV,samp,hyp);

typeV = 2;  %v10

hyp = g_hyp_v;
[v0,p_reuse_v1,consum,inter] = Inter(interFile,minlon,minlat,maxlon,maxlat,typeV,samp,hyp);


u_draw = {u0,p_reuse_u1,pInter.u{uvIndex}};
v_draw = {v0,p_reuse_v1,pInter.v{uvIndex}};
minlon = 120;maxlon = 130;minlat = 10;maxlat = 20;
regminLat = minlat;     regmaxlat = maxlat;
regminlon = minlon;	regmaxlon = maxlon;

index = 2;
offflag = 0;
spIndex = 3;
colorMax = 0;
mapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,annot);
diffMapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,0,spIndex,annot);
end

%% Interpolation
function [u0,u1,consum,inter] = Inter(filename_ss,minlon,minlat,maxlon,maxlat,typeV,samp,hyp)
resolution = 0.125;
load(filename_ss);
% [sxpca,sypca,sxpca_train,sypca_train,sxpca_test,sypca_test] = filedata_pre(filename_ps,samp);
sx=[];sy=[];sx_train=[];sy_train=[];sx_test=[];sy_test=[];

switch(typeV)
    case 1
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,u,samp);
    case 2
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,v,samp);
    case 3 %direction
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,d_mat,samp);
    case 6 %direction
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,s_mat,samp);
   
end 

% interpolate
[u1_temp,consum,inter] = mpng_pca_prod(sx_train,sy_train,sx_test,hyp);
% end) estimate the result
size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;

u0 = reshape(sy,[size_lat,size_lon]);
u1 = sy;
nSize = size_lat*size_lon;
index_inter = 1;
for n = samp:samp:nSize
    u1(n,1) = u1_temp(index_inter);
    index_inter = index_inter+1;
end
u1       =	reshape(u1,[size_lat,size_lon]);

end

%% inter function
function [predict,consum,inter] = mpng_pca_prod(sx_train,sy_train,sx_test,hyp)
size_hyp_4_p = 15 ; %the size of hyperparameters for multi-scale method of pca feature: multi

size_hyp_4_s = 15 ; %the size of hyperparameters for multi-scale for space data/time data
covfunc4_pca = {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};
covfunc4_s =  {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};

covfunc4 = {'covProd',{covfunc4_s,covfunc4_pca}};
% a£© fit the pressure hyperparameters
hyp4.cov = hyp.cov;
hyp4.lik = hyp.lik;
likfunc4 = @likGauss;
consum= 0;
% c) regression and prediction
tic;
[predict s2_4 fmu_4 fs2_4] = gp(hyp4, @infGaussLik, [], covfunc4, likfunc4,sx_train, sy_train, sx_test);
inter = toc;
end