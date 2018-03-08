% startup script to make Octave/Matlab aware of the GPML package
%
% Copyright (c) by Carl Edward Rasmussen and Hannes Nickisch 2016-10-16.
% Make sure the subfolders are loaded

disp(['executing gpml startup script...']);

OCT = exist('OCTAVE_VERSION') ~= 0;           % check if we run Matlab or Octave

me = mfilename;                                            % what is my filename
mydir = which(me); mydir = mydir(1:end-2-numel(me));        % where am I located
if OCT && numel(mydir)==2 
  if strcmp(mydir,'./'), mydir = [pwd,mydir(2:end)]; end
end                 % OCTAVE 3.0.x relative, MATLAB and newer have absolute path

addpath(mydir(1:end-1))
addpath([mydir,'cov'])
addpath([mydir,'doc'])
addpath([mydir,'inf'])
addpath([mydir,'lik'])
addpath([mydir,'mean'])
addpath([mydir,'prior'])
addpath([mydir,'util'])

%%
% @author: skaudrey
% @ theme: add the prac path of skaudrey to the path
addpath([mydir,'moi_prac'])
addpath([mydir,'moi_prac','/','origin'])
addpath([mydir,'moi_prac','/','util'])
addpath([mydir,'moi_prac','/','util','/','compare'])
addpath([mydir,'moi_prac','/','util','/','data_pre'])
addpath([mydir,'moi_prac','/','util','/','reg2d'])
addpath([mydir,'moi_prac','/','util','/','file'])
addpath([mydir,'moi_prac','/','util','/','inter'])
addpath([mydir,'moi_prac','/','util','/','draw'])
addpath([mydir,'moi_prac','/','util','/','batchReg2d'])
addpath([mydir,'moi_prac','/','util','/','geo'])
addpath([mydir,'moi_prac','/','util','/','editComp'])
addpath([mydir,'moi_prac','/','util','/','interReuse'])
addpath([mydir,'moi_prac','/','util','/','regular'])
addpath([mydir,'moi_prac','/','inter'])
addpath([mydir,'moi_prac','/','typhoon'])
addpath([mydir,'moi_prac','/','normalday'])
addpath([mydir,'moi_prac','/','hyper'])
addpath([mydir,'moi_prac','/','hyper','/','normal'])
addpath([mydir,'moi_prac','/','hyper','/','typhoon'])
addpath([mydir,'moi_prac','/','reuse'])
addpath([mydir,'moi_prac','/','reuse','/','normalday'])
addpath([mydir,'moi_prac','/','reuse','/','typhoon'])
addpath([mydir,'moi_prac','/','DL'])
addpath([mydir,'moi_prac','/','td_fea'])
addpath([mydir,'moi_prac','/','td_fea','/','typhoon'])
addpath([mydir,'moi_prac','/','util','/','backrun'])


%%
clear me mydir
