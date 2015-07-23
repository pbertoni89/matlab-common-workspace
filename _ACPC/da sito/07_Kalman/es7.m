clc, clear

%      Matrici di covarianza dei disturbi 
Rv = 0.01;
Rw = [0 0;0 0.01];

% formuliamo la teoria con un x0 che è V.V.C. con media e varianza noti.
% però nell'esercizio è richiesto di simulare partendo da IC nulle.
x0 = 0;

%      Modello lineare dinamico
A=[0 2;-4.5 -10];

B=[1 1]';
C=[1 1];
D=0;
G = [1 0;0 1]; %ATTENZIONE!!! G ha la stessa dimensione di A (w ha due componenti)

%      Matrici dei pesi per il progetto di controllo ottimo
Q = [1 0;0 1];
R = 1;

%      Calcolo matrici per il controllo
[L,P,E1] = lqe(A,G,C,Rw,Rv);		%L = Kalman estimator gain
disp('guadagno del filtro di Kalman:'), L
disp('eq differenziale di Riccati:'),P
disp('eigs(A-LC):'), E1
[K,S,E2] = lqr(A,B,Q,R);			%K = Feedback gain
disp('guadagno di retroazione:'), K
disp('eq algebrica di Riccati:'), S
disp('eigs(A-BK):'), E2
%L(2) = -100; K(1) = 100;
es7_sim

%% Ipotesi per il filtro di Kalman
%   (A,B) deve essere raggiungibile (NECESSARIA PER IL CONTROLLO, NON PER LA STIMA DELLO STATO)
%   (A,C) deve essere osservabile
%   (A,G) deve essere raggiungibile
%   w(t) e v(t) sono processi stocastici bianchi con nuclei di covarianza noti:
%      E[w(t) wT(t)]=Rw δ(t-τ) Rw>0
%      E[v(t) vT(t)]=Rv δ(t-τ) Rv>0
%   w(t) e v(t) sono processi stocastici mutuamente incorrelati
%   x0 è un vettore aleatorio con valor medio e covarianza noti (*)
%   i processi stocastici w(t) e v(t) sono incorrelati con il vettore aleatorio x0


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
