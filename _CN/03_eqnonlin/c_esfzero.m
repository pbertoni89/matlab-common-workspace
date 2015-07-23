clear all; clc; close all;
% fzero comando matlab parte con bisezione, 
% quando ha ridotto un po' l'intervallo parte con delle secanti.
% a volte localmente approssima la funzione con delle parabole.
% va in errore se la funzione non cambia segno in un intorno del punto
% dato (richiesto dalla bisezione)

x0 = -1;
x = linspace(-2,2,100);
f=@(x) x.^2-3*x-4;

[alpha, f_alpha, flags] = fzero(f, x0)

plot(x,f(x),'b--',alpha,0,'or');

%% Newton Complesso 

f=@(x) x^2-3*x+4; df =@(x) 2*x-3; 

tol=1.e-8; nmax=100; 
x0=-1+1i;

[zeroCplx,resCplx,niterCplx] = my_newton(f,df,x0,tol,nmax)