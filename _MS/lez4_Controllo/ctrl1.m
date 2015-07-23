clc, clear, close all

A = [2 3; 4 1];
B = [1 0]';
C = [1 0];  % � una riga porca loca!!!!!!!!!!!1
D = 0;

ueq = 1;
x0 = [1; 1];

        % k = 2;
        % M = 1;
        % h = .5;

        % A = [0 1; -k/m -h/m];
        % B = [0 1/m]';
        % C = [1 0];
        % D = [0];

%1) equilibrio
if det(A)~=0
	xeq = -inv(A)*B*ueq;
else
	disp('non esiste equilibrio');
end
%2) stabilit�

% dx = A*x + B*u
%  y = C*x + D*u

%3) Stabilizzare il sistema in modo che arrivi a regime in 1 secondo
t_reg = 1;

L1 = -5/t_reg; % autovalore dominante desiderato
L2 = 5*L1;

lambdas = [L1 L2];

% wrn, spesso in letteratura lo scostamento viene definito come xeq-x

%dobbiamo modificare il sistema. invece di mettere una u costante, metto
% u = K*(x-xeq) + ueq;
%che esprime la lontananza dall'equilibrio. d'altronde x=xeq => u=ueq

% per la scelta degli autovalori, evitare come la peste autovalori
% molteplici.

% dx = A*x + B*(K*(x-xeq)+ueq)
% dx = (A-B*K)*x + B*(-K*xeq+ueq)

%dx=Ax+B*(K(xeq-x)+ueq) --> dx=(A-Bk)x +b(Kxeq+ueq)
%A_new=A-Bk
%B_new=B(-kxeq+ueq)
%
%dx=A_new*x+Bu

%in matlab per calcolare K bisogna fare Kvero = -KveroMatlab

%ora gli autovalori di A_new dovrebbero essere [l1 l2]
%per quali valori di K gli autovalori della matrice A+Bk sono L1 e L2 ?
%problema di algebra risolvibile

% eigs(A+B*K) = lambdas
% A+B*K = [2 3; 4 1] + [1 0]'*[k1 k2]
% A+B*K = [2 3; 4 1] + [k1 k2; 0 0]
% A+B*K = [2+k1 3+k2; 4 1]
% det( eigs(A+B*K)*eye(2) - (A+B*K) ) = 0
% det( [L1-2-k1 -3-k2; -4 L2-1] ) = 0
% ... 
% polinomio di A+B*k
%	L^2 - (-2-K1-1)*1+2+K1-12-4*K2=0
% polinomio desiderato
%	(l-l1)*(l-l2)=0
%	l^2+(-l1-l2)*l+l1*l2=0
%
% da cui:
% (-2-k1-1)=(-L1-L2)
% L1*L2=(2+k1-12-4*k2)

% cioe'
k1 = -3 + L1 + L2;
k2 = (2+k1-12-L1*L2)/4;
K = [k1 k2]

% Oppure Matlab mette a disposizione:
Kplace = place(A, B, lambdas)
% Wrn, si dice che un baco numerico esploda se ci sono autoval uguali
% I K ottenuti sono tali che Kplace = - Kdesiderati


% Non sempre e' possibile porre uguaglianze con gli autovalori desiderati:
% questi sistemi hanno probabilmente una parte non raggiungibile.
% allora occorre farlo prima questo lavoro!
% mettere PRIMA i seguenti comandi:
%	R = [ B A*B];
%	if(det(R)==0)
%	disp('sistema non completamente raggiungibile');
%	end

% Finalmente simuliamo il sistema con Simulink.

% Osserviamo che si ha una specie di sovraelongazione all'inizio... ma non
% lo e' veramente, semplicemente partiamo da un x0 diverso dall'origine!!!
% e' come se volessi fermare una massa gi� in caduta => la sua posizione
% almeno all'inizio scende ancora un poco.
