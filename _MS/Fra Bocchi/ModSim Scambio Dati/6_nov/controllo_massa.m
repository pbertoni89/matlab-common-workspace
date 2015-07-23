clear all;
close all;
clc;
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
t_asses=2;

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

%% 3)Stabilizzare il sistema in
%% modo che si stabilizzi in 
%% 1 secondo
l1=-5/t_asses; %dominante
l2=5*l1; 
aval_desiderati=[l1 l2];

% det(R)~=0
R=[B A*B];
if det(R)==0
    disp('sistema non è completamente')
    disp('raggiungibile')
else
    K=-place(A,B,aval_desiderati)
    % simulare il sistema
end