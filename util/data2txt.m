% save file as txt

function data2txt(basepath,filename,data)

f = fopen([basepath,'\',filename], 'wt');

[n,nSize] = size(data); % the data is a line vector actually,deal as a two-dimension matrix
for i = 1:n
    for j = 1: nSize
        fprintf(f, '%.8f', data(i,j)); fprintf(f, ',');
    end
end
fclose(f);