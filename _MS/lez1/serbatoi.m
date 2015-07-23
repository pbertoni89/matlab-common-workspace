%% Simulare la cascata di due serbatoi (un sistema linearizzato).
% Le equazioni che lo descrovono sono:
% x1,x2 livelli dei due serbatoi.
% S1,S2 aree dei due serbatoi.
% u portata entrante 1
% k1*x1 portata uscente 1
% S1*Dx1 è la variazione di volume del serbatoio 1: l'uguaglianza è
%                               S1*Dx1 = u - k1*x1
% => Dx1 = u/S1 - k1/S1*x1

% k1*x1 portata entrante 2
% k2*x2 portata uscente 2
%                               S2*Dx2 = k1*x1 - k2*x2
% => Dx2 = x1/S2*x1 - k2/S2*x2

clear all; close all; clc;

S1 = 1; S2 = 1;
k1 = .5; k2 = .8;
ueq = 1;

%% Risoluzione autonoma
A = [ -k1/S1 0; k1/S2 -k2/S2 ];
B = [ 1/S1; 0 ];
x0 = [1 1]'; % è un vettore colonna!
% tempo simulazione
t = [0:.01:10]';  % UGUALE A (0:.01:10)'
% ingresso uguale a quello per l'equilibrio
u = ueq * ones(size(t));
%y=k2*x2
C=[0 k2];
D=0;

%% Simulazione
sys=ss(A,B,C,D); %def. sistema
[y,t,x] = lsim(sys,u,t,x0); %simula il sistema

plot(t,x); legend('x_1(t)','x_2(t)');

figure
plot(t,y); legend('y(t)');

figure
plot(x(:,1),x(:,2)); legend('traiettoria');