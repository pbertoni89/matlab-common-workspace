function [zero,res,niter] = secantigerv(fun, x0, x1, tol, nmax, varargin) 
%SECANT Trova uno zero di una funzione. 
% ZERO=SECANT(FUN,X0,X1,TOL,NMAX) approssima lo 
% zero ZERO della funzione definita nella function 
% FUN, continua usando il metodo di secanti 
% partendo da X0 e X1. FUN accetta in ingresso 
% uno scalare x e restituisce un valore scalare. 
% Se la ricerca dello zero fallisce, il programma 
% restituisce un messaggio d'errore. 
% FUN puo' essere una inline function, anonymous 
% function o function definita in M-file. 
% ZERO=SECANT(FUN,X0,X1,TOL,NMAX,P1,P2,...) passa 
% i parametri P1,P2,... alla funzione % FUN(X,P1,P2,...). 
% [ZERO,RES,NITER]= SECANT(FUN,...) restituisce il 
% valore del residuo RES in ZERO ed il numero di 
% iterazioni NITER necessario per calcolare ZERO. 

fx0 = fun(x0,varargin{:}); 
fx1 = fun(x1,varargin{:}); 

niter = 0; 
diff = tol+1; 

while diff >= tol && niter < nmax 
	niter = niter + 1; 
	diff = - fx1*(x1-x0)/(fx1-fx0); 
	x0=x1; 
	x1 = x1 + diff; 
	diff = abs(diff); 
	fx0=fx1; 
	fx1 = fun(x1,varargin{:}); 
end

if (niter==nmax && diff > tol) 
	fprintf(['Secanti si e'' arrestato senza aver soddisfatto l''accuratezza richiesta, avendo\n',... 
			'raggiunto il massimo numero di iterazioni\n']); 
end

zero = x1; 
res = fx1; 

return