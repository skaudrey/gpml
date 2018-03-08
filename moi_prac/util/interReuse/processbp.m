% process BP interpolation and the other method

basepath = 'D:\Code\Matlab\gpml\moi_prac\reuse\typhoon\seagull\';

file2 = 'Inter_seagull_bp_all.mat';
file1 = 'Inter_seagull_reuse_p_smds.mat';

reusep = load([basepath file1]);
bp = load([basepath file2]);

size_u = size(reusep.u,2);

rmse  = {};
u = {};
v = {};
for i = 1:size_u
    rmse{i} = [reusep.rmse{i},bp.rmse(:,i)];
    
    u{i} = [reusep.u{1,i}(1),reusep.u{1,i}(2),reusep.u{1,i}(3),bp.u{i}];
    v{i} = [reusep.v{1,i}(1),reusep.v{1,i}(2),reusep.v{1,i}(3),bp.v{i}];    
end

su = reusep.su;
sv = reusep.sv;
train_time =  reusep.train_time;
inter_time = reusep.inter_time;
rmse_explain = reusep.rmse_explain;
data_explain = reusep.data_explain;
var_explain = reusep.var_explain;
reg_explain = reusep.reg_explain;
time_explain = reusep.time_explain;
stamp_explain = reusep.stamp_explain;
epoch_explain = reusep.epoch_explain;
lat_map = reusep.lat_map;
lon_map = reusep.lon_map;

save([basepath file1],'u','v','lat_map','lon_map','su','sv','rmse','train_time','inter_time','rmse_explain','data_explain','var_explain','reg_explain','time_explain','stamp_explain','epoch_explain');
