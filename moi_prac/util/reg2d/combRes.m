% combine the mp file and other file
basepath  = 'D:\Code\Matlab\gpml\moi_prac\normalday\';
filename1 = 'Inter_s_LON0-10LAT40-30.mat';
filename2 = 'Inter_s_LON0-10LAT40-30pcm.mat';

mp = load([basepath,filename2]);
 
u_temp  = {};  v_temp ={} ;    su_temp = {};   sv_temp = {};   
inter_temp = [];    train_temp = [];


load([basepath,filename1]);

m_size = 12
epoch_size = 4;
mpm_size = 2;
raw_size = 10;
%rmse
for i = 1:epoch_size
    rmse{i} = [rmse{i},mp.rmse{i}];
end
%u,v,su,sv
u_temp{1} = u{1};
v_temp{1} = v{1};
su_temp{1} = su{1};
sv_temp{1} = sv{1};
for ep = 1:epoch_size
    for i = 1:12
        temp_index = (ep-1)*m_size+i+1; % skip the origin
        if(i <= raw_size)
            index = (ep-1)*raw_size+i+1;    %skip the origin
            u_temp{temp_index} = u{index};
            v_temp{temp_index} = v{index};
            su_temp{temp_index} = su{index};
            sv_temp{temp_index} = sv{index};
        else
            index = (ep-1)*mpm_size+i-raw_size;           
            u_temp{temp_index} = mp.u{index};
            v_temp{temp_index} = mp.v{index};
            su_temp{temp_index} = mp.su{index};
            sv_temp{temp_index} = mp.sv{index};
        end
    end
end

clear u v su sv
u = u_temp;v = v_temp;su = su_temp;sv = sv_temp;


% train time and inter time
for ep = 1:epoch_size
    for i = 1:12
        temp_index = (ep-1)*m_size+i; 
        if(i <= raw_size)
            index = (ep-1)*raw_size+i;    
            inter_temp = [inter_temp,inter_time(:,index)];
            train_temp = [train_temp,train_time(:,index)];
        else
            index = (ep-1)*mpm_size+i-raw_size;           
            inter_temp = [inter_temp,mp.inter_time(:,index)];
            train_temp = [train_temp,mp.train_time(:,index)];
        end
    end
end
clear inter_time train_time
inter_time = inter_temp;
train_time = train_temp;

save([basepath,filename1],'u','v','su','sv','rmse','train_time','inter_time','rmse_explain','data_explain','var_explain','reg_explain','time_explain','stamp_explain','epoch_explain');
