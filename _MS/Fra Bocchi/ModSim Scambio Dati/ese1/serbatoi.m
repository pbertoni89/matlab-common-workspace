clc;
close all;
clear all;

% x1 livello del serbatoio 1
% x2 livello del serbatoio 2

% serbatoio 1
% u portante entrante
% k1*x1 portata uscente
% S1 area del serbatoio
% S1*Dx1=u-k1*x1
% Dx1=u/S1-k1/S1*x1

% serbatoio 2
% k1*x1 portante entrante
% k2*x2 portata uscente
% S2 area del serbatoio
% S2*Dx2=k1*x1-k2*x2
% Dx2=k1/S2*x1-k2/S2*x2

% portata uscente dal 2 = uscita
% y=k2*x2

s1=1;
s2=1;
k1=0.5;
k2=0.8;
ueq=1;
x0=[1;1];

% Dx1=u/S1-k1/S1*x1
% Dx2=k1/S2*x1-k2/S2*x2
A=[-k1/s1 0;k1/s2 -k2/s2];
B=[1/s1;0];
%y=k2*x2
C=[0 k2];
D=0;

% Calcolare il punto di equilibrio del sistema
% Dx=0 -> Dx=A*x+B*u=0 -> A*x=-B*u
% x=-inv(A)*B*u se det(A) diverso da 0
if det(A)==0
    disp('non si può calcolare xeq')
else
    xeq=-inv(A)*B*ueq
end

% simulare il sistema
sys=ss(A,B,C,D); %def. sistema
x0=[1 1]'; %def. stato iniziale
t=(0:0.01:100)'; %def. tempo simulaz.
u=ueq*ones(size(t)); %def. ingresso

[y,t,x] = lsim(sys,u,t,x0); %simula il sistema

% Tracciare i movimenti delle variabili di stato
plot(t,x)

% Tracciare il movimento dell'uscita
figure
plot(t,y)

% Tracciare la traiettoria
figure
plot(x(:,1),x(:,2))