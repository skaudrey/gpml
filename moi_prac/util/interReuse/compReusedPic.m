% show pictures of reused interpolated picture and raw interpolated method
% and origin figure
function compReusedPic()
close all
basepath = [cd,'/','moi_prac','/','reuse','/','typhoon','/fenggod/'];

prefix_s = 'Inter_fenggod';

reuse_suffix = '_reuse_p_smds';
mat_suffix = '.mat';
annot = {'true','reuse','primal'};
re_Inter = load([basepath,prefix_s,reuse_suffix,mat_suffix]);
raw_Inter = load([basepath,prefix_s,mat_suffix]);

reg_size = size(re_Inter.rmse,2);

for i =1:reg_size
    [minlon,maxlon,minlat,maxlat,stamp] = getStampRegofFengGod(i);
    minlon = 120+minlon;    maxlon = 120+maxlon;
    regminLat = minlat;     regmaxlat = maxlat;
    regminlon = minlon;	regmaxlon = maxlon;
    
    u0 = re_Inter.u{i}{1};
    reuse_u = re_Inter.u{i}{2};
    raw_u = raw_Inter.u{i}{2};
    v0 = re_Inter.v{i}{1};
    reuse_v = re_Inter.v{i}{2};
    raw_v = raw_Inter.v{i}{2};
    
    
    u_draw = {u0,reuse_u,raw_u};
    v_draw = {v0,reuse_v,raw_v};
    
    
    index = 2;
    offflag = 0;
    spIndex = 3;
    colorMax = 0;
    mapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,colorMax,spIndex,annot);
%     diffMapDraw(minlat,minlon,maxlat,maxlon,u_draw,v_draw,regminLat,regminlon,regmaxlat,regmaxlon,offflag,index,0,spIndex,annot);

end