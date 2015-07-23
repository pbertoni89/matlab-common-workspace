clear all; close all; clc;

xa = 0; xb = +Inf; % non possiamo certo lavorarci!!!

tol = 1.e-3; semitol = tol/2;

f = @(x) exp(-x).*(cos(x).^2);
fI = @(x) exp(-x).*(-2*sin(2*x)+cos(2*x)+5)*(-0.1);

% inizio ad osservare che il valore di I è compreso tra 0 e 1.
% difatti il cos2 fa solo oscillare tra 0 e 1 l'integrando;
% lowerbound è 0, poichè sarà un'area sempre positiva
% upperbound è 1, poichè integrale di exp(-x) sullo stesso range.

% ora mi serve beta reale per suddividere l'integrazione in due range;
% dev'esser tale che
%	int(f,beta,Inf) < 0.5e-3
%	int(f,0,  beta) approssimi I con uno scarto massimo di 0.5e-3
% in questo modo l'errore massimo commesso è 0.5e-3 + 0.5e-3 = 1.e-3

%% Ricerca di Beta
% limitiamo sempre I < int( e(-x), beta, Inf) = e(-beta)
%	=> e(-beta) < 0.5e-3	=>	beta > -ln(0.5e-3)
beta = - log(semitol);

% per calcolare tutto mi manca M_tol. Troviamo quindi d2f a mano
d2f = @(x) exp(-x).*(2*sin(x)-2*cos(x)+(cos(x)).^2);
% sappiamo che H_tol <= sqrt(12*(0.5e-3)/((xb-xa)*F))
% con F = max(abs(d2f(...))) 

x_test = linspace(xa,beta,1000); y_test = d2f(x_test);
F = max(abs(y_test));
figure(1); plot(x_test,y_test); title('Massimo della D2'); 

H_tol = sqrt(12*semitol/((beta-xa)*F));
M_tol = ceil((beta-xa)/H_tol);

I_tol =  i_c_trap(f,xa,beta,M_tol);
I_ex = fI(beta) - fI(xa);
fprintf('M_tol = %d  | I_tol = %d |	I_ex = %d \n', ...
			M_tol, I_tol, I_ex);

if(abs(I_tol-I_ex)<=tol)
	fprintf('Well Done!\n');
else
	fprintf('Errore Teorico!\n');
end