function [u0,u1,v0,v1,s0,s1,d0,d1,consum,inter,hyp] = regInter(typeS,typeI,typeD,typeM,path,minlon,minlat,maxlon,maxlat,epoch,samp)
%% global variables
typeV_pca = 7;  % pca feature
u0 = [];   u1 = [];   consum1 = 0.0;    inter1 = 0.0;   hypu = [];%column vector
v0 = [];   v1 = [];   consum2 = 0.0;    inter2 = 0.0;   hypv = [];
s0 = [];   s1 = [];   consum3 = 0.0;    inter3 = 0.0;   hyps = [];
d0 = [];   d1 = [];   consum4 = 0.0;    inter4 = 0.0;   hypd = [];


typeV = [1 2 6 3];  %u10,v10,s,d;aka typeV =1,2,6,3

%% make interpolation for u10,v10,s,d;aka typeV =1,2,6,3
prefix_p = [path getPrefixByType(typeS,typeI,typeV_pca,typeD)]; % pca
prefix_s = [path getPrefixByType(typeS,typeI,0,typeD)]; % others bariable type,both ok

switch(typeM)
    case 18 %mat
        [u0 u1 consum1 inter1 hypu] = matRegInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp);
        [v0 v1 consum2 inter2 hypv] = matRegInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp);
%         [s0 s1 consum3 inter3] = matRegInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = matRegInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        disp('----------------- mat done ------------------');
    case 19 %mpng
        [u0 u1 consum1 inter1 hypu] = reg_mpng(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp);
        [v0 v1 consum2 inter2 hypv] = reg_mpng(prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp);
%         [s0 s1 consum3 inter3] = reg_mpng(prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = reg_mpng(prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        disp('---------- mpng done --------------');
    case 20 %pcareg_m_sum
        [u0 u1 consum1 inter1 hypu] = reg_mat_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp);
        [v0 v1 consum2 inter2 hypv] = reg_mat_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp);
%         [s0 s1 consum3 inter3] = reg_mat_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = reg_mat_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        disp('------------- mat pca sum done ----------------');
    case 21 %pcareg_m_prod
        [u0 u1 consum1 inter1 hypu] = reg_mat_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp);
        [v0 v1 consum2 inter2 hypv] = reg_mat_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp);
%         [s0 s1 consum3 inter3] = reg_mat_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = reg_mat_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        disp('------------- mat pca prod done ----------------');
    case 22 %pcareg_mpng_prod
        [u0 u1 consum1 inter1 hypu] = reg_mult_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp);
        [v0 v1 consum2 inter2 hypv] = reg_mult_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp);
%         [s0 s1 consum3 inter3] = reg_mult_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = reg_mult_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        disp('------------- mpng pca prod done ----------------');
    case 23 %pcareg_mpng_sum
        [u0 u1 consum1 inter1 hypu] = reg_mult_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp);
        [v0 v1 consum2 inter2 hypv] = reg_mult_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp);
%         [s0 s1 consum3 inter3] = reg_mult_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = reg_mult_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        
        disp('------------- mpng pca sum done ----------------');
    case 24 %spline
        [u0 u1 consum1 inter1 hypu] = splineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),samp);
        [v0 v1 consum1 inter1 hypv] = splineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),samp);
%         [s0 s1 consum3 inter3] = splineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),samp);
%         [d0 d1 consum4 inter4] = splineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),samp);
        disp('------------- spline done ----------------');
    case 25
        [u0 u1 consum1 inter1 hypu] = mpRegInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp);
        [v0 v1 consum2 inter2 hypv] = mpRegInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp);
%         [s0 s1 consum3 inter3] = mpRegInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = mpRegInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        disp('------------- mp done ----------------');
    case 26 %pcareg_mp_prod
        [u0 u1 consum1 inter1 hypu] = reg_mp_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp);
        [v0 v1 consum2 inter2 hypv] = reg_mp_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp);
%         [s0 s1 consum3 inter3] = reg_mp_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = reg_mp_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        disp('------------- mp pca prod done ----------------');
    case 27 %pcareg_mp_sum
        [u0 u1 consum1 inter1 hypu] = reg_mp_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp);
        [v0 v1 consum2 inter2 hypv] = reg_mp_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp);
%         [s0 s1 consum3 inter3] = reg_mp_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = reg_mp_pca_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        
        disp('------------- mp pca sum done ----------------');
    case 28
        [u0 u1 consum1 inter1 hypu] = reg_mult_pcamat_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp);
        [v0 v1 consum2 inter2 hypv] = reg_mult_pcamat_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp);
%         [s0 s1 consum3 inter3] = reg_mult_pcamat_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = reg_mult_pcamat_sum(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        
        disp('------------- mult pca mat sum done ----------------');
    case 29
        [u0 u1 consum1 inter1 hypu] = reg_mult_pcamat_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp);
        [v0 v1 consum2 inter2 hypv] = reg_mult_pcamat_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp);
%         [s0 s1 consum3 inter3] = reg_mult_pcamat_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = reg_mult_pcamat_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
%         
        disp('------------- mult pca mat prod done ----------------');
end

consum = [consum1,consum2,consum3,consum4]';
inter = [inter1,inter2,inter3,inter4]';
hyp = {hypu,hypv,hyps,hypd};