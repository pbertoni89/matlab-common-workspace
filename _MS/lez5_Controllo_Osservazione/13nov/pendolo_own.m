clear all; close all; clc;

m  = 1; 
L  = 1;
J  = m*L^2;
F1 = 1;
F2 = 0;
h  = 0.2; % coefficiente d'attrito; NON intuitivo -_-
x0 = [.1 0]';

%% 1) Equazioni

%	x1 posizione angolare; x2 velocità angolare
%	
%	{  J Dx2 = -F1*L*sin(x1) -F2*L*cos(x1) -h*x2
%	{  Dx1 = x2
%	riscrivo la prima (nulla di nuovo)
%	  Dx2 = -F1*L/J*sin(x1) -F2*L/J*cos(x1) -h/J*x2

%% 2) Equilibri & Linearizzazione

%	Dx1 = 0 -> x2 = 0
%	Dx2 = 0 -> -F1*L*sin(x1) -F2*L*cos(x1) = 0 
%				...  sin(x1) = 0

%	A = [                 0                   1;
%         -F1*L/J*cos(x1) +F2*L/J*sin(x1)   -h/J]

%	B = [          0                   0;
%             -L/J*sin(x1)      -L/J*cos(x1)]

eq1 = [0;0];
Aeq1=[0 1; -1*L/J -h/J]
Beq1=[0 0; 0 -L/J]

eq2 = [pi;0];
Aeq2=[0 1; 1*L/J -h/J];
Beq2=[0 0; 0 L/J];

C = [1 0];
D = [0 0];

[Alin1 Blin1 Clin1 Dlin1] = linmod('sis_pendolo_ctrl_oss', eq1);
Alin1
Blin1
% autovec autoval
[avec1 aval1] = eig(Aeq1);
aval1
% simula
[T xout simout] = sim('sis_pendolo_ctrl_oss');
	
%% 4) Controllore
tau_des = 1;
L1 = -5/tau_des;
L2 = 5*L1;
aval_des = [L1 L2]

%% 5) Raggiungibilità dell'equilibrio 1  (0,0)
% considero solo F1 e spengo F2 (cosa che avviene per i val scelti)
Beq1_F1 = Beq1(:,1);
Aeq1_F1 = Aeq1*Beq1_F1;
Req1_F1 = [Beq1_F1 Aeq1_F1];
if rank(Req1_F1)~=0
	Keq1_F1 = -place(Aeq1,Beq1_F1,aval_des) % - di matlab
else
	disp('controllo tramite F1 su eq1 non possibile.');
end
% Ra = matrice nulla. 
% che senso fisico ha? sto tirando parallelamente alla cerniera..

% considero solo F2 e spengo F1
Beq1_F2 = Beq1(:,2);
Aeq1_F2 = Aeq1*Beq1_F2;
Req1_F2= [Beq1_F2 Aeq1_F2];
if rank(Req1_F2)~=0
	Keq1_F2 = -place(Aeq1,Beq1_F2,aval_des) % - di matlab
else
	disp('controllo tramite F2 su eq1 non possibile.');
end

%% 6) Osservatore eq1
x0o = [0 0]';