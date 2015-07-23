clc, close, clear all

A = [-1.9 -1.2 -1.9;-1.9 -2.2 -0.9;2.1 1.8 1.1]
B = [0.4 0.4 -0.6]'
C = [0 0 1]
ueq = 3;
x0 = [0 0 0];

xeq = -inv(A)*B*ueq
avals = eig(A)

R = ctrb(A,B);
rankR = rank(R)

% Controllo se lo stato [1 2 1] e' raggiungibile:
R_ok = R(:,1:rankR) 
% è la base del sottospazio XR, cioè colonne L.I. di R

xdes = [1 2 1];
appartiene = rank([R_ok xdes'])
% e quindi xdes NON appartiene allo span di XR, siccome aggiunge una
% dimensione a R_ok.

T = inv([R_ok [1 1 3]'])
A_star = T*A*inv(T)
B_star = T*B

% Nota: Questa trasformazione evidenzia come, in questo sistema di
% coordinate, la terza componente dello stato non sia modificabile ne
% direttamente ne indirettamente attraverso l'ingresso =>
% rappresenta una parte del sistema che non può essere controllata.

es2a_sim
