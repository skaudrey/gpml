function regionname = regionName(typeS,typeI,typeM,typeD,minlon,maxlon,min,max)
regionname = '';

prefix_I = '';
prefix_M = '';
prefix_S = '';
prefix_D = '';

switch(typeS)
    case 0
        prefix_S = 'Inter_';
    case 1
        prefix_S = '';
    case 2
        prefix_S = '';
    case 3
        prefix_S = 'EC25_';    % space data for 0.25 degree
    case 4
        prefix_S = 'ECreg_';
    case 5
        prefix_S = 'ECreg_';
end

switch(typeI)
    case 1
        prefix_I = 's_';
    case 2
        prefix_I = 't_';
    case 3
        prefix_I = 'st_';
end

switch(typeM)
    case 0
        prefix_M = '';
    case 1
        prefix_M = 'mp_';
    case 2
        prefix_M = 'mult_';
    case 3
        prefix_M = 'multV_';
    case 4
        prefix_M = 'pca_Sum_';
    case 5
        prefix_M = 'pca_Prod_';
    case 6
        prefix_M = 'se_';
    case 7
        prefix_M = 'rq_';
    case 8
        prefix_M = 'period_';     
    case 9
        prefix_M = 'auto_'; 
    case 10
        prefix_M = 'pca_x_'; 
    case 11
        prefix_M = 'mpV_';
    case 12
        prefix_M = 'pca_mp';
    case 13
        prefix_M = 'pcareg_Sum_';
    case 14
        prefix_M = 'pcareg_Prod_';
    case 15
        prefix_M = 'pcareg_auto';
    case 16
        prefix_M = 'pcareg_x_';
    case 17
        prefix_M = 'pcareg_mp';
    case 18
        prefix_M = 'mat_';
    case 19
        prefix_M = 'mpng';
    case 20
        prefix_M = 'pcareg_m_sum';
    case 21
        prefix_M = 'pcareg_m_prod';
    case 22
        prefix_M = 'pcareg_mpng_prod';    %multiple the pca changed hyperparameters,kernels are maternard+periodic of materard+noise+gaborard
    case 23
        prefix_M = 'pcareg_mpng_sum';    %add the pca changed hyperparameters,kernels are maternard+periodic of materard+noise+gaborard
    case 24
        prefix_M = 'spline';
   
end

switch(typeD)
    case 1
        prefix_D = 'LON';
    case 2
        prefix_D = 'LAT';
end

if(typeS == 5 || typeS == 0)
    switch(typeD)
        case 1
            prefix_D = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' ];
        case 2
            prefix_D = ['LON' num2str(minlon) '-' num2str(maxlon) 'LAT' ];
    end

end

regionname = strcat(prefix_S,prefix_I,prefix_M,prefix_D,num2str(min),'-',num2str(max));


