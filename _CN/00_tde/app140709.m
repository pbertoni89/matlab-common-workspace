%% 1
clc, close all, clear all

% ( I -hC) u = un da risolvere con lu per effettuare UNA SOLA fact
% purtroppo non possiamo fare tutto il tema, sono spariti i dati

% la fattorizzazione costa (2/3)*n^3
% ogni risoluzione istantanea costa 2*n^2
% essendo Nh gli istanti (iniziale escluso) avrò (2/3)n^3+(2*Nh)n^2

%% 2
clc, close all, clear all
range0 = [ eps 2+eps ]; range1 = [ 0 .1]; range2 = [1.9 2.1];
tol = 1.e-8; nmax = 100;

f1 = @(x) log(x/2)/3+x.^2; f2 = @(x) x.^2+x-2;
f0 = @(x) log(x/2)/3-x+2;

% tol <= (b-a)/(2^i+1)  
% ith0 = ceil(log2((range0(2)-range0(1))/tol)-1)
ith1 = ceil(log2((range1(2)-range1(1))/tol)-1);
ith2 = ceil(log2((range2(2)-range2(1))/tol)-1);

[z1 res1 nit1] = bisection(f0,range1(1),range1(2),tol,nmax);
[z2 res2 nit2] = bisection(f0,range2(1),range2(2),tol,nmax);

figure, fplot(f1, range1, 'r'), hold on
fplot(f2, range1, 'g'), fplot(f0, range1, 'b'), plot(z1,f0(z1),'ok')
legend('f_1','f_2','f_0')
figure, fplot(f1, range2, 'r'), hold on
fplot(f2, range2, 'g'), fplot(f0, range2, 'b'), plot(z2,f0(z2),'ok')
legend('f_1','f_2','f_0')

fprintf('z1=%d | res=%d | usate %i su %i iter\n', z1,res1, nit1, ith1)
fprintf('z2=%d | res=%d | usate %i su %i iter\n', z2,res2, nit2, ith2)

%2
df0 = @(x) 1/(3*x)-1;
[z1, res1, nit1, ~] = my_newton(f0,df0,.001,tol,50);
[z2, res2, nit2, ~] = my_newton(f0,df0,range2(1),tol,50);

disp('Newton');
fprintf('z1=%d | res=%d | usate %i iter\n', z1,res1, nit1)
fprintf('z2=%d | res=%d | usate %i iter\n', z2,res2, nit2)

%3
phi = @(x) log(x/2)/3+2;
dphi = @(x) 1/(3*x);
[zphi1 nit1 err1] = ptofisso(phi,.05,tol,50);
[zphi2 nit2 err2] = ptofisso(phi,range2(1),tol,50);

disp('Punto Fisso');
fprintf('z1=%d | usate %i iter\n', zphi1, nit1)
fprintf('z2=%d | usate %i iter\n', zphi2, nit2)

figure, fplot(f0, [range1(1) range2(2)], 'r'), hold on
		fplot(phi,[range1(1) range2(2)], 'b')
		x = range1(1):.0001:range2(2); plot(x,x,'g')
legend('f_0','\phi','x')
% il Th1 sul punto fisso è rispettato per quanto riguarda la classe C0
% quindi sicuramente esisteranno x = phi(x).
% phi però non è lipsitschiana, infatti x non è unica.

% il Th Ostrovskij NON è rispettato per la radice z1.
% quindi non esiste un intorno di z1 che possa attrarre la soluzione.
dphi(z1)
dphi(z2)
% per la radice z2 invece il suddetto teorema garantisce cv almeno 
% quadratica, essendo dphi(z2) != 0