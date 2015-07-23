% Cambia solo la CIFRA DI MERITO da 6.m

clear, clc, close all
A=[-7 -12;-1 -3];
B=[1 1]';
C=[1 1];
D=0;

% WRN Nella cifra di merito in questo caso Q moltiplica y, 
% quindi Q è uno scalare (avendo il sistema una sola uscita)
% devo sempre poter sommare y'Qy + u'Ru
Q=eye(1);
R=eye(1);
% Passaggio da cifra di merito in y a cifra di merito in x
Qtild=C'*Q*C;

% Stabilità del sistema non retroazionato
autovet = eig(A)

% Verifica condizioni di controllabilità e osservabilità
Rc=rank(ctrb(A,B))
Ro=rank(obsv(A,C))

% Calcolo della matrice K di retroazione... NOTA: il comando è identifico a quello di es6.m, avendo effettuato la sostituzione
[K,S,E] = lqr(A,B,Qtild,R)
eig(A-B*K)

es6_sim