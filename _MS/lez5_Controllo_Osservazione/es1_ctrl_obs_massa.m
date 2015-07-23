clear all; close all;clc;
format compact 

k=2;
M=1;
h=0.5;

A=[0 1;-k/M -h/M];
B=[0;1/M];
C=[1 0];
D=0;
ueq=3;
x0=[1;0];
t_des=2;

%% 1) equilibrio
if det(A)~=0
    xeq=-inv(A)*B*ueq;
else
    disp('non esiste equilibrio');
    xeq=[0;0];
end
%% 2) stabilità
[avet,aval]=eig(A);

% dx=A*x+B*u
% y=C*x+D*u

%% 3)Stabilizzare il sistema T = 1 secondo
L1=-5/t_des; %dominante
L2=5*L1; 
aval_des=[L1 L2];

% det(R)~=0
R=[B A*B];
if det(R)==0
    disp('sistema non è completamente raggiungibile')
else
    K=-place(A,B,aval_des)
    % simulare il sistema

	%% 4) Calcolo la matrice L dell'osservatore.
    % det(lambda*I-(A+L*C))=0 -> L1o L2o
    % osservatore più veloce del sistema
    % L1o=10*L1 L2o=10*L2
    aval_oss_des = 0.10 * aval_des;
    
    OBS = [C' A'*C']; %OBS2=[C;C*A] OBS2=OBS'
    if det(OBS)==0 %rank(OBS)<2
        disp('sistema non è completamente osservabile')
    else
        L=-place(A',C',aval_oss_des)'
        %det(lambda*I-(A+L*C))=0 L=[L1;L2]
        % polinomio di A+L*C
        % polinomio desiderato
	end
end