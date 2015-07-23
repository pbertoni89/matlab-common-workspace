clear all;
close all;
clc;
format compact 

A=[2 3;4 1];
B=[1;0];
C=[1 0];
D=0;

ueq=1;
x0=[1;1];

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

%% 3)Stabilizzare il sistema in
%% modo che si stabilizzi in 
%% 1 secondo
t_asses=1;
l1=-5/t_asses; %dominante
l2=5*l1; 
aval_desiderati=[l1 l2];

% det(R)~=0
R=[B A*B];
if det(R)==0
    disp('sistema non è completamente')
    disp('raggiungibile')
else

%u=K*(x-xeq)+ueq;
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
k1=-3+l1+l2;
k2=(2+k1-12-l1*l2)/4;
K=[k1 k2];
eig(A+B*K)

K=-place(A,B,aval_desiderati)

% simulare il sistema
end