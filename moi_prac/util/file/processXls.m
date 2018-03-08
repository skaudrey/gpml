% process all the xls file in the path '';

path = 'D:\Code\Matlab\gpml\moi_prac\reuse\normalday\mpng\time\reg1\';

filefolder = fullfile(path);
diroutput = dir(fullfile(filefolder,'*.xls'));
filenames = {diroutput.name};

filesize = size(filenames,2);

for i = 1:filesize
    filename = strcat(path,'\',char(filenames(i)));
    
    ss = strsplit(filename,'.xls');

    prex = ss(1);
        
    outfilename = char(strcat(prex,'.txt'));
    
    xls2txt(filename,outfilename);
    
end