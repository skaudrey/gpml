%save ration for the interfile
clear all
basepath = [cd,'/','moi_prac','/','reuse','/','typhoon','/'];
filename = {'Inter_phoenix.mat','Inter_fenggod.mat','Inter_seagull.mat','Inter_kamurri.mat'};


p_ratio1 = [0.83239123,0.83072399,0.81857869,0.85153061];
p_ratio2 = [0.83596893,0.83324471,0.88140058,0.8924528,0.89180175,0.89258545,0.84118419];
p_ratio3 = [0.90158469,0.85307308,0.88974258,0.84763272,0.88609591];
p_ratio4 = [0.97744742,0.97247414,0.94495499,0.92828773,0.89520446,0.83952361,0.75798581];
p_ratio5 = [0.90425945,0.96812299,0.98545066];
p_ratio = [p_ratio1,p_ratio2,p_ratio3,p_ratio4,p_ratio5];

s_ratio = [0.58979278,0.65500247,0.76713108,0.82271515,0.89569434,0.92454151,0.90894375,0.89063204];

k_ratio = [0.88431701,0.89728531,0.8410914,0.82628972,0.84031091,0.92143132,...
    0.94600955,0.94523867,0.9394155,0.95005733,0.95038975,0.95419711,0.98111056...
    0.95486385,0.95294824,0.96284238];

f_ratio = [0.84674051,0.90973302,0.94199151,0.97928783,0.96669582,0.92713477...
    0.93416036,0.9500673,0.98040174,0.96180457,0.97489566,0.93674316,...
    0.97733408,0.98085404,0.99167567,0.98769539];


tID = 1;    ratio = [];
switch tID
    case 1
        ratio = p_ratio;
    case 2
        ratio = f_ratio;
    case 3
        ratio = s_ratio;
    case 4
        ratio = k_ratio;
end

load([basepath,filename{tID}]);

save([basepath,filename{tID}],'ratio','u','v','su','sv','rmse','train_time','inter_time','hyper','rmse_explain','data_explain','var_explain','reg_explain','time_explain','stamp_explain','epoch_explain');


       