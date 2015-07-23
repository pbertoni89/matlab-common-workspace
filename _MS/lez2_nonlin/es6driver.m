clc; clear all; close all;

% Simulare il sistema dx1 = x1*x1 - x1*x2 + 2*x1
%					  dx2 = x1*x1 - x2

%% Calcolare le matrici del sistema linearizzato
%% Calcolare gli equilibri
%% Tracciare le isocline
%% Disegnare la traiettoria dato x0 (macchina)

%xeq1 = [0; 0]; xeq2 = [2; 4]; xeq3 = [-1; 1];
eqs = [ 0 2 -1; 0 2 1];

x0 = [-1; -1]; %x0 = [-5; -5];

% IMP
% al variare della condizione iniziale potrei cadere nel bacino
% d'attrazione di un altro punto di equilibrio del sistema..

for k = 1:3
	xeq = eqs(:,k);
	% sistema lineare
	[A B C D] = linmod('es_own', xeq)
	% autovec autoval
	[evec eval] = eig(A)
	% simula
	[T xout simout] = sim('es_own');
	% traiettoria
	%plot(xout(:,1),xout(:,2),'b'); axis([-5 5 -5 10]);
	% evoluzioni
	figure(k);
	plot(T,xout(:,1),'b'); hold on;
	plot(T,xout(:,2),'r'); axis([0 10 -5 10]);
	pause
end