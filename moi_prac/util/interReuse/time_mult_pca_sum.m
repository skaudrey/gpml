% pca feature for GPR
% combine the feature: sst,mslp,d to one feature and train the kernel
% parameters just for this function

function [u0 u1 lat lon consum inter hyp] = time_mult_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV,epoch,samp,stamp)
resolution = 0.125;
size_lat =  (maxlat-minlat)/resolution+1;
size_lon =  (maxlon-minlon)/resolution+1;
%% some global variables for EC data
region  = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' num2str(minlat) '-' num2str(maxlat) 'stamp' num2str(stamp)];
filename_ps = strcat(prefix_p,region,'.txt');  %pca data
 
filename_ss = strcat(prefix_s,region,'.mat');   %space data of all variables
%====================hyperparameters size=========================== 
 % for wind speed interpolation ,the different hyperparameters size of each method
size_hyp_4_p = 15 ; %the size of hyperparameters for multi-scale method of pca feature: multi

size_hyp_4_s = 15 ; %the size of hyperparameters for multi-scale for space data/time data

size_reduce = 4;    % get 20% of the train set as the training set

nswap = 30; % number of swaps between candidate reducing points and hyp.xu 

% ====================data preprocessing parameters========================


%% 0)read data and preprocessing the outlier

% space information data
load(filename_ss);
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


[sypca,sypca_train,sypca_test] = filedata_pre(filename_ps,samp,size_lat,size_lon);

% delete the unuseful data to release space
clear sypca sypca_test  

train_num = size(sypca_train,1);
reduce_num = fix(train_num/size_reduce);

%% 4) space interpolation for wind speed with other variables:pressure and temp with multi; direction with periodic
covfunc4_pca = {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};
covfunc4_s =  {'covSum',{{@covMaternard,1}, {'covPERard',{@covMaternard,1}} , 'covNoise','covGaborard'}};

covfunc4 = {'covSum',{covfunc4_s,covfunc4_pca}};
% 4a£© fit the pressure hyperparameters -- pca
tic;
hyp4_p.cov = zeros(1,size_hyp_4_p)';  hyp4_p.lik = log(0.1); likfunc4_p = @likGauss; 

% sparse inference
reducing  = sort(randi(train_num,[reduce_num,1])); % get the index of the inducing points
pca_xu = sx_train(reducing,:);   % get the inducing points
inf = @infGaussLik;
cov_pca = {'apxSparse',covfunc4_pca,pca_xu};           % inducing points
hyp4_p.xu = pca_xu;
infv_pca  = @(varargin) inf(varargin{:},struct('s',0.0));           % VFE, opt.s = 0

% hyp4_p = minimize(hyp4_p,@gp,-epoch,@infGaussLik,[],covfunc4_pca,likfunc4_p,sypca_train,sy_train);
% hyp4_p = minimize(hyp4_p,@gp,-epoch,infv_pca,[],cov_pca,likfunc4_p,sypca_train,sy_train);
hyp4_p = minimize(hyp4_p,@gp,-epoch,infv_pca,[],cov_pca,likfunc4_p,sx_train,sypca_train);
%  z = sort(randi(train_num,[reduce_num,1])); % get the index of the inducing points
%  % candidate inducing points
%  z = sypca_train(z,:); 
%  hyp4_p = vfe_xu_opt(hyp4_p,[],cov_pca,sx_train,sypca_train,z,nswap);

% 4d£© fit the time hyperparameters -- spatial feature
% sparse inference
reducing  = sort(randi(train_num,[reduce_num,1]));  % get the index of the inducing points
s_xu = sx_train(reducing,:);
inf = @infGaussLik;
cov_s = {'apxSparse',covfunc4_s,s_xu};           % inducing points
hyp4_s.xu = s_xu;
infv_s  = @(varargin) inf(varargin{:},struct('s',0.0));           % VFE, opt.s = 0

hyp4_s.cov = zeros(1,size_hyp_4_s)';  hyp4_s.lik = log(0.1); likfunc4_s = @likGauss; 
% hyp4_s = minimize(hyp4_s,@gp,-epoch,@infGaussLik,[],covfunc4_s,likfunc4_s,sx_train,sy_train);
hyp4_s = minimize(hyp4_s,@gp,-epoch,infv_s,[],cov_s,likfunc4_s,sx_train,sy_train);
consum = toc;
% z = sort(randi(train_num,[reduce_num,1])); % get the index of the inducing points
% % candidate inducing points
% z = sy_train(z,:); 
% hyp4_s = vfe_xu_opt(hyp4_s,[],cov_s,sx_train,sy_train,z,nswap);

hyp4.cov = [hyp4_s.cov;hyp4_p.cov];
% hyp4.cov = zeros(1,30)';
% hyp4.lik = log(exp(hyp4_p.lik) + exp(hyp4_s.lik)) ;
hyp4.lik = hyp4_s.lik ;

likfunc4 = @likGauss;

% 4e) regression and prediction
tic;
[u1_temp s2_4 fmu_4 fs2_4] = gp(hyp4, @infGaussLik, [], covfunc4, likfunc4,sx_train, sy_train, sx_test);
inter = toc;

hyp = hyp4;
%% end) estimate the result
% 
% u0 = reshape(sy,[size_lat,size_lon]);
% u1 = sy;
% nSize = size_lat*size_lon;
% index_inter = 1;
% for n = samp_inter_s:samp_inter_s:nSize
%     u1(n,1) = u1_temp(index_inter);
%     index_inter = index_inter+1;
% end
% u1       =	reshape(u1,[size_lat,size_lon]);

u0 = sy;
u1 = u0;
% nSize = size_lat*size_lon;
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

function [y,y_train,y_test] = filedata_pre(filename,samp_inter,size_lat,size_lon)

y_p = load(filename)';
% y = [y_p,s_mat];
y = reshape(y_p,size_lon,size_lat);
% y_s = reshape(s_mat,size_lon,size_lat);
y_p = reshape(y_p,size_lon,size_lat);
% nSize = size(y,1);
% x = linspace(1,nSize,nSize)';
% nSize = size(y,1);

% d) set train sets and the test sets
% x_train = x(1:samp_inter:nSize);
% y_train = y(1:samp_inter:nSize);
% x_test = x(samp_inter:samp_inter:nSize);
% y_test = y(samp_inter:samp_inter:nSize);

% y_test = [reshape(y_p(samp_inter:samp_inter:size_lon,samp_inter:samp_inter:size_lat),[],1),...
%    reshape(y_s(samp_inter:samp_inter:size_lon,samp_inter:samp_inter:size_lat),[],1) ];
y_test = reshape(y_p(samp_inter:samp_inter:size_lon,samp_inter:samp_inter:size_lat),[],1);
size_test = size(y_p,1);

index = 1; 
% x_train = zeros(size_test,2); 
y_train = zeros(size_test,1);
for i = 1:size_lon
    for j = 1:size_lat
        if(mod(i,samp_inter)~=0 || mod(j,samp_inter) ~= 0)
%             x_train(index,:) = [x_lat(i,j)  x_lon(i,j)];
%             y_train(index,:) = [y_p(i,j) y_s(i,j)];
            y_train(index,:) = y_p(i,j);
            index = index+1;
        end
    end
end


