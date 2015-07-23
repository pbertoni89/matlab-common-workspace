clear all; close all; clc;
% Approssimare numericamente la radice di due, calcolando la radice
% positiva della funzione NON lineare f(x) = x^2-2 

x = linspace(1,1.7,1000);

f = @(x) x.^2 -2;
phi1 = @(x) -.25*x.^2 + x + .5;
phi2 = @(x) -    x.^2 + x +  2;
phi3 = @(x)   .5*x + 1./x;

figure(1);
plot(x,x,'k'); hold on; grid on;
plot(x,phi1(x),'r',x,phi2(x),'g',x,phi3(x),'b'); axis tight
legend('x','\phi_1','\phi_2','\phi_3');

% verificare se le tre phi sono effettivamente funzioni di punto fisso per
% f. come? phi(sqrt(2)) =?= sqrt(2) 

 alpha_th = sqrt(2);
% alpha_th_1 = phi1(alpha_th);
% alpha_th_2 = phi2(alpha_th);
% alpha_th_3 = phi3(alpha_th);
	% Ok, per tutte e tre.

tol = 1e-12; nmax = 40; %sufficiente
x0 = 1.5;
[alpha1 niter1 errhist1] = ptofisso(phi1, x0, tol, nmax);
[alpha2 niter2 errhist2] = ptofisso(phi2, x0, tol, nmax);
[alpha3 niter3 errhist3] = ptofisso(phi3, x0, tol, nmax);

figure(2);
semilogy((1:niter1),errhist1,'r', ...
		 (1:niter2),errhist2,'g',(1:niter3),errhist3,'b');
grid on;
legend('\phi_1','\phi_2','\phi_3');

%% Conclusions
% phi1 converge linearmente alla radice per Ostrovskij
	dphi1 = @(x) -.5*x + 1;
	abs*dphi1(alpha_th)( % diverso da 0
% phi2 NON converge:
	dphi2 = @(x) -2*x +1;
	abs(dphi2(alpha_th)) % > 1
	%non ci sono le condsuff per la convergenza; tutto può essere..
% phi3 converge almeno quadraticamente per Ostrovskij
	dphi3 = @(x) .5 - x.^(-2);
	dphi3(alpha_th)		 % circa 0
