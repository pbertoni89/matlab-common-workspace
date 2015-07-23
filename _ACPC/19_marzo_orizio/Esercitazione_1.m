%% Controllo Classico CC vs Controllo Ottimo CO in un Problema P su Funzione Obiettivo J

% Il focus è la definizione di J per il CO, 
% dando maggior peso alla parte più importante per il P sotto studio.
% (es. robotino mandato su Marte ed atterrato in una buca: studiare
% l'azione di controllo per uscire dalla buca usando la minima energia)
% CO dipende da P a P.
% E' difficile stabilire il miglior controllore tra diversi che rispettano
% le specifiche.
% Ponendo una J comune a tutti i controllori, è possibile individuarne 
% una migliore tra esse: si dice che il P di controllo è ben posto.

% A confronto del CC, dove si calcolano prima gli eigs e poi la matrice K, 
% nel CO si calcola prima K e poi gli eigs, in quanto le specifiche del P 
% sono espresse in termini di "min J", non traducibili in eigs.
% Si dice che il CC progetta per la stabilità 
% (passando dagli eigs controllo infatti anche la stabilità), 
% mentre il CO progetta per prestazioni 
% (infatti spesso gli eigs generati sono complessi coniugati, 
% con oscillazioni in fase transitoria)

% Nel CC si pongono gli eigs a 10 volte gli eigs_desiderati, così da avere 
% osservazioni in tempi utili.
% Lavorando in campo deterministico, bisogna controllare anche dei limiti
% fisici ( 10 * lambda(A-BK) sia accettabile )
% >>place: pone gli autovalori dove ci servono
% [K,S,E] = lqr(A,B,Q,R)
%  - K: guadagno del regolatore in modo che la retroazione minimizzi J,
%    Matrice del controllo ottimo a regime
%  - E: eigs della matrice (A-BK)
%  - S: soluzione dell'eq.alg. di Riccati associata al P di CO dato

% Questo nel caso in cui la cifra di merito sia in x.
% Se volessimo la cifra di merito in y, basta sostituire ad y = Cx,
% riportando il problema ad una J in x e lanciare il
% comando: lqr( A, B, C'QC, R ).
% Attenzione alla matrice Q ed alle sue dimensioni!
% NB! In teoria (con la Finzi) lavoriamo sulla matrice ( A + BK ), ma
% MATLAB lavora con ( A - BK )!

% NB! EVOLUZIONE LIBERA => INGRESSO NULLO!

close all; clear, clc

% Matrici del sistema
A = [-1,-5;7,-2]
B = [1;0]
C = [1,1]

R = 1;
Q = eye(2);

x0 = [5,5];
ueq = 0; % mov libero!

% xeq quando Ax + Bu = 0 => 
xeq = -inv(A) * B * ueq
autoval = eig(A)

% Controllo che il sistema sia controllabile
% ctrb( A, B ): matrice di controllabilità
Rc = rank(ctrb(A,B))
% Controllo che il sistema sia osservabile
% obsv( A, C ): matrice di osservabilità trasposta
Ro = rank(obsv(A,C))

% ctrb ed obsv pongono nelle prima rank colonne i vettori L.I.

% NB! La parte NR influenza la parte R e i suoi eigs influenzano la velocità
% del sistema stesso: sistemi controllabili.
% Se il rango della matrice R non è massimo => esiste NR non nulla,
% ma il sistema può essere comunque controllato. la matr K non sempre esiste 
% (esiste almeno una n-pla di autovalori per cui K non esiste).

% NB! L'unione degli autovalori delle matrici R e NR formano gli autovalori
% del sistema iniziale!

% Calcolo la matrice dei guadagni K ( A - BK )
%  Linear-quadratic regulator design for state space systems.
[K,P,E] = lqr(A,B,Q,R);

% Setto gli autovalori della matrice L ( A - LC )
% Autovalori di ( A - LC ) = autovalori di ( A - LC )' = 
% autovalori di A' - C'L'
% da qui esce il trasposto inserito nella formula.
L = place( A', C', 10*E )'
% Avremmo potuto cercare un fattore che rendesse gli eigs non degeneri.