function [zero,res,niter]=broyden(fun,B0,x0,tol,...
                                 nmax,varargin)
%BROYDEN Trova uno zero di un sistema di funzioni.
%   ZERO=BROYDEN(FUN,B0,X0,TOL,NMAX) approssima lo
%   zero ZERO del sistema di funzioni definite nella
%   function FUN, usando il metodo di Broyden
%   partendo da X0, dove B0 e' l'approssimazione
%   dello Jacobiano al passo 0. FUN accetta in ingresso
%   un vettore x e restituisce un vettore della stessa
%   dimensione. Se la ricerca dello zero fallisce, il
%   programma restituisce un messaggio d'errore.
%   FUN puo' essere una inline function, anonymous
%   function o function definita in M-file.
%   ZERO=BROYDEN(FUN,B0,X0,TOL,NMAX,P1,P2,...)
%   passa i parametri P1,P2,... alla funzione
%   FUN(X,P1,P2,...).
%   [ZERO,RES,NITER]= BROYDEN(FUN,...) restituisce il
%   valore del residuo RES in ZERO ed il numero di
%   iterazioni NITER necessario per calcolare ZERO.

fx0 = fun(x0,varargin{:});
niter = 0; diff = tol+1;
while diff >= tol && niter < nmax
  deltax=-B0\fx0; x1=x0+deltax; fx1=fun(x1,varargin{:});
  B0=B0+(fx1*deltax')/(deltax'*deltax);
  niter = niter + 1; diff = norm(deltax);
  x0=x1; fx0=fx1;
end
zero = x1; res = norm(fx1);
if (niter==nmax && diff > tol)
  fprintf(['Broyden si e'' arrestato senza aver ',...
   'soddisfatto l''accuratezza richiesta, avendo\n',...
   'raggiunto il massimo numero di iterazioni\n']);
else
 %   fprintf(['Il metodo converge in %i iterazioni',...
 %           ' con un residuo pari a %e\n'],niter,res);
end
return
