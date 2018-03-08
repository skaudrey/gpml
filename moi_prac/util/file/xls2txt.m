function xls2txt(excelfile,txtfile)
data = xlsread(excelfile);

f = fopen(txtfile, 'wt');
[size_row, size_col] = size(data);

 for i = 1: size_row
     for j = 1: size_col
         fprintf(f, '%.8f', data(i,j));fprintf(f, ',');
     end
 end
 
 fclose(f);