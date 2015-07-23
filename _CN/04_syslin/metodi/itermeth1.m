function [x,relres,iter,resvec]= itermeth1(A,b,x0,nmax,tol,P)
%ITERMETH1    Un metodo iterativo generale
%  [X,RELRES,ITER,RESVEC] = ITERMETH(A,B,X0,NMAX,TOL,P) 
%  risove iterativamente il sistema di equazioni
%  lineari A*X=B su X. La matrice A di N-per-N coef-
%  ficienti deve essere non singolare ed il termine
%  noto B deve avere lunghezza N. Se P='J' viene usato
%  il metodo di Jacobi, se P='G' viene invece selezio-
%  nato il metodo di Gauss-Seidel. Altrimenti, P e'
%  una matrice N-per-N non singolare che gioca il
%  ruolo di precondizionatore nel metodo del gradiente,
%  che e' un metodo di Richardson a parametro dinamico.
%  Il metodo si arresta quando il rapporto
%  fra la norma del residuo corrente e quella del
%  residuo iniziale e' minore di TOL e ITER e' il
%  numero di iterazioni effettuate. NMAX prescrive
%  il numero massimo di iterazioni consentite. Se P
%  non viene precisata, viene usato il metodo del
%  gradiente non precondizionato.
%  RELRES=norm(r)/norm(b) e` il residuo normalizzato finale
%  RESVEC=[norm(r^{(k)})] e` il vettore con le norme dei 
%  residui di tutte le iterazioni
[n,n]=size(A);
resvec=[];
if nargin == 6
 if ischar(P)==1
  if P=='J'
   L=spdiags(diag(A),0,n,n); U=speye(n); beta=1; alpha=1;
  elseif P == 'G'
   L=sparse(tril(A)); U=speye(n); beta=1; alpha=1;
  end
 else
     [L,U]=lu(P); beta = 0;
 end
else
  L = speye(n); U = L; beta=0;
end
iter = 0;        x = x0;
r = b - A * x0;  r0 = norm(r);  err = norm (r);
while err > tol & iter < nmax
  iter = iter + 1;  z = L\r;  z = U\z;
  if beta == 0
     alpha = z'*r/(z'*A*z);
  end
  x = x + alpha*z;  r = b - A * x; err = norm (r) / r0;
  resvec=[resvec;norm(r)];
end
bb=norm(b);
if bb~=0
    relres=norm(r)/bb;
end
return