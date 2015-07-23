%% 1
clear all; close all; clc;

prove = 6;
tol8  = 1.e-8;
tol14 = 1.e-14;
nmax = 500;

A = [6 1 -2 2 1; 0 -3 3 -2 1; 2 .5 5 -1 -2; 0 1 2 -3 2; .5 -1 1 .4 2];
b = [15 0 4 6 13.1]';

% Storie
figure(1);	
for i = 1:prove
	x0 = rand(5,1);
	[xJ niterJ ERRJ rhoJ]    = gsjac(A, b, x0, tol8, nmax, 'J');
	[xGS niterGS ERRGS rhoGS] = gsjac(A, b, x0, tol8, nmax, 'GS');

	semilogy((1:niterJ), ERRJ, 'r', (1:niterGS), ERRGS, 'b'); hold on;
end
grid on; legend('J', 'GS');
% Analisi
rhoJ
rhoGS
fprintf('minore il raggio spettrale della matrice di iterazione, ');
fprintf('minori iterazioni serviranno al metodo per convergere \n');

fprintf('minore inoltre la tolleranza accettata, minore errore ');
fprintf('si avrà rispetto a una soluzione di metodo diretto \n');

xex = A\b;
%using last x0 generated
disp('Jacobi tol 8')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol8, nmax, 'J');
err = norm(xex-x)/norm(xex)
nit
disp('Jacobi tol 14')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol14, nmax, 'J');
err = norm(xex-x)/norm(xex)
nit
disp('GaussSiedel tol 8')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol8, nmax, 'GS');
err = norm(xex-x)/norm(xex)
nit
disp('GaussSiedel tol 14')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol14, nmax, 'GS');
err = norm(xex-x)/norm(xex)
nit
%% 2
clc;
A = [ 6 1 -2 2 1; 1 3 1 -2 0; -2 1 4 -1 -1; 2 -2 -1 4 2; 1 0 -1 2 3];
b = [15 2 3 21 21]';

figure(2);	
for i = 1:prove
	x0 = rand(5,1);

	[xJ niterJ ERRJ rhoJ]    = gsjac(A, b, x0, tol8, nmax, 'J');
	[xGS niterGS ERRGS rhoGS] = gsjac(A, b, x0, tol8, nmax, 'GS');

	semilogy((1:niterJ), ERRJ, 'r', (1:niterGS), ERRGS, 'b'); hold on;
end
grid on; legend('J', 'GS');

rhoJ  % >=1 => non cvg
rhoGS % < 1 => cvg
% A non è DDS, non vi sono cond.suff per la convergenza. 
% rho(BJ) >= 1 <=> non converge
% A è SDP? dovrei verificare che x'Ax < 0 per ogni x=0 ...
% ma so che lo è sse è symm & tutti gli autovalori sono positivi. 
% difatti A è SDP e GS cvg

xex = A\b;

disp('Jacobi tol 8')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol8, nmax, 'J');
err = norm(xex-x)/norm(xex)
nit
disp('Jacobi tol 14')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol14, nmax, 'J');
err = norm(xex-x)/norm(xex)
nit
disp('GaussSiedel tol 8')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol8, nmax, 'GS');
err = norm(xex-x)/norm(xex)
nit
disp('GaussSiedel tol 14')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol14, nmax, 'GS');
err = norm(xex-x)/norm(xex)
nit

%% 3
clc;
n = 10;
e = ones(n,1);
A = spdiags([-e, 2*e, -e], [-1 0 1], n, n);
A(1,:) = 0; A(1,1) = 1; A(n,:) = 0; A(n,n) = 1;

h = 1/(n-1);
b = ones(n,1); b(1) = 0; b(n) = 0; b = h^2*b;

figure(3);	
for i = 1:prove
	x0 = rand(n,1);

	[xJ niterJ ERRJ rhoJ]    = gsjac(A, b, x0, tol8, nmax, 'J');
	[xGS niterGS ERRGS rhoGS] = gsjac(A, b, x0, tol8, nmax, 'GS');

	semilogy((1:niterJ), ERRJ, 'r', (1:niterGS), ERRGS, 'b'); hold on;
end
grid on; legend('J', 'GS');

rhoJ 
rhoGS % = rhoJ*rhoJ infatti A è tridiagonale e J ~ GS
% se cvg lo fa con velocità doppia

xex = A\b;

disp('Jacobi tol 8')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol8, nmax, 'J');
err = norm(xex-x)/norm(xex)
nit
disp('Jacobi tol 14')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol14, nmax, 'J');
err = norm(xex-x)/norm(xex)
nit
disp('GaussSiedel tol 8')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol8, nmax, 'GS');
err = norm(xex-x)/norm(xex)
nit
disp('GaussSiedel tol 14')
[x, nit, ~, ~] =  gsjac(A, b, x0, tol14, nmax, 'GS');
err = norm(xex-x)/norm(xex)
nit
