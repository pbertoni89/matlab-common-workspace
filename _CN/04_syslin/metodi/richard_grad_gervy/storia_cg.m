%
A=[10,6;6,6];b=[11;2];
x=[-40;50];nmax=100;toll=1.e-10;
%
% gradiente coniugato
%
x=[-40;50];
[xCG,itCG,ErrCG]=conjgrad1(x,A,b,nmax,toll);
