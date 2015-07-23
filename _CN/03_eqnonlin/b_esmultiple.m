clear all; close all; clc;
format long;

a= -3; b= -a; x = linspace(a, b, 100);

f=@(x)   sin(x-1)-0.5*sin(2*(x-1));
f1=@(x)  cos(x-1)-cos(2*(x-1));

tol = 1e-8; nmax = 100;

figure(1);
plot(x, f(x),'b', x,f1(x),'g',x,0*x,'r'); 
grid on; legend('f(x)','f ''(x)');

% IMP IMP IMP, NON posso usar bisection. why? 
% sono concordi agli estremi, dovrei prima restringere range

%% Newton
x0s = -1.5;
[zeroNs, resNs, niterNs, ERRNs] = my_newton(f, f1, x0s, tol, nmax);
zeroNs 
resNs
niterNs
%
x0m = 0.1;
[zeroNm,  resNm,  niterNm,  ERRNm] = my_newton(f, f1, x0m, tol, nmax);
zeroNm  
resNm
niterNm

%plotto newton, solo per idea radici
hold on; plot(zeroNs,0,'ok',zeroNm,0,'ok'); 

%% Secanti
x0s = -1.5; x1s = -1.6;
[zeroSs, resSs, niterSs, ERRSs] = my_secanti(f, x0s, x1s, tol, nmax);
zeroSs
resSs
niterSs
%
x0m = 0.1; x1m = 0.4;
[zeroSm, resSm, niterSm, ERRSm] = my_secanti(f, x0m, x1m, tol, nmax);
zeroSm
resSm
niterSm

%% Storie di cvg
figure(2);
semilogy((1:niterNs), ERRNs, 'r', (1:niterNm), ERRNm, 'b', ...
		(1:niterSs), ERRSs, 'r--',(1:niterSm), ERRSm, 'b--' );
grid on;
legend('Nsemp','Nmul', 'Ssemp', 'Smul');

% potenza di secanti!! non conosco la derivata, utilizzo il rapporto
% incrementale ma perdo pochissimo sul residuo.
% alternativa migliore!