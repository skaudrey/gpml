% compHyper of the method mpng_pca_sum for typhoon region
% most are in the line
close all
basepath = [cd,'/','moi_prac','/','reuse','/','typhoon','/'];

filename = {'Inter_fenggod_mult.mat','Inter_kamurri_mult.mat'};

fengGod = load([basepath,filename{1}]);
phoenix = load([basepath,filename{2}]);

fgCovU = []; fgCovV = [];
pCovU = []; pCovV = [];
fgLikU = []; fgLikV = [];
pLikU = []; pLikV = [];
param_size = size(fengGod.hyper{1}{1}.cov,1);
reg_size = size(fengGod.rmse,2);

for i = 1:reg_size    
    fgCovU = [fgCovU,fengGod.hyper{i}{1}.cov];
    pCovU = [pCovU,phoenix.hyper{i}{1}.cov];
    fgCovV = [fgCovV,fengGod.hyper{i}{2}.cov];
    pCovV = [pCovV,phoenix.hyper{i}{2}.cov];
    fgLikU = [fgLikU,fengGod.hyper{i}{1}.lik];
    pLikU = [pLikU,phoenix.hyper{i}{1}.lik];
    fgLikV = [fgLikV,fengGod.hyper{i}{1}.lik];
    pLikV = [pLikV,phoenix.hyper{i}{1}.lik];
end

%% compare hyperpatameters of cov
figure('NumberTitle','off','Name','typhoon u hyper of cov correlation')
for i=1:param_size
    subplot(5,6,i)
    scatter(fgCovU(i,:),pCovU(i,1:reg_size));
  
end

figure('NumberTitle','off','Name','typhoon v hyper of cov correlation')
for i=1:param_size
    subplot(5,6,i)
    scatter(fgCovV(i,:),pCovV(i,1:reg_size));   
end



%% compare hyperpatameters of lik
figure('NumberTitle','off','Name','typhoon u hyper of lik')
subplot(1,2,1)
scatter(fgLikU,pLikU(1:reg_size));
title('u lik');

subplot(1,2,2);
scatter(fgLikV,pLikV(1:reg_size));
title('v lik');

