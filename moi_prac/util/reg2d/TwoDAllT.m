%% region all method compare
function TwoDAll(samp)
%% global variables
close all;
% ATTENTION: the first column of x is longitude and the 2nd is latitude

% attention: only when the grid is even can you pick the match grid
minlon=0.0;minlat = 0.0;maxlon = 0.0;maxlat = 0.0;
resolution = 0.125; % for EC data,the resolution is 0.75'

typeS = 5;
typeI = 1;  % the interpolation data set type ,see in getPrefixByType,1 for space interpolation 2 for time interpolation
%need to be saved
u = []; v = []; su = []; sv = []; train_time = []; inter_time = []; rmse = {};  hyper = {};
rmse_explain = {'every cell of rmse is one cell of one specific epoch','mat','mpng','pcareg_m_sum','pcareg_m_prod','pcareg_mpng_prod','pcareg_mpng_sum','spline'};
data_explain = {'orgin','mat','mpng','pcareg_m_sum','pcareg_m_prod','pcareg_mpng_prod','pcareg_mpng_sum','spline'};
var_explain = {'u for u10 interpolation','v for v10 interpolation','su for recalculated u10','sv for recalculated v10'};
reg_explain = {};
time_explain = {'every columns is the interpolation or train time of variable u10,v10,s,d'};
stamp_explain = {'timestamp is 21,means 2014090600 for normal day',...    
    'timestamp 55,means 201409141200 for 10N--20N for typhoon sea gull'};
epoch_explain = {'epoch are 20,50,80,100'};

basepath = cd;
normpath = [basepath '/moi_prac/normalday/'];
typpath = [basepath '/moi_prac/typhoon/'];
regPath = {normpath,typpath};

% epoch = 30; % need to be tested
% samp = 2;  % just for test
m0 = 18;m1 = 29;% the method index that will be tested,see function regionName 
epoch_size = 4;
% epoch = linspace(10,10*epoch_size,epoch_size)';
epoch  = [20,50,80,100];
%% interpolation
% for stamp = 83:85   %set region
%     [minlon,maxlon,minlat,maxlat] = getRegByStamp(stamp);
    minlon = 0;maxlon = 10;minlat = 10;maxlat = 20;
    reg_explain = {[ num2str(120+minlon) 'E'],...
    [ num2str(120+maxlon) 'E'],...
    [ num2str(minlat) 'N'],...
    [ num2str(maxlat) 'N'],...
    'the resolution of interpolation result is 0.25'};
%     typeD =1;
    for typeD = 2:-1:1     %set datatype,
        % change path of file 
        path = regPath{typeD};
        %reset for another dataset
        index = 1;
        u = []; v = []; su = []; sv = []; train_time = [];   inter_time = [];   rmse = {};  hyper = {};
        % do intrtpolation method by method
        for epoch_index = 1:epoch_size
            rmse_temp = []; 
            for typeM = m0:m1   % see function regionName
                ep = epoch(epoch_index);
                % dataset
                [u0 u1 v0 v1 s0 s1 d0 d1 consum inter hyp] = ...
                    regInter(typeS,typeI,typeD,typeM,path,minlon,minlat,maxlon,maxlat,ep,samp);
                [su0 sv0] = CalUVFromSpeed(s0,d0);
                [su1 sv1] = CalUVFromSpeed(s1,d1);
                if(index ==1)   % save origin as the first cell
                    u{index} = u0;
                    v{index} = v0;             
                    su{index} = su0;
                    sv{index} = sv0;
                    index = index + 1;              
                end
                u{index} = u1;
                v{index} = v1;        
                su{index} = su1;
                sv{index} = sv1; 
                
                %hyp
                hyper{index-1} = hyp;

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
           rmse{epoch_index} = rmse_temp;
        end
         % save file,show result
        region = regionName(0,typeI,0,typeD,minlon,maxlon,minlat,maxlat);        
        filename = strcat(path,region,'.mat');    
        save(filename,'u','v','su','sv','rmse','train_time','inter_time','hyper','rmse_explain','data_explain','var_explain','reg_explain','time_explain','stamp_explain','epoch_explain');
    end
       
% end
