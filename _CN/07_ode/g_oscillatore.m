clear all; close all; clc;

L = 30; R = 0; K = .53; m = 2; Fext = 0; 
t0 = 0;

dy = @(t,y) [ y(2);
			 (1/m)*( Fext - R*y(2)  - K*y(1)) ];
y0 = [10,0]; % 10 mm

% voglio studiare l'evoluzione temporale x=y1 e dx=v=y2
% dopo la risoluzione ricordarsi di ottenere Pos = L + y1

A = [ 0, 1 ; -K/m, -R/m ]; 
avals = eig(A)
% puramente immaginari: confermano stabilità semplice (in senso Campi)
% RK4 NON ha forma chiusa per determinare se essi vanno bene o meno.

%% Runge_Kutta4
H = [ .5 2.5 5 6 ]; i=0; T = 200;
N = ceil((T-t0)./H);
figure('name','Runge Kutta'); 
for h = H, i=i+1;
	
	[ t y ] =  rk4(dy, [t0 T], y0, N(i));
	fprintf('RK4: h = %d, H*lambda = %d\n',h,abs(avals(1)*h));
	if i==1, simul = [t' y']; end
	
	subplot(2,2,i); plot(t,y(1,:)+L,'b'); hold on;
	plot(t,y(2,:),'g'); legend('x(t)+L','v(t)');
	title(['h = ',num2str(h)]);
end

mollagerv(simul(:,1),simul(:,2)); % simulo con h=.5

% non avendo attrito, mi aspetto un behaviour semplicemente stabile.
% IMP IMP IMP:
% in ogni caso, si dice lo stesso che lo SCHEMA è abs.stab
%	se la soluzione numerica riflette il comportamento teorico.

% per 2.5 e 5 presentano smorzamenti senza giustificazione teorica;
% sono detti SMORZAMENTI NUMERICI

% per RK4 non esistono forme chiuse che leghino h e stabilità.
% dobbiamo guardare sul piano di Gauss: l'asse immaginario è
% incluso (anche se non si vede bene) fino a +- 2.8 i
% pertanto Sì, i primi due h vanno bene!

%% Eul_Expl
H = [ 1 .1 .01 ]; i=0; T = 100;
N = ceil((T-t0)./H);
figure('name','Eulero Esplicito');  
for h = H, i=i+1;
	[ t y ] =  eul_expl(dy, [t0 T], y0, N(i));
	fprintf('EE: h = %d, H*lambda = %d\n',h,abs(avals(1)*h))
	subplot(2,2,i); plot(t,y(1,:)+L,'b'); hold on;
	plot(t,y(2,:),'g'); legend('x(t)+L','v(t)');
	title(['h = ',num2str(h)]);
end

% qua la regione ABS.STAB è il buon vecchio cerchio C=(-1,0) r=1.
% quindi l'unico valore in comune tra essa e l'asse img è l'origine
%	=> nessun h>0 darà assoluta stabilità a EulExpl.
% deduco quindi che h=.01 sembrava a.stabile e invece non lo è