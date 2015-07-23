clear, clc

%      Modello lineare dinamico
A=[41 81;-20 -40]
B=[1 1]';
C=[6 11];
D=0;
x0 = [0;0];
xEQ = [0;0];

%      Matrici dei pesi per il progetto di controllo ottimo
Q=eye(2); 
R=1;  %0.1 per punto 2c


%      Calcolo matrici per il controllo
eig(A)
rank(ctrb(A,B))
rank(obsv(A,C))
autoval=[-1 -10];
K=place(A,B,autoval)


[K,S,E] = lqr(A,B,Q,R)	
L=place(A',C',10*E)
eigA_LC = eig(A-L'*C)
L=place(A',C',[-96 -97])'

es2_sim
esame2013mod_b