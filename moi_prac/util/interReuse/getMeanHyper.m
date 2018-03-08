%   getMeanHyper
%@tID:  1 for phoenix,2 for fenggod,3 for kamurrir,4 for seagull
%@mType: 1 for mult_pca_prod;2 for mult; 3 for mult_td_pca_prod;4 for four
%dimension mult
function [hypu,hypv] = getMeanHyper(tID,mType)  
basepath = [cd,'/moi_prac/reuse/typhoon/phoenix/'];


filename  = {};
filename_mult_pca = {'Inter_phoenix_vmp.mat','Inter_fenggod.mat','Inter_kamurri.mat','Inter_seagull.mat'};
filename_mult = {'Inter_phoenix_mult.mat','Inter_fenggod_mult.mat','Inter_kamurri_mult.mat','Inter_seagull_mult.mat'};
filename_mult_td_pca = {'Inter_phoenix_td_prod.mat','Inter_fenggod_td_prod.mat','Inter_kamurri_td_prod.mat','Inter_seagull_td_prod.mat'};
filename_mult_fd = {'Inter_phoenix_fd_mult.mat','Inter_fenggod_fd_mult.mat','Inter_kamurri_fd_mult.mat','Inter_seagull_fd_mult.mat'};

switch mType
     case 1
        filename = filename_mult_pca;
    case 2
        filename = filename_mult;
    case 3
       filename = filename_mult_td_pca;
    case 4
       filename = filename_mult_fd;
end

switch tID
    case 1
        load([basepath,filename{1}]);
    case 2
        load([basepath,filename{2}]);
    case 3
       load([basepath,filename{3}]);
    case 4
       load([basepath,filename{4}]);
end


covU = []; covV = [];
likU = []; likV = [];
reg_size = size(rmse,2);

for i = 1:reg_size    
    covU = [covU,hyper{i}{1}.cov];
    covV = [covV,hyper{i}{2}.cov];
    likU = [likU,hyper{i}{1}.lik];
    likV = [likV,hyper{i}{1}.lik];
end

covu = mean(covU,2);
covv = mean(covV,2);
liku = mean(likU,2);
likv = mean(likV,2);

cov = covu;lik = liku;
hypu.cov = cov;
hypu.lik = lik;

cov = covv;lik = likv;
hypv.cov = cov;
hypv.lik = lik;




