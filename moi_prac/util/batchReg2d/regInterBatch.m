function [u0,u1,v0,v1,s0,s1,d0,d1,consum,inter,hyp] = regInterBatch(typeS,typeI,typeD,typeM,path,minlon,minlat,maxlon,maxlat,epoch,samp,sub_row,sub_col)
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
        [u0 u1 consum1 inter1 hypu] = matRegInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
        [v0 v1 consum2 inter2 hypv] = matRegInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp,sub_row,sub_col);
%         [s0 s1 consum3 inter3 hyps] = matRegInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp,sub_row,sub_col);
%         [d0 d1 consum4 inter4 hypd] = matRegInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp,sub_row,sub_col);
        disp('----------------- mat done ------------------');
    case 19 %mpng
        [u0 u1 consum1 inter1 hypu] = reg_mpngBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
        [v0 v1 consum2 inter2 hypv] = reg_mpngBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp,sub_row,sub_col);
%         [s0 s1 consum3 inter3 hyps] = reg_mpngBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp,sub_row,sub_col);
%         [d0 d1 consum4 inter4 hypd] = reg_mpngBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp,sub_row,sub_col);
        disp('---------- mpng done --------------');
    case 20 %pcareg_m_sum
        [u0 u1 consum1 inter1 hypu] = reg_mat_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
        [v0 v1 consum2 inter2 hypv] = reg_mat_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp,sub_row,sub_col);
%         [s0 s1 consum3 inter3 hyps] = reg_mat_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp,sub_row,sub_col);
%         [d0 d1 consum4 inter4 hypd] = reg_mat_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp,sub_row,sub_col);
        disp('------------- mat pca sum done ----------------');
    case 21 %pcareg_m_prod
        [u0 u1 consum1 inter1 hypu] = reg_mat_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
        [v0 v1 consum2 inter2 hypv] = reg_mat_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp,sub_row,sub_col);
%         [s0 s1 consum3 inter3 hyps] = reg_mat_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp,sub_row,sub_col);
%         [d0 d1 consum4 inter4 hypd] = reg_mat_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp,sub_row,sub_col);
        disp('------------- mat pca prod done ----------------');
    case 22 %pcareg_mpng_prod
        [u0 u1 consum1 inter1 hypu] = reg_mult_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
        [v0 v1 consum2 inter2 hypv] = reg_mult_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp,sub_row,sub_col);
%         [s0 s1 consum3 inter3 hyps] = reg_mult_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp,sub_row,sub_col);
%         [d0 d1 consum4 inter4 hypd] = reg_mult_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp,sub_row,sub_col);
        disp('------------- mpng pca prod done ----------------');
    case 23 %pcareg_mpng_sum
        [u0 u1 consum1 inter1 hypu] = reg_mult_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
        [v0 v1 consum2 inter2 hypv] = reg_mult_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp,sub_row,sub_col);
%         [s0 s1 consum3 inter3 hyps] = reg_mult_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp,sub_row,sub_col);
%         [d0 d1 consum4 inter4 hypd] = reg_mult_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp,sub_row,sub_col);
        
        disp('------------- mpng pca sum done ----------------');
    case 24 %spline
        [u0 u1 consum1 inter1 hypu] = splineInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),samp,sub_row,sub_col);
        [v0 v1 consum2 inter2 hypv] = splineInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),samp,sub_row,sub_col);
%         [s0 s1 consum3 inter3 hyps] = splineInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),samp,sub_row,sub_col);
%         [d0 d1 consum4 inter4 hypd] = splineInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),samp,sub_row,sub_col);
        disp('------------- spline done ----------------');
    case 25
        [u0 u1 consum1 inter1 hypu] = mpInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
        [v0 v1 consum2 inter2 hypv] = mpInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
%         [s0 s1 consum3 inter3 hyps] = mpInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
%         [d0 d1 consum4 inter4 hypd] = mpInterBatch(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);  
        disp('------------- mp done ----------------');
    case 26
        [u0 u1 consum1 inter1 hypu] = reg_mp_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
        [v0 v1 consum2 inter2 hypv] = reg_mp_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
%         [s0 s1 consum3 inter3 hyps] = reg_mp_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
%         [d0 d1 consum4 inter4 hypd] = reg_mp_pca_prodBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
        disp('------------- mp pca prod done ----------------');
    case 27
        [u0 u1 consum1 inter1 hypu] = reg_mp_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
        [v0 v1 consum2 inter2 hypv] = reg_mp_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
%         [s0 s1 consum3 inter3 hyps] = reg_mp_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
%         [d0 d1 consum4 inter4 hypd] = reg_mp_pca_sumBatch(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,sub_row,sub_col);
        disp('------------- mp pca sum done ----------------');
end

consum = [consum1,consum2,consum3,consum4]';
inter = [inter1,inter2,inter3,inter4]';
hyp = {hypu,hypv,hyps,hypd};