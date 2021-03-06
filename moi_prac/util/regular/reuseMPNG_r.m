function reuseMPNG_r()

hypu = {};hypv = {};
minlat = 0;minlon = 0;maxlat = 0;maxlon = 0;stamp = 0;

basepath = [cd,'/','moi_prac','/','reuse','/','typhoon','/'];

[hypu,hypv] = getMeanHyperOfMpng(1,1);    %get the mean hyper of phoenix,with method mult_pca_prod

close all;

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
normpath = [basepath '/moi_prac/reuse/normalday/mpng/'];
typpath = [basepath '/moi_prac/reuse/typhoon/'];
regPath = {normpath,typpath};

samp = 2;  % just for test
m0 = 1;m1 = 2;% the method index that will be tested,see function regionName 
epoch_size = 1;
% epoch = linspace(10,10*epoch_size,epoch_size)';
epoch  = [100];
hyper = {};
%% interpolation
  train_time = [];   inter_time = [];   rmse = {};  hyper = {};      ysu = {}; ysv = {}; x_test = {}; y_test = {}; x_train = {}; y_train = {};
for stIndex = 1:39   %set region
    u_temp = []; v_temp = []; su_temp = []; sv_temp = [];  ysu_temp = []; ysv_temp = [];   xtest_temp = {};    ytest_temp = {};    xtrain_temp = {};   ytrain_temp = {};
    [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofMPNG(stIndex,4);
%     minlon = 0;maxlon = 10;minlat = 20;maxlat = 30;
    reg_explain = {[ num2str(120+minlon) 'E'],...
    [ num2str(120+maxlon) 'E'],...
    [ num2str(minlat) 'N'],...
    [ num2str(maxlat) 'N'],...
    'the resolution of interpolation result is 0.25'};
    typeD =1;
%     for typeD = 2:-1:1     %set datatype,
        % change path of file 
        path = regPath{typeD};
        %reset for another dataset
        index = 1;
       rmse_temp = []; 
        % do intrtpolation method by method
        for epoch_index = 1:epoch_size
            
            for typeM = m0:m1   % see function regionName
                ep = epoch(epoch_index);
                % dataset
                 [u0 u1 v0 v1 s0 s1 d0 d1 consum inter ysut ysvt xtemp ytemp xtrmp ytrmp] = ...
                    reuseMultInter_r(typeS,typeI,typeD,typeM,path,minlon,minlat,maxlon,maxlat,ep,samp,stamp,hypu,hypv);
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
                ysu_temp{index} = ysut;
                ysv_temp{index} = ysvt;
                xtest_temp{index-1} = xtemp;
                ytest_temp{index-1} = ytemp;
                xtrain_temp{index-1} = xtrmp;
                ytrain_temp{index-1} = ytrmp;
%                 %hyp
%                 if(typeM~=2)
%                     hyper{stIndex} = hyp;
%                 end

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
        end
        rmse{stIndex} = rmse_temp;
        u{stIndex} = u_temp;
        v{stIndex} = v_temp;
        su{stIndex} = su_temp;
        sv{stIndex} = sv_temp;
        ysu{stIndex} = ysu_temp;
        ysv{stIndex} = ysv_temp;
        x_test{stIndex} = xtest_temp;
        y_test{stIndex} = ytest_temp;
        x_train{stIndex} = xtrain_temp;
        y_train{stIndex} = ytrain_temp;
end
         % save file,show result
%         region = regionName(0,typeI,0,typeD,minlon,maxlon,minlat,maxlat);        
        filename = strcat(path,'Inter_mpng_reuse_s_timeall_r','.mat');    
        save(filename,'u','v','ysu','ysv','x_test','y_test','x_train','y_train','su','sv','rmse','train_time','inter_time','rmse_explain','data_explain','var_explain','reg_explain','time_explain','stamp_explain','epoch_explain');
%     end
       
% end
