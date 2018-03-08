%   getMeanHyper
%@tID:  1 for space interpolation, 2 for time interpolation
%@mType: 1 for batch 1;2 for batch all
%dimension mult
function [hypu,hypv] = getMeanHyperOfMpng(tID,mType)  
basepath = [cd,'/moi_prac/reuse/normalday/mpng/'];
normpath1 = [basepath 'space/time4/']; % space interpolation path
normpath2 = [basepath 'time/reg1/']; % time interpolation path
normpath3 = [basepath 'space/time15/']; % space interpolation path
normpath4 = [basepath 'time/reg5/']; % time interpolation path
% regPath = {normpath1,normpath2,normpath3,normpath4};

f_space = 'Inter_mpng_space.mat';
f_time = 'Inter_mpng_time.mat';
f_space_all = 'Inter_mpng_all_space.mat';
f_time_all = 'Inter_mpng_all_time.mat';
train_size = 0;
s = {};
switch(tID)
    case 1
        if(mType==1)
           s =  load([normpath1 f_space]);
            train_size = 15;
        else
           s =  load([normpath3 f_space_all]);
            train_size = 15;
        end
    case 2
        if(mType==1)
          s =   load([normpath2 f_time]);
            train_size = 20;
        else
           s =  load([normpath4 f_time_all]);
            train_size = 20;
        end
end

covU = []; covV = [];
likU = []; likV = [];
reg_size = size(s.rmse,2);

train_index = randi(reg_size,1,train_size);

for i = 1:train_size
    j = train_index(i);
    covU = [covU,s.hyper{j}{1}.cov];
    covV = [covV,s.hyper{j}{2}.cov];
    likU = [likU,s.hyper{j}{1}.lik];
    likV = [likV,s.hyper{j}{1}.lik];
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




