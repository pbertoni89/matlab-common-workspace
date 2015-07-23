clc, clear

% .
% x1 =     x1 + 2x2 + 2w1 + u
% .
% x2 =     x1 + 2w1 + 3w2

% y  = 0.5 x1 + x2 + v


%      Matrici di covarianza dei disturbi. Sulla diagonale sempre le vari!
Rv = 0.001;
Rw = [.001 0;0 .01];

% formuliamo la teoria con un x0 che è V.V.C. con media e varianza noti.
% però nell'esercizio è richiesto di simulare partendo da IC nulle.

%      Modello lineare dinamico
A=[1 2;1 0]; Aeigs = eig(A)
xEQ = [0; 0];
x0 = [0; 0];

B = [1; 0];
C = [.5 1];
D = 0;
G = [2 0;2 3]; %WRN: G ha la stessa dimensione di A (w ha due componenti)

% Matrici dei pesi per il progetto di controllo ottimo
% Alzando Q rispetto a R prediligo la minimizzazione dello STATO
% permettendo di spendere più energia nel controllo e viceversa.
Q = eye(2);
R = eye(1);

%% Ipotesi per il filtro di Kalman
%   (A,B) è raggiungibile (NECESSARIA PER CONTROLLO, NON PER STIMA DELLO STATO)
disp('(A,B): rank(R) =rank(A)=2 ?= '), rank(ctrb(A,B))
%   (A,C) è osservabile
disp('(A,C): rank(O) =rank(A)=2 ?= '), rank(obsv(A,C))
%   (A,G) è raggiungibile
disp('(A,G): rank(R) =rank(A)=2 ?= '), rank(ctrb(A,G))
%   w(t) e v(t) sono processi stocastici bianchi con nuclei di covarianza noti:
%      E[w(t) wT(t)]=Rw δ(t-τ) Rw>0
%      E[v(t) vT(t)]=Rv δ(t-τ) Rv>0
% questo è garantito se si simula con il blocco "white noise"

%   w(t) e v(t) sono processi stocastici mutuamente incorrelati
% bisognerebbe cambiare il seed dei blocchi... discorso pseudopseudo
%   x0 è un vettore aleatorio con valor medio e covarianza noti (*)
%   i PS w(t) e v(t) sono incorrelati con il vettore aleatorio x0
% nella simulazione alle fin delle finite si fissa x0 quindi va sempre bene

%% Calcolo matrici per il controllo
[L,P,E1] = lqe(A,G,C,Rw,Rv);		%L = Kalman estimator gain
disp('guadagno del filtro ricostruttore di Kalman:'), L
disp('eq differenziale di Riccati:'),P
disp('eig(A-LC):'), E1
[K,S,E2] = lqr(A,B,Q,R);			%K = Feedback gain
disp('guadagno di retroazione LQR:'), K
disp('eq algebrica di Riccati:'), S
disp('eig(A-BK):'), E2
% l'inverso dell'autovalore più pesante è la costante di tempo...
% noi qua stiamo facendo approccio statico (NON dyn) a filtro di Kalman:
%   difatti K è costante nel tempo!
%L(2) = -100; K(1) = 100; mie stupidate perturbanti

%% Commenti su LQE
%  Kalman estimator design for continuous-time systems.
%         .
%         x = Ax + Bu + Gw            {State equation}
%         y = Cx + Du + v             {Measurements}
%  
%     unbiased noises w (process) and v (measurement) with covariances
%  
%         E{ww'} = Q,    E{vv'} = R,    E{wv'} = N ,
%  
%     [L,P,E] = lqe(A,G,C,Q,R,N)  returns the observer gain matrix L
%     such that the stationary Kalman filter
%         .
%         x_e = Ax_e + Bu + L(y - Cx_e - Du)
%  
%     produces an optimal state estimate x_e of x using the sensor
%     measurements y.  The resulting Kalman estimator can be formed
%     with ESTIM.
%  
%     The noise cross-correlation N is set to zero when omitted.  
%     Also returned are the solution P of the associated Riccati 
%     equation
%                              -1
%         AP + PA' - (PC'+G*N)R  (CP+N'*G') + G*Q*G' = 0 
%  
%     and the estimator poles E = EIG(A-L*C).

%% Commenti su LQR
%  Linear-quadratic regulator design for state space systems.
%  
%     [K,S,E] = lqr(SYS,Q,R,N) calculates the optimal gain matrix K
%     such that:
%  
%       * For a continuous-time state-space model SYS, the state-feedback
%         law u = -Kx  minimizes the cost function
%  
%               J = Integral {x'Qx + u'Ru + 2*x'Nu} dt
%  
%         subject to the system dynamics  dx/dt = Ax + Bu
%  
%       * For a discrete-time state-space model SYS, u[n] = -Kx[n] minimizes
%  
%               J = Sum {x'Qx + u'Ru + 2*x'Nu}
%  
%         subject to  x[n+1] = Ax[n] + Bu[n].
%  
%     The matrix N is set to zero when omitted.  Also returned are the
%     the solution S of the associated algebraic Riccati equation and
%     the closed-loop eigenvalues E = EIG(A-B*K).
%  
%     [K,S,E] = lqr(A,B,Q,R,N) is an equivalent syntax for continuous-time
%     models with dynamics  dx/dt = Ax + Bu

%% Poli del Sistema Complessivo
% sono quelli di A-BK!!!!!!!!!! il ricostruttore di Kalman non intacca lo
% stato

%% Simulazione a fronte di ingresso rect
% l'uscita y del sistema ha un picco di 4.586

% l'innovazione ha un picco di |-0.32|

% x2-x2' ha un picco di |-0.164|

%% OBS Prof finali
% tecnica di filtraggio alla kalman è tecnica di Stima dello Stato;
% NON di controllo sul sistema. in questo esercizio è addirittura sbagliato
% riportare (e chiedere come ipotesi) la raggiungibilità di AB
% CHECK domanda precisa sul pdf: si chiede ...Kalman per la RICOSTRUZIONE
% dello stato; NON per anche il CONTROLLO. nella pratica il punto seguente
% chiede di fare il controlo alla Kalman.

% la matrice di covarianza dell'errore di stima È l'equazione algebrica di
% Riccati..... da LQE (ma quindi non è l'eq diff????)

% viene chiesto se l'ingresso del S sta o no in modulo |15|: è ciò che sta
% a monte della moltiplicazione per B. sembra valere in picco |-19.3|
% quindi sembrerebbe che il controllo ottimo non possa soddisfare questo
% vincolo; il problema ristretto a questo vincolo genera ....(???)

% autoval=[-20 -40]; % sono troppo veloci per il sistema.
% esso continua a oscillare nel controllo, spendendo energia enorme.
% l'uscita non diverge, ma a che costo!
% autoval = [-.2 -.4]; %troppo lenti per il sistema. Il controllo diventa
%  troppo lento e stupido e cresce inaccettabilmente; l'uscita in questo
%  caso pure lei si comporta male e cede alla divergenza per poi recuperare
%  quando il controllo ha recuperato.

K = place(A,B,autoval);
disp('guadagno di retroazione Place puntof:'), K
disp('eig(A-BK):'), eig(A-B*K)
