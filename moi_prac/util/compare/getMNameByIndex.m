function name = getMNameByIndex(index,compareS)
sizeM = size(index,2);

name = cell(1,sizeM);

for i = 1:sizeM
    temp = getMethodName(index(i),compareS);
    name{i} = temp; 
end