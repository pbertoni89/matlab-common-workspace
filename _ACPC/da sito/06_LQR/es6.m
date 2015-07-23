clear, close, clc
A=[-7 -12;-1 -3];
B=[1 1]';
C=[1 1];
D=0;

h = 10;
Q=eye(2);
R=h*eye(1);
%aumentando R invece si da piu' peso alla cifra di merito
% ma ciò che conta è il rapporto di peso Q/R
% con h=1000 non si vede più un cazzo: sto chiedendo al obsv di esser
% troppo veloce
% con h=10 supero i 0.15 dell'ultima parte della consegna
% con h=100 è buono

ueq=0;
X0=[1 1];
X0obsv = [0 0];

% Calcolo del punto di equilibrio
xeq=-inv(A)*B*ueq
            
% Studio della stabilia'  del sistema non retroazionato
autovet = eig(A)

% Verifica condizioni di controllabilitÃ  e osservabilitÃ 
Rc=rank(ctrb(A,B))
Ro=rank(obsv(A,C))

% Calcolo della matrice di retroazione K che minimizza la cifra di merito considerata
[K,S,E] = lqr(A,B,Q,R) % K,P,E ha scritto a lezione

% Verifica del posizionamento dei poli del sistema retroazionato
fprintf('eig(A-B*K) = %f \n',eig(A-B*K))

% Calcolo dei guadagni dell'osservatore; 
% eigs(A-LC) devono essere posizionati una decade piu' a destra di eigs(A-BK) 
% in modo che l'obs sia in grado di riprodurre la dinamica del S
L=place(A',C',10*E)'
% se aumento quel 10, chiedo un obs sempre più veloce e sempre piu'
% difficile da realizzare e sempre piu' instabile
% molti troncano la parte immaginaria di E perchè non sono interessati
% all'oscillazione in un regolatore. Ma questo genera due poli identici,
% (radice multipla) casino... al limite spostarne uno appena appena.
% sono tutte regole empiriche

es6_sim

% in ambiente deterministico, in assenza di specifiche chiare
% sull'osservatore (i suoi poli), potrei disaccoppiare
% totalmente i progetti di regolatore e controllore

% se cifra di merito è in x e u, Q e R devono essere in due forme
% quadratiche sommabili tra loro. 
% se Sistema single input => Q quadrata, R scalare

%nei sistemi determinstici mettere le condizioni iniziali solo alla fine
%quando accendo la macchina di solito non conosco lasua temperatura!!

% nella realtà coi SnL si fa:
% trovo pto di equilibrio
% costruisco linearizzato
% nell'osservatore uso il linearizzato



Rw = [0 0;0 0.01]; % per provare a disturbare con rumore