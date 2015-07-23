clear, clc

% non è fixed la J; non è un problema di CO, ma di autovalori (ModSim)
% a quel punto controllo rank(R) e uso place()

A=[41 81;-20 -40], eigA = eig(A)
B=[1; 1];
C=[6 11];
D=0;

% minimale, ma sufficiente a far schizzare il sistema a infinito
% all'inizio. recuperato, ma probabilmente il sistema si romperebbe!
%x0 = [.1; .1];
x0 = [0; 0];
xEQ = [0; 0];

disp('(A,B): rank(R) =rank(A)=2 ?= '), rank(ctrb(A,B))
% Tregime=5s => tau=1s => eig_dom = -1/1  => meglio < -1 => -0.5
% Im(eig_dom) = 0 perchè è chiesto non oscillante
autoval=[-0.5 -10]; % -10 è MENO dominante

K = place(A,B,autoval);
disp('guadagno di retroazione Place:'), K
disp('eig(A-BK):'), eig(A-B*K)

%%
Q = eye(2); 
R = eye(1);  %0.1 per punto 2c

% fissare arbitrariamente gli eigs dell'osservatore... siccome è tutto
% deterministico, uso le leggi vecchie, bastano che siano almeno 10 volte
% Puttanata!!! adesso È un problema di CO => uso un lqr (deterministico)
% tanto.. => A-LC non fornisce sicuramente l'eig dominante, e quindi non
% disturba l'andamento dello stato
[K,S,E] = lqr(A,B,Q,R);
L = place(A',C',10*E)';
disp('guadagno dell''osservatore Place:'), L
disp('eig(A-LC):'), eig(A-L*C)

%%
% "sia inferiore al 70% del regime"... il regime deve valere 1(=> .7)
% occorre spostare la cifra di merito verso x => (abbassare R comunque >0)
% => h in (0,1). questo significa che è più importante minimizzare
% l'energia dello stato che quella del controllo speso!
% y <= 15 in ogni istante
avals_puntoc = [-96 -97];
L = place(A', C', avals_puntoc)';
disp('guadagno dell''osservatore Place nel puntoc:'), L

R = .1*eye(1);
% essendo aval_obs = [-96 -97], ci riportiamo a accettarne come aval del
% sistema [-9.6 -9.7].

[K,S,E] = lqr(A,B,Q,R);
disp('guadagno di retroazione Place:'), K
