clc; clear all; close all;
N0 = [25; 10];
%% DUE PUNTI, A

%% TRE PUNTI, K1 = 800
%   { dN1 = + e1.(1-N1/K1).N1 - p.N1.N2
%	{ dN2 = - e2.N2         + e.p.N1.N2

e1 = 40; e2 = 10; e = 0.1; p = 0.2; K1 = 800;

%Neq_a = [0; 0]; Neq_b = [500; 120]; Neq_c = [800; 0];
Neq_a = [0; 0]; 
Neq_b = [e2/(e*p); (e1/p)*(1-e2/K1)]; 
Neq_c = [K1; 0];

% simula sistema non lineare
[T Nout simout] = sim('lotk');
% traiettoria
 %figure(1); clf;
 %plot(Nout(:,1),Nout(:,2),'b'); axis tight;
% evoluzioni
 %figure(2); clf;
 %plot(T,Nout(:,1),'b'); hold on;
 %plot(T,Nout(:,2),'r'); axis tight;
disp('Tre punti, K1 = 800');
[Aeq_a Beq_a Ceq_a Deq_a] = linmod('lotk', Neq_a); Aeq_a
[avect_a aval_a] = eig(Aeq_a); aval_a
[Aeq_b Beq_b Ceq_c Deq_c] = linmod('lotk', Neq_b); Aeq_b
[avect_b aval_b] = eig(Aeq_b); aval_b
[Aeq_c Beq_c Ceq_c Deq_c] = linmod('lotk', Neq_c); Aeq_c
[avect_c aval_c] = eig(Aeq_c); aval_c

pause;
%% TRE PUNTI, K1 = 4000
e1 = 40; e2 = 10; e = 0.1; p = 0.2; K1 = 4000;

%Neq_a = [0; 0]; Neq_b = [500; 120]; Neq_c = [800; 0];
Neq_a = [0; 0]; 
Neq_b = [e2/(e*p); (e1/p)*(1-e2/K1)]; 
Neq_c = [K1; 0];

% simula sistema non lineare
[T Nout simout] = sim('lotk');
% traiettoria
 %figure(1); clf;
 %plot(Nout(:,1),Nout(:,2),'b'); axis tight;
% evoluzioni
 %figure(2); clf;
 %plot(T,Nout(:,1),'b'); hold on;
 %plot(T,Nout(:,2),'r'); axis tight;
disp('Tre punti, K1 = 4000');
[Aeq_a Beq_a Ceq_a Deq_a] = linmod('lotk', Neq_a); Aeq_a
[avect_a aval_a] = eig(Aeq_a); aval_a
[Aeq_b Beq_b Ceq_b Deq_b] = linmod('lotk', Neq_b); Aeq_b
[avect_b aval_b] = eig(Aeq_b); aval_b
[Aeq_c Beq_c Ceq_c Deq_c] = linmod('lotk', Neq_c); Aeq_c
[avect_c aval_c] = eig(Aeq_c); aval_c