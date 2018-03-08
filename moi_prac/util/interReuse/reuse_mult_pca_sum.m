%% Interpolation
function [u0,u1,lat,lon,consum,inter] = reuse_mult_pca_sum(prefix_s,minlon,minlat,maxlon,maxlat,typeV,samp,stamp,hyp)
resolution = 0.125;
size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;

region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat) 'stamp' num2str(stamp)];
filename_ss = strcat(prefix_s,region,'.mat');   %space data of all variables
load(filename_ss);
% [sxpca,sypca,sxpca_train,sypca_train,sxpca_test,sypca_test] = filedata_pre(filename_ps,samp);
sx=[];sy=[];sx_train=[];sy_train=[];sx_test=[];sy_test=[];

switch(typeV)
    case 1
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,u,samp,size_lat,size_lon);
    case 2
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,v,samp,size_lat,size_lon);
    case 3 %direction
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,d_mat,samp,size_lat,size_lon);
    case 6 %direction
        [sx,sy,sx_train,sy_train,sx_test,sy_test] = matdata_pre(x_mat,s_mat,samp,size_lat,size_lon);
   
end 

% interpolate
[u1_temp,consum,inter] = mpng_pca_sum(sx_train,sy_train,sx_test,hyp);
% end) estimate the result

u0 = sy;
u1 = u0;
index_inter = 1;

for i = 1:size_lon
    for j = 1:size_lat
        if(mod(i,samp)==0 & mod(j,samp) == 0)
           u1(i,j) = u1_temp(index_inter);
        end
    end
end
lat = reshape(sx(:,1), [size_lon,size_lat]);
lon = reshape(sx(:,2), [size_lon,size_lat]);

end


%% inter function
function [predict,consum,inter] = mpng_pca_sum(sx_train,sy_train,sx_test,hyp)
size_hyp_4_p = 15 ; %the size of hyperparameters for multi-scale method of pca feature: multi
size_hyp_4_s = 15 ; %the size of hyperparameters for multi-scale for space data/time data

covfunc4_pca = {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};
covfunc4_s =  {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};

covfunc4 = {'covSum',{covfunc4_s,covfunc4_pca}};
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


function [x,y,x_train,y_train,x_test,y_test] = matdata_pre(x,y,samp_inter,size_lat,size_lon)

x_lat = reshape(x(:,1),size_lon,size_lat);
x_lon = reshape(x(:,2),size_lon,size_lat);
y = reshape(y,size_lon,size_lat);

% x_train = [reshape(x_lat(1:samp_inter:size_lat,1:samp_inter:size_lon),[],1),...
%     reshape(x_lon(1:samp_inter:size_lat,1:samp_inter:size_lon),[],1)];
% y_train = reshape(y(1:samp_inter:size_lat,1:samp_inter:size_lon),[],1);
x_test = [reshape(x_lat(samp_inter:samp_inter:size_lon,samp_inter:samp_inter:size_lat),[],1),...
    reshape(x_lon(samp_inter:samp_inter:size_lon,samp_inter:samp_inter:size_lat),[],1)];
y_test = reshape(y(samp_inter:samp_inter:size_lon,samp_inter:samp_inter:size_lat),[],1);
size_test = size(y,1);

index = 1; x_train = zeros(size_test,2); y_train = zeros(size_test,1);
for i = 1:size_lon
    for j = 1:size_lat
        if(mod(i,samp_inter)~=0 || mod(j,samp_inter) ~= 0)
            x_train(index,:) = [x_lat(i,j)  x_lon(i,j)];
            y_train(index,:) = y(i,j);
            index = index+1;
        end
    end
end
end
