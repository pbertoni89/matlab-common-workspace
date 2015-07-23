clear all; close all; clc;
format long;
%dati del problema
M = 6000;
v = 1000;
n = 5;

f=@(r) v*((r+1)./r).*((r+1).^n-1)-M;

a= 1e-04; b= 1e-01;

r = linspace(a, b, 100);

tol = 1e-8;
nmax = 100;

figure(1);
plot(r, f(r)); grid on; %  è QUASI lineare

%% Bisezione
[zeroB, resB, niterB] = bisection(f, a, b, tol, nmax)
% niter soddisfa la stima teorica?
k_theo = ceil(log2((b-a)/tol)-1);

%% Newton 
f1 =@(r) v*( ( ((n+1)*(r+1)^n-1) .* r-( (r+1).^(n+1)-(r+1) )) )./(r.^2);
x0 = 0.055; %% abbastanza vicino alla radice.
% devo evitare i punti a tangenza orizzontale o quasi orizzontale!
% difatti mettendo ad esempio x0 si ottiene NaN.
[zeroN, resN, niterN] = my_newton(f, f1, x0, tol, nmax)

% avevamo posto una tolleranza di ordine -8, ed effettivamente su questa
% dimensione gli zeri ottenuti da bisezione e newton iniziano a differire,
% e con essi i residui chiaramente.
% Si noti la velocità assurda di Newton :)

%% Secanti
x0 = -2; x1 = -2.5;
[zeroS, resS, niterS, ~] = my_secanti(f, x0, x1, tol, nmax)