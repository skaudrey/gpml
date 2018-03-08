

ru = []; rv = [];
su = []; sv = [];

basepath = [cd,'/','moi_prac','/','reuse','/','typhoon','/'];

prefix_s = {'Inter_seagull','Inter_fenggod','Inter_kamurri'};

reuse_suffix = '_reuse_p';
mat_suffix = '.mat';

for typ = 1:3
    temp  = load([basepath,prefix_s{typ},reuse_suffix,mat_suffix]);
    reg_size = size(temp.rmse,2);
    for i = 1:reg_size    
        ru = [ru,temp.rmse{i}(1,1)];
        rv = [rv,temp.rmse{i}(2,1)];
        su = [su,temp.rmse{i}(1,2)];
        sv = [sv,temp.rmse{i}(2,2)];    
    end
    clear rmse
end

mean_r = [mean(ru),mean(su);mean(rv),mean(sv)];

percent_r = [(mean_r(1,2)-mean_r(1,1))/mean_r(1,2)*100,(mean_r(2,2)-mean_r(2,1))/mean_r(2,2)*100];

disp('mean rmse mult u:')
disp(num2str(mean_r(1,1)));
disp('mean rmse spline u:')
disp(num2str(mean_r(1,2)));

disp('mean rmse mult v:')
disp(num2str(mean_r(2,1)));
disp('mean rmse spline v:')
disp(num2str(mean_r(2,2)));

