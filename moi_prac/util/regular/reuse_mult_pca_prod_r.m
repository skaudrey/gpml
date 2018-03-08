%% Interpolation
function [u0,u1,consum,inter,ys,sx_test,sy_test,sx_train,sy_train] = reuse_mult_pca_prod_r(prefix_s,minlon,minlat,maxlon,maxlat,typeV,samp,stamp,hyp)
resolution = 0.125;
region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat) 'stamp' num2str(stamp)];
filename_ss = strcat(prefix_s,region,'.mat');   %space data of all variables
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
[u1_temp,consum,inter,ys] = mpng_pca_prod(sx_train,sy_train,sx_test,hyp);
% end) estimate the result
size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;

% u0 = reshape(sy,[size_lat,size_lon]);
% u1 = sy;
% nSize = size_lat*size_lon;
% index_inter = 1;
% for n = samp:samp:nSize
%     u1(n,1) = u1_temp(index_inter);
%     index_inter = index_inter+1;
% end
% u1       =	reshape(u1,[size_lat,size_lon]);

% y_test   =  reshape(sy_test,fix(size_lat/samp),size_lon);
% u1_temp  =	reshape(u1_temp,fix(size_lat/samp),size_lon); 
% ys       =  reshape(ys,fix(size_lat/samp),size_lon); 
u0       =  sy_test;
u1       =	u1_temp;

end

%% inter function
function [predict,consum,inter,ys] = mpng_pca_prod(sx_train,sy_train,sx_test,hyp)
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
ys = s2_4;
end