%
% Richiama la function: grad1.m
%
%
A=[10,6;6,6];b=[11;2];
x=[-40;50];nmax=100;toll=1.e-10;
%
% metodo del gradiente
%
clf
zoom on
fprintf('Risolvo il sistema lineare Ax=b con \n')
A
b
fprintf('le isolinee della forma quadratica (paraboloide) associata \n')
fprintf('al sistema Ax=b sono rappresentate in figura 2\n')
[xG,itG,ErrG]=grad1(x,A,b,nmax,toll);

