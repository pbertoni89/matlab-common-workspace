%% Esercizio 1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear all; close all; clc;

na=4; nb=32; N = (na:nb)';
KA = zeros(nb-na, 1);

for n=na:nb;
	[A, ~] = lap_q1(n);
	KA(n-na+1) = cond(full(A));
end

figure(); clf;
loglog(N, KA, 'r', N, N, 'b', N, N.^2, 'g', N, N.^3, 'k');
legend('KA','N','N^2','N^3');
grid on; title('Condizionamento di A confrontato con N');

% mi interessa capire KA a chi assomiglia di più????
%			KA(n) ~ Cn, Cn^2 o Cn^3 ?
% ha lo stesso ordine d'infinito del quadrato.
	%asynt = KA./(N.^2);
	%figure(); clf;
	%plot((na:nb)', asynt); title('Dimostro che KA(n) ~ n^2');

% 2
dx = KA(length(KA)-2)*eps; % 32-2=30 da consegna
fprintf('l''errore su soluz esatta, n=30 è al più %1.20f\n\n', dx);

% 3
figure(3); clf;
spy(A); title('trama di A');
disp('test simmetria');
if isequal(A,A')==1
	fprintf('A è simmetrica!!\n');
else
	fprintf('A non è simmetrica!!\n');
end
disp('test SDP');
tic
if is_sdp(A)==1
	fprintf(' A è SDP\n')
else
	fprintf('A non è SDP\n')
end
toc
disp('test DDS');
tic
if is_dds(A)==1
	fprintf(' A è DDS\n')
else
	fprintf('A non è DDS\n')
end
toc

%cholesky ok
% G e CG ok se A è SDP e per quello devo vedere gli eigs
%calcolo eigs pesante => uso chol()
            
%chol(A) non da warning => A SDP => possibili quasi tutti i metodi
 
%Diretti:    meg,LU ~ 2/3 n^3 
%			 chol   ~ 1/3 n^3 (symm) =)
%                 
%Iterativi:  Jacobi       SI  (dds)
%            GS           SI  (dds or sdp)
%            Rich staz    SI   con alpha opportuno
%            Grad         SI  (sdp)
%            Grad conj    SI  (sdp)
%                        
%Utilizzo Memoria 
%	diretti: modifico matrice quindi richiedo più memoria fil-in
%	iterativi: sfrutto solo elem diversi matrice =)
%	Per responso più accurato, si calcolino manualmente le dimensioni
%	con >>who o dalla vista del workspace
% 
% 4 
%Utilizzo CPU 
%  effettuo delle benchmark.
% Risolvere Ax = b con i metodi diretti e/o iterativi
% che si conoscono e che possono essere applicati, fissando
% n=12,  x0=rand(ndim,1)
% nmax=1000, tol=1.e-10        (per gli iterativi)
% Commentare i risultati ottenuti.

clear all; clc; close all;
n=12; fprintf('n= %d\n',n);
[A,b]=lap_q1(n); whos A
tol=1.e-10;
itmax = 1000;
ndim = n^2-4*(n-1);  % = size(A,1) = size(A,2)
x0 = rand(ndim,1);

% Diretti ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
t1=cputime;
[L,U,P]=lu(A); whos L U P
y=L\(P*b);
x=U\y;
t2=cputime; clear y
fprintf('fatt LU, CPU time=%1.30f\n',t2-t1);
%~~~~~~~~~~
t1=cputime;
R=chol(A); whos R
x=R\(R'\b);
t2=cputime; clear R
fprintf('Choleskij, CPU time=%1.30f\n',t2-t1);
% Iterativi ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
t1=cputime;
[x,relres,iter_G,resvec_G]= itermeth1(A,b,x0,itmax,tol);
t2=cputime;
fprintf('G, CPU time=%1.6f\n',t2-t1);
%~~~~~~~~~
t1=cputime;
[x,flag,relres,iter_CG,resvec_CG]=pcg(A,b,tol,itmax,[],[],x0); 
t2=cputime;
fprintf('CG, CPU time=%1.6f\n',t2-t1);
%~~~~~~~~~
t1=cputime;
droptol = 1.e-2; %droptol=0 degenera in chol
%      ->0, precond efficiente ma oneroso da calcolare (tradeoff)
% ruolo del precondizionatore è fare sì che K(invP.A) < K(A)
Rt = cholinc(A,droptol); whos Rt
[x,flag,relres,iter_PCG,resvec_PCG]=pcg(A,b,tol,itmax,Rt',Rt,x0); 
t2=cputime;
fprintf('PCG, CPU time=%1.6f\n',t2-t1);
disp('calcolo efficienza del precond P = Rt''*Rt');
disp('calcolo K(A)'); tic
KA = cond(A)
toc
disp('calcolo K(A\P)'); tic
KARt = cond(A\(Rt*Rt'))
toc
fprintf('K(A) / K(A\\P) = %3.2d\n', (KA/KARt)*100); clear Rt
%~~~~~~~~~~
t1=cputime;
[x,relres,iter_J,resvec_J]= itermeth1(A,b,x0,itmax,tol,'J');
t2=cputime;
fprintf('Jacobi, CPU time=%1.6f\n',t2-t1);
%~~~~~~~~~~
t1=cputime;
[x,relres,iter_GS,resvec_GS]= itermeth1(A,b,x0,itmax,tol,'G');
t2=cputime;
fprintf('Gauss Siedel, CPU time=%1.6f\n',t2-t1);
%~~~~~~~~~~
t1=cputime;
droptol = 1.e-2; %droptol=0 degenera in lu
%      ->0, precond efficiente ma oneroso da calcolare (tradeoff)
% ruolo del precondizionatore è fare sì che K(invP.A) < K(A)
[Lt, Ut] = luinc(A,droptol); whos Lt Ut
[~,~,~,~,resvec_BiCGStab]= bicgstab(A,b,tol,itmax,Lt,Ut,x0);
t2=cputime;
fprintf('BiCGStab, CPU time=%1.6f\n',t2-t1);
disp('calcolo efficienza del precond P = Lt*Ut');
disp('calcolo K(A\P)'); tic
KALU = cond(A\(Lt*Ut))
toc
fprintf('K(A) / K(A\\P) = %3.2d\n', (KA/KALU)*100); clear Lt Ut

%calcoli ASSURDI, è la MORTE.
% al limite posso calcolare gli autovalori di modulo max/min della
% matrice M = A\(Rt*Rt')  e poi Kpre = max|lambdaMi|/min|lambdaMi|

figure(5); clf;
semilogy(resvec_J,'b'); hold on;
semilogy(resvec_GS,'r');
semilogy(resvec_G,'g');
semilogy(resvec_CG,'y');
semilogy(resvec_PCG./norm(b),'k'); % da pdf
semilogy(resvec_BiCGStab(1:2:end),'c');

legend('Jacobi','GaussSiedel','G','CG','PCG','BiCGStab');

%% Esercizio 2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear all; close all; clc;
% 1
% lo schema è multistep esplicito p = 2
% a0=1 a1=0 a2=0 | b0=23/12 b1=-16/12 b2=5/12

% 2
dy  = @(t,y) 1./(1+t.^2)-2*y.^2;
yex = @(t)	 t./(1+t.^2);
t0 = 0; T  = 5; y0 = 0;

H = [1 .5 .1 .05 .01 .005 ];
cons = zeros(1,length(H)); % lista per le consistenze
conv = cons; % lista per le convergenze

for i=1:length(H)
	[ t y ] =  multiste2(t0,T,y0,dy,H(i)); t = t';
	
	subplot(3,2,i), plot(t,y,'r'), hold on, yEx = yex(t);
	plot(t,yEx,'g'), title(['h=',num2str(H(i))])
	if i==length(H), legend('multi2','y_{exact}'), end
	
	cons(i) = max((y-yEx)/H(i));
	conv(i) = max(abs(y-yEx));
end

figure(2);
plot(H,cons,'b'), title('consistenza'), xlabel('h')
% si ha consistenza, il valore asintotico è zero.

figure(3);
loglog(H, H.^1,'r');  hold on;
loglog(H, H.^2,'g'), loglog(H, H.^3,'b'), loglog(H, H.^4,'y');
loglog(H,conv,'k'); 
legend('h^1','h^2','h^3','h^4','conv');

% 3
% assoluta stabilita: consideriamo il solo movimento libero
p = 2; lambda = -10; N = 1000;
theta = linspace(0,2*pi,N); r = exp(1i*theta);
num = r.^(p+1)-r.^p; 
den = (23/11)*r.^p+(-16/12)*r.^(p-1)+(5/12)*p.^(p-2);
z = num./den;
H = exp(-(1:5)); retta = H*lambda;
figure('name','Assoluta Stabilità');
plot(z,'c'), hold on, plot(retta,zeros(1,length(retta)),'r')
disp('sperimentalmente si trova come step minimo');
H0 = (-0.5207-eps)/lambda
H = [ H0/2 H0 2*H0 ];
T = 1;
%dy = @(t,y) lambda*y-2; y0=1; yex = @(t) y0*exp(lambda*t)-t/5; 
dy = @(t,y) lambda*y; y0=1; yex = @(t) y0*exp(lambda*t); %libero

for i=1:length(H)
	[ t y ] =  multiste2(t0,T,y0,dy,H(i)); t = t';
	subplot(3,1,i), plot(t,y,'r'), hold on, yEx = yex(t);
	plot(t,yEx,'g'), title(['h=',num2str(H(i))])
end