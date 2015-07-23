function [ zero, res, niter ] = bisection(fun, a, b, tol, nmax, varargin)

%BISECTION Trova uno zero di una funzione.
%   ZERO=BISECTION(FUN,A,B,TOL,NMAX) approssima uno
%   zero della funzione FUN nell'intervallo [A,B] con
%   il metodo di bisezione.  FUN deve essere definita
%   su variabile vettoriale.
%   Se la ricerca dello zero di FUN fallisce, il
%   programma restituisce un messaggio d'errore.
%   FUN puo' essere una inline function, una anonymous
%   function od una function definita in un M-file.
%
%   ZERO=BISECTION(FUN,A,B,TOL,NMAX,P1,P2,...) passa
%   i parametri P1, P2,... alla funzione
%   FUN(X,P1,P2,...).
%
%   [ZERO,RES,NITER]= BISECTION(FUN,...) restituisce
%   il valore del residuo RES in ZERO ed il numero di
%   iterazioni effettuate per calcolare il valore ZERO.

	x = [a, (a+b)*0.5, b];
	res = 0; niter = 0;
	fx = fun(x,varargin{:}); %varargin referenziata con le graffe; è una struct in matlab
	if fx(1)*fx(3) > 0 %% f(a)f(b) > 0
	  error(' Il segno della funzione agli estremi dell''intervallo [A,B] deve essere diverso');
	elseif fx(1) == 0
		zero = a;  return
	elseif fx(3) == 0
		zero = b;  return
	end

	I = (b - a)*0.5;
	
	while I >= tol && niter < nmax
	   niter = niter + 1;
	   if fx(1)*fx(2) <  0
		  x(3) = x(2);
		  x(2) = x(1)+(x(3)-x(1))*0.5;
		  fx = fun(x,varargin{:});
		  I = (x(3)-x(1))*0.5;
	   elseif fx(2)*fx(3) < 0
		  x(1) = x(2);
		  x(2) = x(1)+(x(3)-x(1))*0.5;
		  fx = fun(x,varargin{:});
		  I = (x(3)-x(1))*0.5;
	   else
		   x(2) = x(fx==0); 
		   I = 0;
	   end
	end
	
	if  (niter==nmax && I > tol)
	 fprintf('computation forced to end.\n');
	end
	
	zero = x(2);
	x = x(2);
	res = fun(x,varargin{:});
return