% judge the distribution of the data 
% A's dimension is A*1
% given the trust probability 0.05
function distjudge(A,alpha)
%% gaussian distribution
[mu,sigma] = normfit(A);
p1 = normcdf(A,mu,sigma);
[H1,s1] = kstest(A,[A,p1],alpha);

n = length(A);
if H1 == 0
    disp('Gaussian distribution');
else
    disp('NOT Gaussian distribution');
end

%% gama distribution
phat = gamfit(A,alpha);
p2 = gamcdf(A,phat(1),phat(2));
[H2,s2] = kstest(A,[A,p2],alpha);
if H2 == 0
    disp('gama distribution');
else
    disp('NOT gama distribution')
end

%% possion distribution
lambda = poissfit(A,alpha);
p3 = poisscdf(A,lambda);
[H3,s3] = kstest(A,[A,p3],alpha)
if H3 == 0
    disp('possion distribution');
else
    disp('NOT possion distribution')
end

%% exponential distribution
mu = expfit(A,alpha);
p4 = expcdf(A,mu);
[H4,s4] = kstest(A,[A,p4],alpha)
if H4 == 0
    disp('exponential distribution');
else
    disp('NOT exponential distribution')
end

%% rayleigh distribution
[phat,pci] = raylfit(A,alpha);
p5 = raylcdf(A,mu);
[H5,s5] = kstest(A,[A,p5],alpha)
if H5 == 0
    disp('Rayleigh Distribution');
else
    disp('NOT Rayleigh Distribution')
end

