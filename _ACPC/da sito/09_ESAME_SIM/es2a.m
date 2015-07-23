%Definizioni delle matrici per lo schema simulink relativo all'esercizio n°3

%      Modello lineare dinamico
A=[11 29;-5 -12];

B=[1 1]';
C=[1 0];
D=0;

%      Matrici dei pesi per il progetto di controllo ottimo
Q = 1;
R=1;
R = 0.01; 

%      Calcolo matrici per il controllo
eig(A)
rank(ctrb(A,B))
rank(obsv(A,C))
autoval=[-1+i -1-i];

L=place(A',C',10*autoval)'
K=place(A,B,autoval)

[K,S,E] = lqr(A,B,C'*Q*C,R)			%Feedback gain
L=place(A',C',10*E)
L=place(A',C',[-40 -50])'
%      Schema Simulink

es2_sim


