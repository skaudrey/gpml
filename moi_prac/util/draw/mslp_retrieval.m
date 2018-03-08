% Use the trainned network to get new mslp filed
% The 'net' is come from the program 'nn_mwts_speed'

% Tested under: MATLAB R2016b
% Last updated by DBH: 2017-10-30

clc;
clear;

%  List the HDF files.
MWXS_file 	= ls('../mwts/FY3C_MWTSX_GBAL_L1_20140916_*.HDF');
nn 			= size(MWXS_file);
nn 			= nn(1);

% ECMWF wind file
Pressure_file 	= '20140901-20140930-sst-mslp-swh.nc';
Wind_file       = '20140901-20140930-uv.nc';

% Read ECMWF wind file
lat_ec 		= ncread(Pressure_file,'latitude');
lon_ec 		= ncread(Pressure_file,'longitude');
time_ec 	= ncread(Pressure_file,'time');
mslp_ec 	= ncread(Pressure_file,'msl');
sst_ec      = ncread(Pressure_file,'sst');
u_ec 		= ncread(Wind_file,'u10');
v_ec 		= ncread(Wind_file,'v10');

[row,column,num_t]	= size(mslp_ec);

% Mean sea level pressure
speed_ec 			= mslp_ec/100;

% % Sea surface temparature
% speed_ec 			= sst_ec;

% Boundary
lat_d=min(min(lat_ec));
lat_t=max(max(lat_ec));
lon_l=min(min(lon_ec));
lon_r=max(max(lon_ec));

lat_2=zeros(row,column);
lon_2=zeros(row,column);
for j=1:row
    for jj=1:column
        lat_2(j,jj)=double(lat_ec(jj));
        lon_2(j,jj)=double(lon_ec(j));
    end
end 

% cd ..
% cd mwts
    
% load the network
% load mwts_mslp_net.mat;
% load train_set;
% load target_set;

% translate time into standard format
initial_time 	= 20140901;
time_ec 		= (int32(floor(double(time_ec-time_ec(1))/24))+initial_time)*100+mod((time_ec-time_ec(1)),24);

for i=1:nn
	tic
    
    cd ..
    cd mwts

	x_lat       = hdf5read(MWXS_file(i,:),'Geolocation/Latitude');
	x_lon       = hdf5read(MWXS_file(i,:),'Geolocation/Longitude');
	bt          = hdf5read(MWXS_file(i,:),'Data/Earth_Obs_BT');
    lsm         = hdf5read(MWXS_file(i,:),'Geolocation/LandSeaMask');

	[row_mwts,column_mwts,channels]=size(bt);
	x_mslp		= zeros(row_mwts,column_mwts);
	flag 		= zeros(row_mwts,column_mwts);
    x_speed		= zeros(row_mwts,column_mwts);
    
    u_ref		= zeros(row_mwts,column_mwts);
    v_ref		= zeros(row_mwts,column_mwts);
    u_ret		= zeros(row_mwts,column_mwts);
    v_ret		= zeros(row_mwts,column_mwts);
    
    % Convert the data to double type for plot.
	bt          = double(bt);
	x_lon       = double(x_lon);
	x_lat       = double(x_lat);
    lsm         = double(lsm);
    
    % time of current file
    current_file	= MWXS_file(i,:)
	t 				= int32(str2double(current_file(20:27))*100)+int32(str2double(current_file(29:30)));
	t 				= int32(t);
	save_filename  	= cat(2,num2str(t),'_mslp_retrieval.dat')

	% Replace the fill value with NaN.
	bt( bt <= 0)            = 0;
	x_lat( x_lat == 0)      = NaN;
	x_lon( x_lon == 0)      = NaN;
    
    for ii=1:row_mwts
        for jj=1:column_mwts
            if(lsm(ii,jj) == 3)
                if(~isnan(x_lat(ii,jj)) && ~isnan(x_lon(ii,jj)))
                    training_data = bt(ii,jj,:);
                    training_data = training_data(:);
    %                 inputs = (training_data-train_set.xmin)/(train_set.xmax-train_set.xmin);
                    inputs = mapminmax.apply(training_data,train_set);
    %                 inputs = inputs'
                    outputs = net(inputs);             
                    x_mslp(ii,jj) = mapminmax.reverse(outputs,target_set);
                    clear inputs outputs
                end
            end
        end
    end
    
    % smooth the retrieval field for 3 times
%     for ii=1:3
%         h = fspecial('disk', 3);
%         x_mslp = imfilter(x_mslp,h);
%     end
    iter=1;
    while(iter<=5)
        for ii=2:row_mwts-1
            for jj=2:column_mwts-1
                if(x_mslp(ii,jj)~=0 && x_mslp(ii-1,jj)~=0 && x_mslp(ii+1,jj)~=0 &&...
                        x_mslp(ii,jj-1)~=0 && x_mslp(ii,jj+1)~=0)
    %                 sum_mslp = 0;
                    sum_mslp = x_mslp(ii,jj)+x_mslp(ii+1,jj)+x_mslp(ii-1,jj)+...
                        x_mslp(ii,jj+1)+x_mslp(ii,jj-1);
    %                 for m=-1:1
    %                     for n=-1:1
    %                         sum_mslp=x_mslp(ii+m,jj+n)+sum_mslp;
    %                     end
    %                 end 
                    x_mslp(ii,jj) = sum_mslp/5;
                end
            end
        end
        iter=iter+1;
    end
    
    for j=1:num_t
        if(abs(t-time_ec(j))<=1)
            if_matched 	= 0;	
            num_matched = 0;			

            % Match location
            for ii=1:row_mwts
                for jj=1:column_mwts
                    % if is in sea lsm = 3
                    if(lsm(ii,jj) == 3)
                        % if in box
                        if(x_lat(ii,jj)>lat_d && x_lat(ii,jj)<lat_t && ...
                            x_lon(ii,jj)>lon_l && x_lon(ii,jj)<lon_r)
                            for krow=1:row-1
                                if(lon_2(krow,1)<x_lon(ii,jj) && lon_2(krow+1,1)>=x_lon(ii,jj))
                                    for kcell=1:column-1 
                                        if(lat_2(1,kcell)>x_lat(ii,jj) && lat_2(1,kcell+1)<=x_lat(ii,jj))
                                            x_speed(ii,jj) 	= speed_ec(krow,kcell,j);
                                            u_ref(ii,jj) 	= u_ec(krow,kcell,j);
                                            v_ref(ii,jj) 	= v_ec(krow,kcell,j);
                                            flag(ii,jj) 	= 1;
                                            num_matched 	= num_matched+1;
                                            break;
                                        end
                                    end
                                    if(flag(ii,jj)==1)
                                        if_matched = 1;
                                        break;
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            num_matched
            if(num_matched>500)
                % Set the figure
                f = figure('Name',num2str(t), 'visible', 'off');

                subplot(221)
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
                          'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[0 60],...
                          'MapLonLimit',[120 180],'PLineLocation',15,'MLineLocation',15,...
                          'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
                coast = load('coast.mat');
                hold on; 
                tightmap
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
                % surfm is faster than contourfm.
                x_mslp( flag == 0) = NaN;    
                surfm(x_lat,x_lon,x_mslp);
                hold on;
                
                geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
                colormap('Jet');
            % 				    caxis([0,25]) % change caxis                

                % Put colorbar.
                h=colorbar('v');
                set(get(h,'ylabel'),'string','MSLP-Retr', 'FontSize', 10);

                % Set unit's title.
                units='hPa';
                set(get(h, 'title'), 'string', units, ...
                                  'FontSize', 10, 'FontWeight','normal', ...
                                  'Interpreter', 'none');
                hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                subplot(222)
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
                          'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[0 60],...
                          'MapLonLimit',[120 180],'PLineLocation',15,'MLineLocation',15,...
                          'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
                coast = load('coast.mat');
                hold on; 
                tightmap
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
                % surfm is faster than contourfm.
                x_speed( x_speed == 0) = NaN;    
                surfm(x_lat,x_lon,x_speed); 
                hold on;

                geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
                colormap('Jet');
            % 				    caxis([180,350]) % change caxis
                
                % Put colorbar.
                h=colorbar('v');
                set(get(h,'ylabel'),'string','MSLP-Refe', 'FontSize', 10);

                % Set unit's title.
                units='hPa';
                set(get(h, 'title'), 'string', units, ...
                                  'FontSize', 10, 'FontWeight','normal', ...
                                  'Interpreter', 'none');
                hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Using UWPBL model to retrieve wind field
                Bad = -999.99;
                x_mslp( flag == 0) = 0;
                disp('Wind Retrieval')
                [x_lat,x_lon,x_mslp,u_ret,v_ret] = fbwind(x_lat,x_lon,x_mslp,u_ret,v_ret);
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                 subplot(223)
                 axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
                          'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[0 60],...
                          'MapLonLimit',[120 180],'PLineLocation',15,'MLineLocation',15,...
                          'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
                 coast = load('coast.mat');
                 hold on; 
                 tightmap

                 u_ret(u_ret==Bad)=NaN;
                 v_ret(v_ret==Bad)=NaN;                 
                 u_ret( flag == 0)   = NaN;
                 v_ret( flag == 0)   = NaN;
                 spd = sqrt(u_ret.^2+v_ret.^2);              
                 
%                  spd( flag == 0)     = NaN;
                 
                 d=1;
                 surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end));
                % surfm(xlat(1:d:end,1:d:end),xlon(1:d:end,1:d:end),pgrd(1:d:end,1:d:end));

                 d=10;
%                  quiverm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),-u_ret(1:d:end,1:d:end),v_ret(1:d:end,1:d:end),'blue',0.5);
                 hold on;

                 geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
                 % Put colorbar.
                 colormap('Jet');
                %  caxis([0,35]) % change caxis
                 h=colorbar('v');
                 set(get(h,'ylabel'),'string','Spd', 'FontSize', 10);
                 % Set unit's title.
                 units='m/s';
                 set(get(h, 'title'), 'string', units, ...
                                  'FontSize', 10, 'FontWeight','normal', ...
                                  'Interpreter', 'none');
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(224)
                 axesm('MapProjection','eqdcylin','Frame','on','Grid','on',...
                          'MeridianLabel','on','ParallelLabel','on','MapLatLimit',[0 60],...
                          'MapLonLimit',[120 180],'PLineLocation',15,'MLineLocation',15,...
                          'GLineWidth',1.0,'FontSize', 10,'MLabelParallel','south','FLineWidth',1.0);
                 coast = load('coast.mat');
                 hold on; 
                 tightmap
                 u = u_ref;
                 v = v_ref;
                 spd = sqrt(u.^2+v.^2);
                 
                 u( flag == 0)   = NaN;
                 v( flag == 0)   = NaN;
                 spd( flag == 0) = NaN;
                 
                 d=1;
                 surfm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),spd(1:d:end,1:d:end));
                 d = 10; 
%                  quiverm(x_lat(1:d:end,1:d:end),x_lon(1:d:end,1:d:end),u(1:d:end,1:d:end),v(1:d:end,1:d:end),'blue',0.5);
                 hold on;

                 geoshow(coast.lat,coast.long,'DisplayType','polygon','FaceColor', [0.7 0.7 0.7]);
                 % Put colorbar.
                 colormap('Jet');
                %  caxis([0,35]) % change caxis
                 h=colorbar('v');
                 set(get(h,'ylabel'),'string','Spd', 'FontSize', 10);
                 % Set unit's title.
                 units='m/s';
                 set(get(h, 'title'), 'string', units, ...
                                  'FontSize', 10, 'FontWeight','normal', ...
                                  'Interpreter', 'none');
                 hold on;
                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                 
                

                % Save the figure as JPEG image.
                save_filename=cat(2,save_filename,'.jpg');
                saveas(f,save_filename);
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                x_mslp = x_mslp(:);
                x_speed = x_speed(:);
                flag = flag(:);
                x_mslp( flag == 0) = [];
                x_speed(  flag == 0) = [];
                errors = gsubtract(x_speed,x_mslp);
                mean_error=mean(errors)
                std_error=sqrt(var(errors))
                figure(1), plotregression(x_speed,x_mslp)
                figure(2), ploterrhist(errors)
            end

            break;
        end
    end
    
    toc
end