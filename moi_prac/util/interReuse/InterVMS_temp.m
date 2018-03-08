%% region all method compare
function InterVMS_temp()
%% global variables
close all;
% ATTENTION: the first column of x is longitude and the 2nd is latitude

% attention: only when the grid is even can you pick the match grid
minlon=0.0;minlat = 0.0;maxlon = 0.0;maxlat = 0.0;
resolution = 0.125; % for EC data,the resolution is 0.75'

typeS = 5;
typeI = 1;  % the interpolation data set type ,see in getPrefixByType,1 for space interpolation 2 for time interpolation
%need to be saved
typeP =1;   %pca file start with longitude
u_temp = []; v_temp = []; su_temp = []; sv = []; train_time = []; inter_time = []; rmse = {};
rmse_explain = {'every cell of rmse is one cell of one specific epoch','mat','mpng','pcareg_m_sum','pcareg_m_prod','pcareg_mpng_prod','pcareg_mpng_sum','spline'};
data_explain = {'orgin','mat','mpng','pcareg_m_sum','pcareg_m_prod','pcareg_mpng_prod','pcareg_mpng_sum','spline'};
var_explain = {'u for u10 interpolation','v for v10 interpolation','su for recalculated u10','sv for recalculated v10'};
reg_explain = {};
time_explain = {'every columns is the interpolation or train time of variable u10,v10,s,d'};
stamp_explain = {'different timestamp for typhoon phoenix'};
epoch_explain = {'epoch are 100'};

basepath = cd;
normpath1 = [basepath '/moi_prac/reuse/normalday/vms/space/time']; % space interpolation path
normpath2 = [basepath '/moi_prac/reuse/normalday/vms/time/reg']; % time interpolation path
regPath = {normpath1,normpath2};

% epoch = 30; % need to be tested
samp = 2;  % just for test
m0 = 1;m1 = 2;% the method index that will be tested,see function regionName 
epoch  = 100;
hyper = {};
spec_path = {'space','space_smd','time','time_smd'};
%% interpolation
  train_time = [];   inter_time = [];   rmse = {};  hyper = {};
  out_index = 1;
 for typeD = 3:3 % space interpolation, space interpolation with smd feature, time interpolation, time inmterpoaltion with smd
  train_time = [];   inter_time = [];   rmse = {};  hyper = {}; lat_map = []; lon_map = [];
  out_index = 1;    
%   regmax = 0;
     if(typeD <= 2)
         stEnd = 10;batchsize = 12; 
     else
         stEnd = 30;batchsize = 5;      
     end
%      regmax = reg_max(typeD);
%      regions = randi(regmax,1,stEnd);   % pick the batches randomly
%   for batchIndex = 1:batchsize
    for batchIndex = 1:batchsize
     switch(typeD)
          case 1     
              path = regPath{1};
              path = [path num2str(3+batchIndex) '/'];
          case 2             
              path = regPath{1};
              path = [path num2str(3+batchIndex) '/smd/'];
          case 3
              path = regPath{2};
              path = [path num2str(batchIndex) '/'];
          case 4
              path = regPath{2};
              path = [path num2str(batchIndex) '/smd/'];
     end
    
    
    for stIndex = 1:stEnd   %set region
        u_temp = []; v_temp = []; su_temp = []; sv_temp = [];
        [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofVMS(stIndex,typeD,batchIndex);
    %     minlon = 0;maxlon = 10;minlat = 20;maxlat = 30;
        reg_explain = {[ num2str(120+minlon) 'E'],...
        [ num2str(120+maxlon) 'E'],...
        [ num2str(minlat) 'N'],...
        [ num2str(maxlat) 'N'],...
        'the resolution of interpolation result is 0.25'};
     
    %     for typeD = 2:-1:1     %set datatype,
            % change path of file 
%             path = regPath{typeD};
            %reset for another dataset
            index = 1;
           rmse_temp = []; 
            % do intrtpolation method by method
            for typeM = m0:m1   % see function regionName
                    
                    % dataset
                    [u0 u1 v0 v1 s0 s1 d0 d1 lat lon consum inter hyp] = ...
                        vmsInter(typeS,typeI,typeP,typeM,path,minlon,minlat,maxlon,maxlat,epoch,samp,stamp);
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
                        hyper{out_index} = hyp;
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
          
             rmse{out_index} = rmse_temp;
            u{out_index} = u_temp;
            v{out_index} = v_temp;
            su{out_index} = su_temp;
            sv{out_index} = sv_temp;
            out_index = out_index+1;

    end
  end
         % save file,show result
%         region = regionName(0,typeI,0,typeD,minlon,maxlon,minlat,maxlat);        
          filename = strcat(path,'Inter_vms_',spec_path(typeD),'.mat');    
        save(filename{1},'u','v','su','sv','rmse','lat_map','lon_map','train_time','inter_time','hyper','rmse_explain','data_explain','var_explain','reg_explain','time_explain','stamp_explain','epoch_explain');
%     end
       
end