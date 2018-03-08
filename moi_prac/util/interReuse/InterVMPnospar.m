%% region all method compare
function InterVMPnospar()
%% global variables
close all;
% ATTENTION: the first column of x is longitude and the 2nd is latitude

% attention: only when the grid is even can you pick the match grid
minlon=0.0;minlat = 0.0;maxlon = 0.0;maxlat = 0.0;
resolution = 0.125; % for EC data,the resolution is 0.75'

typeS = 5;
typeI = 1;  % the interpolation data set type ,see in getPrefixByType,1 for space interpolation 2 for time interpolation
%need to be saved
u_temp = []; v_temp = []; su_temp = []; sv = []; train_time = []; inter_time = []; rmse = {};
rmse_explain = {'every cell of rmse is one cell of one specific epoch','mat','mpng','pcareg_m_sum','pcareg_m_prod','pcareg_mpng_prod','pcareg_mpng_sum','spline'};
data_explain = {'orgin','mat','mpng','pcareg_m_sum','pcareg_m_prod','pcareg_mpng_prod','pcareg_mpng_sum','spline'};
var_explain = {'u for u10 interpolation','v for v10 interpolation','su for recalculated u10','sv for recalculated v10'};
reg_explain = {};
time_explain = {'every columns is the interpolation or train time of variable u10,v10,s,d'};
stamp_explain = {'different timestamp for typhoon phoenix'};
epoch_explain = {'epoch are 100'};

basepath = cd;
normpath = [basepath '/moi_prac/reuse/typhoon/phoenix/'];
typpath = [basepath '/moi_prac/reuse/typhoon/phoenix/smd/'];
regPath = {normpath,typpath};

% epoch = 30; % need to be tested
samp = 2;  % just for test
m0 = 1;m1 = 2;% the method index that will be tested,see function regionName 
epoch  = 100;
stEnd = 26;
spec_path = {'','smd'};
%% interpolation
  
  
for typeD = 2:2 % space interpolation, space interpolation with smd feature, time interpolation, time inmterpoaltion with smd
    out_index = 1;
    train_time = [];   inter_time = [];   rmse = {};  hyper = {}; lat_map = []; lon_map = [];
    for stIndex = 1:stEnd   %set region
        u_temp = []; v_temp = []; su_temp = []; sv_temp = [];
        [minlon,maxlon,minlat,maxlat,stamp] = getStampReg(stIndex);
    %     minlon = 0;maxlon = 10;minlat = 20;maxlat = 30;
        reg_explain = {[ num2str(120+minlon) 'E'],...
        [ num2str(120+maxlon) 'E'],...
        [ num2str(minlat) 'N'],...
        [ num2str(maxlat) 'N'],...
        'the resolution of interpolation result is 0.25'};
        typeP = 2;
    %     for typeD = 2:-1:1     %set datatype,
            % change path of file 
            path = regPath{typeD};
            %reset for another dataset
            index = 1;
           rmse_temp = []; 
            % do intrtpolation method by method
           for typeM = m0:m1   % see function regionName

                    % dataset
                    [u0 u1 v0 v1 s0 s1 d0 d1 lat lon consum inter hyp] = ...
                        timeInter(typeS,typeI,typeP,typeM,path,minlon,minlat,maxlon,maxlat,epoch,samp,stamp);
                    [su0 sv0] = CalUVFromSpeed(s0,d0);
                    [su1 sv1] = CalUVFromSpeed(s1,d1);
                    if(index ==1)   % save origin as the first cell
                        u_temp{index} = u0;
                        v_temp{index} = v0;             
                        su_temp{index} = su0;
                        sv_temp{index} = sv0;
                        index = index + 1;              
                    end
                    u_temp{index} = u1;
                    v_temp{index} = v1;        
                    su_temp{index} = su1;
                    sv_temp{index} = sv1; 

                    %hyp
                    if(typeM~=2)
                        hyper{stIndex} = hyp;
                        lat_map{out_index} = lat;
                        lon_map{out_index} = lon;
                    end

                    % cputime
                    train_time = [train_time,consum];
                    inter_time = [inter_time,inter];
                    %rmse
                    rmse_u = mean(getRMSE(u0,u1));
                    rmse_v = mean(getRMSE(v0,v1));
                    rmse_su = mean(getRMSE(su0,su1));
                    rmse_sv = mean(getRMSE(sv0,sv1));        
                    temp = [rmse_u,rmse_v,rmse_su,rmse_sv]';        

                    rmse_temp = [rmse_temp temp];    

                index = index + 1;
                end            

            rmse{stIndex} = rmse_temp;
            u{stIndex} = u_temp;
            v{stIndex} = v_temp;
            su{stIndex} = su_temp;
            sv{stIndex} = sv_temp;

    end
             % save file,show result
    %         region = regionName(0,typeI,0,typeD,minlon,maxlon,minlat,maxlat);        
    filename = strcat(path,'Inter_phoenix_vmp_nospar_',spec_path(typeD),'.mat');    
    save(filename{1},'u','v','su','sv','rmse','lat_map','lon_map','train_time','inter_time','hyper','rmse_explain','data_explain','var_explain','reg_explain','time_explain','stamp_explain','epoch_explain');
%     end
end

       
% end

%% get region and stamp of phoenix,based on the data in file folder /reuse/typhoon

function [minlon,maxlon,minlat,maxlat,stamp] = getStampReg(stIndex)
stamp = 0;
minlon = 0;   maxlon = 10;   minlat = 0.0;   maxlat = 0.0;
if(stIndex>=1 & stIndex <=4)
    stamp = 69 + stIndex;
    minlat = 10;    maxlat = 20;
elseif(stIndex>4 & stIndex <= 11)
    stamp = 69 + stIndex;
    minlat = 15;    maxlat = 25;
elseif(stIndex>11 & stIndex <= 16)
    stamp = 69 + stIndex;
    minlat = 20;    maxlat = 30;
elseif(stIndex>16 & stIndex <= 23)
    stamp = 69 + stIndex;
    minlat = 25;    maxlat = 35;
else
    stamp = 69 + stIndex;
    minlat = 30;    maxlat = 40;
end


function [u0,u1,v0,v1,s0,s1,d0,d1,lat,lon,consum,inter,hyp] = timeInter(typeS,typeI,typeD,typeM,path,minlon,minlat,maxlon,maxlat,epoch,samp,stamp)
%% global variables
typeV_pca = 7;  % pca feature
u0 = [];   u1 = [];   consum1 = 0.0;    inter1 = 0.0;   hypu = [];%column vector
v0 = [];   v1 = [];   consum2 = 0.0;    inter2 = 0.0;   hypv = [];
s0 = [];   s1 = [];   consum3 = 0.0;    inter3 = 0.0;   hyps = [];
d0 = [];   d1 = [];   consum4 = 0.0;    inter4 = 0.0;   hypd = [];
lat = []; lon = [];

typeV = [1 2 6 3];  %u10,v10,s,d;aka typeV =1,2,6,3

%% make interpolation for u10,v10,s,d;aka typeV =1,2,6,3
prefix_p = [path getPrefixByType(typeS,typeI,typeV_pca,typeD)]; % pca
prefix_s = [path getPrefixByType(typeS,typeI,0,typeD)]; % others bariable type,both ok

switch(typeM)
    case 1 %pcareg_m_prod
        [u0 u1 x_lat x_lon consum1 inter1 hypu] = time_mult_pca_prod_nospar(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),epoch,samp,stamp);
        [v0 v1 x_lat x_lon consum2 inter2 hypv] = time_mult_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),epoch,samp,stamp);
%         [s0 s1 consum3 inter3] = reg_mat_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),epoch,samp);
%         [d0 d1 consum4 inter4] = reg_mat_pca_prod(prefix_p,prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),epoch,samp);
        disp('------------- mat pca prod done ----------------');
    case 2 %spline
        [u0 u1 x_lat x_lon consum1 inter1 hypu] = timesplineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(1),samp,stamp);
        [v0 v1 x_lat x_lon consum1 inter1 hypv] = timesplineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(2),samp,stamp);
%         [s0 s1 consum3 inter3] = splineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(3),samp);
%         [d0 d1 consum4 inter4] = splineInter(prefix_s,minlon,minlat,maxlon,maxlat,typeV(4),samp);
        disp('------------- spline done ----------------');    
end

consum = [consum1,consum2,consum3,consum4]';
inter = [inter1,inter2,inter3,inter4]';
hyp = {hypu,hypv,hyps,hypd};
lat = x_lat;
lon = x_lon;