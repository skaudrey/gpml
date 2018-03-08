% @opt_index: 1 for materniso1,2 for periodic, 3 for materniso1+periodic, 4 for multiscale
% The function is for getting the string meaning of method index

function mName = getMName(typeM)
mName = '';

switch(typeM)
    case 1
        mName = 'materiso1';
    case 2
        mName = 'periodic';
    case 3
        mName = 'materniso1+periodic';
    case 4
        mName = 'multi-scale';    
end