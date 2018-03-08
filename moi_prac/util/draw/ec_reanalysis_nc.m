% Mapping for EC-reanalysis Wind Field
% Last update by DBH: 2017-04-17

clc
clear

% List the nc file.
% file_name_list=ls('ec-reanalysis-20160829*');

% Read data from the list
% nn=size(file_name_list);
% nn=nn(1);
file_name = '20140901-20140930-uv.nc'; 
pick_time = 26;
tic 

% Plot the data using surfm(or contourfm) and axesm.
f = figure('Name', 'EC_Wind_Speed', 'visible', 'on');

% for i=1:nn
    lat = ncread(file_name,'latitude');
    lon = ncread(file_name,'longitude');
    u = ncread(file_name,'u10');
    v = ncread(file_name,'v10');
%     p = ncread(file_name,'sp');
    
    n=size(lat);
    n=n(1);
    m=size(lon);
    m=m(1);
    lat_t=zeros(m,n);
    lon_t=zeros(m,n);
    for j=1:m
        for jj=1:n
            lat_t(j,jj)=double(lat(jj));
            lon_t(j,jj)=double(lon(j));
        end
    end      
        
    u=u(:,:,pick_time);
    v=v(:,:,pick_time);
%     p=p(:,:,3);
    d = 3
    subplot(121)
    worldmap([25 35],[125 135]);
%     quivermc(lat_t,lon_t,u,v,'density',70,'arrowstyle','divergent','colormap',jet,'units','m/s','colorbar','on','reference',20);
    quiverm(lon_t,lat_t,u,v,'blue',0.5);
    hold on;    
    
    subplot(122)
    m_proj('oblique','lat',[25 35],'lon',[125 135],'aspect',.8);
%     m_coast('patch',[.9 .9 .9],'edgecolor','none');
    m_grid('tickdir','out','yticklabels',[],...
           'xticklabels',[],'linestyle','none','ticklen',.02);
    hold on;
    d=3;
    m_quiver(lon_t(1:d:end,1:d:end),lat_t(1:d:end,1:d:end),u(1:d:end,1:d:end),v(1:d:end,1:d:end),3);
    hold on;
%     pp=mapminmax(p,0,255);
%     m_pcolor(lon_t,lat_t,pp);
%     shading flat;
%     colormap(jet);
    hold on;
%     [cs,h]=m_contour(lon_t,lat_t,sqrt(u.*u+v.*v));
    vv=80000:500:110000;
%     [cs,h]=m_contour(lon_t,lat_t,p,vv);
    clabel(cs,h,'fontsize',8);
% end
toc