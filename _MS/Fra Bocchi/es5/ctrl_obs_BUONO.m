clear all; close all; clc; format compact

A=[2 3;4 1];
B=[1;0];
C=[1 0];
D=0;

ueq=1;
x0=[1;1];
x0o=[0;0];

%% 1) equilibrio
if det(A)~=0
    xeq=-inv(A)*B*ueq;
else
    disp('non esiste equilibrio');
    xeq=[0;0];
end
%% 2) stabilità

% dx=A*x+B*u
% y=C*x+D*u
[avet,aval]=eig(A); aval

%% 3)Stabilizzare il sistema in 1 secondo
t_des=1;
L1=-5/t_des; %dominante
L2=5*L1;
aval_des=[L1 L2];

R=[B A*B];
if det(R)==0
    disp('sistema non è completamente raggiungibile')
else
    
    % u=K*(x-xeq)+ueq;
    % dx=A*x+B*(K*(x-xeq)+ueq)
    % dx=(A+B*K)*x+B*(-K*xeq+ueq)
    % autovalori(A+B*K)=[l1 l2]
    % A+B*K=[2 3;4 1]+[1;0]*[k1 k2]
    %          2x2     2x1  1x2
    % A+B*K=[2 3;4 1]+[k1 k2;0 0]
    % A+B*K=[2+k1 3+k2;4 1]
    % det(lambda*I-(A+BK))
    % det([l 0;0 l]-[2+k1 3+k2;4 1])
    % det([l-2-k1 -3-k2;-4 l-1])
    % (l-2-k1)*(l-1)-(-3-k2)*(-4))=0
    %
    %% polinomio di A+B*K
    % l^2+(-2-k1-1)*l+2+k1-12-4*k2=0
    %% polinomio desiderato
    % (l-l1)*(l-l2)=0
    % l^2+(-l1-l2)*l+l1*l2=0;
    %
    % 1=1
    % (-2-k1-1)=(-l1-l2)
    % 2+k1-12-4*k2=l1*l2
    %
    % k1=-3+l1+l2
    % k2=(2+k1-12-l1*l2)/4
    k1=-3+L1+L2;
    k2=(2+k1-12-L1*L2)/4;
    K=[k1 k2];
    eig(A+B*K)
    
    K=-place(A,B,aval_des)
    
    %% 4) Calcolo la matrice L dell'osservatore.
    % det(lambda*I-(A+L*C))=0 -> l1o l2o
    % osservatore più veloce del sistema
	% perchè? per stargli dietro..
    % l1o=10*l1 l20=10*l2
    aval_obs_des=0.10*aval_des;
    
    O=[C' A'*C']; %O2=[C;C*A] O2=O'
    if det(O)==0 %rank(O)<2
        disp('sistema non è completamente osservabile')
    else
        L=-place(A',C',aval_obs_des)'
        %det(lambda*I-(A+L*C))=0 L=[L1;L2]
        %% polinomio di A+L*C
        %% polinomio desiderato
    end
end

sim('sys_ctrl_obs_BUONO')