clear all;

Rv = 0.001;
Rw = [0.001 0;0 0.01];

A=[1 2;1 0];
eig(A)
B=[1 0]';
C=[0.5 1];

D=0;
G = [2 0;2 3];

%      Matrici dei pesi per il progetto di controllo ottimo
Q = 1;
R = 1;
rank (ctrb(A,B)) % ipotesi per calcolo legge di controllo
rank (obsv(A,C)) 
rank (ctrb(A,G))

[L,P,E1] = lqe(A,G,C,Rw,Rv)	
[K,S,E2] = lqr(A,B,C'*Q*C,R)

%      Schema Simulink
es1_sim


