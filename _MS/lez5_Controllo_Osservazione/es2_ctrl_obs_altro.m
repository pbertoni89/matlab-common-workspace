clear all; close all; clc;
format compact 

A=[2 3;4 1];
B=[1;0];
C=[1 0];
D=0;

ueq=1;
x0=[1;1];

%% 1) equilibrio
if det(A)~=0
    xeq = -inv(A)*B*ueq;
else
    disp('non esiste equilibrio oltre l''origine');
    xeq=[0;0];
end
%% 2) stabilità

% dx=A*x+B*u
% y=C*x+D*u
[avet,aval]=eig(A); aval

%% 3)Stabilizzare il sistema in T = 1 secondo
t_des=1;
L1=-5/t_des; %dominante
L2=5*L1; 
aval_des=[L1 L2];

% det(R)~=0
R=[B A*B];
if det(R)==0
    disp('sistema non è completamente raggiungibile')
else
	%u=K*(x-xeq)+ueq;
	% dx=A*x+B*(K*(x-xeq)+ueq)
	% dx=(A+B*K)*x+B*(-K*xeq+ueq)
	% autovalori(A+B*K)=[L1 L2]
	% A+B*K=[2 3;4 1]+[1;0]*[k1 k2]
	%          2x2     2x1  1x2
	% A+B*K=[2 3;4 1]+[k1 k2;0 0]
	% A+B*K=[2+k1 3+k2;4 1]
	% det(lambda*I-(A+BK))
	% det([L 0;0 L]-[2+k1 3+k2;4 1])
	% det([L-2-k1 -3-k2;-4 L-1])
	% (L-2-k1)*(L-1)-(-3-k2)*(-4))=0
	%
   % polinomio di A+B*K
	% L^2+(-2-k1-1)*L+2+k1-12-4*k2=0
   % polinomio desiderato
	% (L-L1)*(L-L2)=0
	% L^2+(-L1-L2)*L+L1*L2=0
	% 1=1
	% (-2-k1-1)=(-L1-L2)
	% 2+k1-12-4*k2=L1*L2
	%
	% k1=-3+L1+L2
	% k2=(2+k1-12-L1*L2)/4
	k1=-3+L1+L2;
	k2=(2+k1-12-L1*L2)/4;
	K=[k1 k2]
	[avet_ctrl aval_ctrl] = eig(A+B*K); aval_ctrl
	Kmatlab=-place(A,B,aval_des)
end

fprintf('\n\n');
%% 4) Osservabilità
% det(lambda*I-(A+L*C))=0 -> L1o L2o
% osservatore più veloce del sistema
% L1o=10*L1 L2o=10*L2
aval_obs_des = 0.10 * aval_des;

OBS = [C' A'*C']; %OBS2=[C;C*A] OBS2=OBS'
if det(OBS)==0 %rank(OBS)<2
	fprintf('sistema non è completamente osservabile');
else
	L_OBS=-place(A',C',aval_obs_des)'
	%det(lambda*I-(A+L*C))=0 L=[L1;L2]
	% polinomio di A+L*C
	% polinomio desiderato
end

[T xout simout] = sim('sis_ctrl_obs');