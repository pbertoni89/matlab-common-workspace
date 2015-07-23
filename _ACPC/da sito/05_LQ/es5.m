clear all
A=[-1 -5;7 -2];
B=[1 0]';
C=[1 1];
D=0;
ueq=0;
X0=[5 5];

% Introduzione matrici della cifra di merito
Q=eye(2);
R=eye(1);

% Calcolo punto di equilibrio e verifica stabilità del sistema
xeq=-inv(A)*B*ueq
[autovet autoval]=eig(A)

% Verifica delle condizioni di raggiungibilità e osservabilità
Rc=rank(ctrb(A,B))
Ro=rank(obsv(A,C))

% Calcolo delle matrice di retroazione K
[K,S,E] = lqr(A,B,Q,R)
eig(A-B*K)

% Piazzamento dei poli dell'osservatore: una decade più a sinistra di quelli di (A-BK)
aval_oss=10*E;
% Calcolo dei guadagni dell'osservatore
L=place(A',C',aval_oss)'

es5_sim
