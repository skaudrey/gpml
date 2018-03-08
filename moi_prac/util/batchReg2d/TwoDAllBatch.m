%% region all method compare
function TwoDAllBatch(minlon,maxlon,minlat,maxlat,samp,sub_row,sub_col)
% epoch = [30 30 50 50 40 40 40];
%% global variables
close all;
% ATTENTION: the first column of x is longitude and the 2nd is latitude

% attention: only when the grid is even can you pick the match grid
% minlon = 0;%120'E
% maxlon = 15.125;% 135.125'E
% minlat = 20;% 20'N
% maxlat = 40.125;% 40.125'N
resolution = 0.125; % for EC data,the resolution is 0.75'

typeS = 5;
typeI = 1;  % the interpolation data set type ,see in getPrefixByType,1 for space interpolation 2 for time interpolation
%need to be saved
u = {}; v = {}; su = {}; sv = {}; train_time = []; inter_time = []; rmse = [];hyper = {};
rmse_explain = {'every cell of rmse is one cell of one specific epoch','mat','mpng','pcareg_m_sum','pcareg_m_prod','pcareg_mpng_prod','pcareg_mpng_sum','spline','mp','mpPcaProd','mpPcaSum'};
data_explain = {'orgin','mat','mpng','pcareg_m_sum','pcareg_m_prod','pcareg_mpng_prod','pcareg_mpng_sum','spline'};
var_explain = {'u for u10 interpolation','v for v10 interpolation','su for recalculated u10','sv for recalculated v10'};
reg_explain = {[ num2str(120+minlon) 'E'],...
    [ num2str(120+maxlon) 'E'],...
    [ num2str(minlat) 'N'],...
    [ num2str(maxlat) 'N'],...
    'the resolution of interpolation result is 0.25'};
time_explain = {'every columns is the interpolation or train time of variable u10,v10,s,d'};
stamp_explain = {'timestamp is 21,means 2014090600 for normal day',...
    'timestamp 83,means 201409211200 for 20.625N--24.25N for typhoon',...
    'timestamp 84,means 201409211800 for 21.625N--25.25N for typhoon',...
    'timestamp 85,means 201409220000 for 23.625N--27.25N for typhoon'};
epoch_explain = {'epoch is 100'};
basepath = cd;
normpath = [basepath '/moi_prac/reuse/normalday/'];
typpath = [basepath '/moi_prac/typhoon/'];
regPath = {normpath,typpath};
epoch_size = 1;
% epoch = linspace(10,10*epoch_size,epoch_size)';
epoch = [100];
m0 = 18;m1 = 27;% the method index that will be tested,see function regionName 
% sub_row = 1;
% sub_col = 61;    % the region now is 162*122,sub for 9 rows and 2 cols means 9*2 subregions,the size of subregion is 18*61
%% interpolation
typeD = 1;
% for typeD = 1:2
    % change path of file 
    path = regPath{typeD};
    %reset for another dataset
    index = 1;
    u = {}; v = {}; su = {}; sv = {}; train_time = []; inter_time = []; rmse = {};hyper = {};
    % do intrtpolation method by method
    for epoch_index = 1:epoch_size
        rmse_temp = []; 
        for typeM = m0:m1   % see function regionName

            % dataset
            ep = epoch(epoch_index);
            [u0 u1 v0 v1 s0 s1 d0 d1 consum inter hyp] = ...
                regInterBatch(typeS,typeI,typeD,typeM,path,minlon,minlat,maxlon,maxlat,ep,samp,sub_row,sub_col);
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
            hyper{index} = hyp;

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
    sub_suffix = ['subrow' num2str(sub_row) 'col' num2str(sub_col)];
   
    filename = strcat(path,region,sub_suffix,'.mat');    
    save(filename,'u','v','su','sv','rmse','train_time','inter_time','hyper','rmse_explain','data_explain','var_explain','reg_explain','time_explain','stamp_explain','epoch_explain');
% end
