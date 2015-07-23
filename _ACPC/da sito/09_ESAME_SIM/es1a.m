%Definizioni delle matrici per lo schema simulink relativo all'esercizio n°3

%      Matrici di covarianza dei disturbi 
Rv = 0.001;
Rw = [0.1 0;0 0.01];
%      Modello lineare dinamico
A=[-5 -11;4 7];

B=[1 1]';
C=[1 0];
D=0;
G = [1 2;1 0];

%      Matrici dei pesi per il progetto di controllo ottimo
Q = [1 0;0 1];
R = 1;
rank (ctrb(A,B)) % ipotesi per calcolo legge di controllo
rank (obsv(A,C)) 
rank (ctrb(A,G))


%      Calcolo matrici per il controllo
[L,P,E1] = lqe(A,G,C,Rw,Rv)		%Kalman estimator gain
[K,S,E2] = lqr(A,B,Q,R)			%Feedback gain

%      Schema Simulink
es1_sim


