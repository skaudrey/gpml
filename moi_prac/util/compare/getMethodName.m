function mname = getMethodName(typeM,compareS)
mname = '';
if(compareS == 1)
    switch typeM
        case 1
            mname = 'sp';
        case 2
            mname = 'mp';
        case 3
            mname = 'mult';
        case 4
            mname = 'multV';
        case 5
            mname = 'pcaSum';
        case 6
            mname = 'pcaProd';
        case 7
            mname = 'se';
        case 8
            mname = 'rq';
        case 9
            mname = 'period';
        case 10
            mname = 'mat'; 
        case 11
            mname = 'auto'; 
        case 12
            mname = 'pcaX'; 
        case 13
            mname = 'mpV';
        case 14
            mname = 'pcaMp';
        case 15
            mname = 'pcaregSum';
        case 16
            mname = 'pcaregProd';
        case 17
            mname = 'pcaregAuto';
        case 18
            mname = 'pcaregX';
        case 19
            mname = 'pcaregMp';
    end      


elseif(compareS == 2)
     switch typeM
        case 1
            mname = 'A';
        case 2
            mname = 'mult';
        case 3
            mname = 'APS';   
        case 4
            mname = 'APP';
        case 5
            mname = 'MPP';    
        case 6
            mname = 'MPS';    
        case 7
             mname = 'SP';
         case 8
             mname = 'PA';
         case 9
             mname = 'PAP';
         case 10
             mname = 'PAS';
         case 11
             mname = 'MAP';
         case 12
             mname = 'MAS';
    end      
end