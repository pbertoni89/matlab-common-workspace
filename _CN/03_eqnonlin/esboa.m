clc; clear all; close all;
R = 0.055;
rho = 0.6;

f=@(x) x.^3 - 3*x.^2*R + 4*R.^3*rho;
f1=@(x) 3*x.^2 - 6*x*R;
%f1=@(x) 3*x.^2 - 5*x*R;  volutamente ERRATA 
% (si pensi a metodi di calcolo differenziale approssimati)
% cosa succede? lo zero è comunque corretto, ma il residuo è cresciuto molto, 
% oltre al niter richiesto per la computazione.

x = linspace(-0.1,0.2,100);

a = 0; 
b = 2*R;

tol = 1e-8;
nmax = 100;

plot(x,f(x)); 
grid on; hold on; 
plot([0,2*R], [0,0], 'r'); plot(x,f1(x),'g');
legend('f(x)','ok','f''(x)');

%% Bisezione
[zeroB, resB, niterB] = bisection(f, a, b, tol, nmax)

% niter soddisfa la stima teorica?
niter_theoric_bisection = ceil(log2((b-a)/tol)-1)

%% Newton
X0 = [0 .03 .01 .055]; %% abbastanza vicino alla radice.
% devo evitare i punti a tangenza orizzontale o quasi orizzontale!
% difatti mettendo ad esempio x0=0 si ottiene NaN.
for x0 = X0
	fprintf('gira newton con x0=%d\n',x0);
	if f1(x0) == 0, disp('f1(x0)=0, si avranno problemi'), end
	[zeroN, resN, niterN] = my_newton(f, f1, x0, tol, nmax)
end