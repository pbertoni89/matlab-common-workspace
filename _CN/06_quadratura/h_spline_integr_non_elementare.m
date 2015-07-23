clear all; close all; clc; format longg

xa = 1; xb = 10;
N = 20; % cardinalità di xk suggerita da prof
x = linspace(xa, xb, N); 

f = @(x) sin(x)./x;
% ne sia F(x) la funzione integrale tra xa e x variabile.
% nella pratica, F è il vettore che contiene dei valori F(x(k))
F = zeros(1,N);

% come è possibile calcolare F(10)-F(1) ? sinc non è integrabile
% elementarmente. potremmo pensare a un'interp in punti discreti.

  F(1) = 0; %(chiaro) 
% F(xk) = ... = F(xk-1) + Qk (seguo slide)
for k = 2:N
	Qk = quad(f, x(k-1),x(k));
	F(k) = F(k-1) + Qk;
end
% la funzione Matlab "quad" implementa Simspon adattivo.
% Qkmy = simpson_ad(f,x(k-1),x(k),1.e-16,.5e-10) apporta uno scarto
% max(abs(Fmy-F)) di ordine -12 con grande lentezza.

%interpolazione spline.
Nspl = 100;
xspl = linspace(xa,xb,Nspl);
Fspl  = spline(x,F,xspl);

plot(xspl,f(xspl),'g'); hold on;
plot(xspl,Fspl,'b'); plot(x,F,'ob');
legend('f = sinc','F = Si','Fk');

%calcolo integrale
Iquad = F(end)-F(1) % come F(10)-F(1) sulla carta. 
% IMP INF osservare che end=N=20.. com'è possibile ciò?
% semplicemente ho diviso il range [0,10] in 20 punti,
% printare x(end) e lenght(x) se si han dubbi.
Iwolfram = 0.71226452385169103438961856556649 % wolframino
format