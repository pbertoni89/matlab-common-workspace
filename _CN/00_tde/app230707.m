%% 1
clear all; clc; close all;

f = @(x) atan(x).*(cos(x)-1);
Ia = -2*pi; Ib = -Ia; Ntild = 101;
xtild = linspace(Ia,Ib,Ntild); ytild = f(xtild);

N = 6:2:20; errEq = []; errCh = [];

for n = N
	
	xeq = linspace(Ia, Ib, n);
	xch = chebyspace(Ia,Ib,n);
	
	yeq = f(xeq); ych = f(xch);
	aeq = vander(xeq)\yeq'; ach = vander(xch)\ych';

	peq = polyval(aeq,xtild); pch = polyval(ach,xtild);
	figure();
	plot(xtild,ytild,'k'); hold on;
	%plot(xn, yn, 'k^'); 
	title(['n=',num2str(n)]);
	plot(xtild, peq, 'b'); plot(xtild, pch, 'g');
	legend('f(x)','p_{EQ}','p_{CH}');
	
	errEq = [ errEq max(abs(ytild-peq)) ];
	errCh = [ errCh max(abs(ytild-pch)) ];
	
end

figure(), semilogy(N,errEq,'b',N,errCh,'g',N,N,'r',N,N.^2,'k');
legend('p_{EQ}','p_{CH}','n','n^2'), title('Errore'), xlabel('n');

% la teoria non offre condizioni necessarie e/o sufficienti per la 
% convergenza dell'IGL sui nodi equispaziati; generalmente 
% sui gradi elevati nascono oscillazioni vicino agli estremi. 
% Si può ipotizzare la divergenza

% la teoria assicura che se i nodi sono presi al senso di Chebychev
% la convergenza è assicurata per ogni n naturale.

%% 2
clear all; close all; clc;

g=9.81; M=1; m=1; R=1; k=6;
t0=0; T=20;

% y1 = x; dy1 = v; y2 = theta; dy2 = omega
dy = @(t,y) [ y(3) ; y(4) ;
	(m*R*(y(4)).^2.*sin(y(2))+m*g*sin(y(2)).*cos(y(2))-k*y(1))/ ...
					(M+m*(sin(y(2))).^2) ;
	(-m*R*(y(4)).^2.*sin(y(2)).*cos(y(2))-(m+M)*g*sin(y(2))+ ...
	  k*y(1).*cos(y(2)))/(R*(M+m*(sin(y(2))).^2)) ;               ];
y0 = [0 -pi/4 0 0];

h = .02; n = ceil((T-t0)./h);

[ trk4 yrk4 ] =  rk4(dy, [t0 T], y0, n);
[ tee yee ] =  eul_expl(dy, [t0 T], y0, n);

molla_pendolo(trk4,yrk4), molla_pendolo(tee,yee);