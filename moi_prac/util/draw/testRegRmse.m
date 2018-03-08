%test region rmse
%% global variables
% close all
clear all
basepath = cd;
normpath = [basepath '/moi_prac/normalday/'];
typpath = [basepath '/moi_prac/typhoon/'];
regPath = {normpath,typpath};



%% normal day small region without crossing the wind belts,suitable for mat_pca
typeD = 1;

filename1 = 'Inter_s_LON0-10LAT20-30.mat';
filename2 = 'Inter_s_LON0-10LAT40-30.mat';

reg1 = load([regPath{typeD},filename1]); 
reg2 = load([regPath{typeD},filename2]); 

reg_rmse = {};
reg_rmse{1} = reg1.rmse{4}; % 4 for epoch 100
reg_rmse{2} = reg2.rmse{3};

allRMSE(reg_rmse,1,12,1);


%% normal day region,cross the wind belts
typeD = 1;

filename1 = 'Inter_s_LON0-1.75LAT60-0.mat';
filename2 = 'Inter_s_LON0-5LAT40-20.mat';
% filename4 = 'Inter_s_LON0-10LAT40-30.mat';

reg1 = load([regPath{typeD},filename1]);    % 4 for epoch 100
reg2 = load([regPath{typeD},filename2]); 
% reg4 = load([regPath{typeD},filename4]); 

reg_rmse = {};
reg_rmse{1} = reg1.rmse{4};
reg_rmse{2} = reg2.rmse{4};
% reg_rmse{4} = reg4.rmse{4};

allRMSE(reg_rmse,1,12,1);



%% typeD  =  2,typhoon day small region without crossing the wind belts

typeD = 2;

filename1 = 'Inter_s_LON0-4LAT20-25.mat';
filename2 = 'Inter_s_LON0-4LAT21-25.mat';
filename3 = 'Inter_s_LON0-4LAT23-27.mat';
% filename4 = 'Inter_s_LON0-10LAT20-30.mat';

reg1 = load([regPath{typeD},filename1]);    % 4 for epoch 100
reg2 = load([regPath{typeD},filename2]); 
reg3 = load([regPath{typeD},filename3]); 
% reg4 = load([regPath{typeD},filename4]); 

reg_rmse = {};
reg_rmse{1} = reg1.rmse{4};
reg_rmse{2} = reg2.rmse{4};
reg_rmse{3} = reg3.rmse{4};
% reg_rmse{4} = reg4.rmse{4};

allRMSE(reg_rmse,1,12,5);

