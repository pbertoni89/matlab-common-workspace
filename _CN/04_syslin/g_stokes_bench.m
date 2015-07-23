%% Loading and Testing
clear all; close all; clc;
load stokes.mat; spy(A); % contains A non sdp, b
disp('test simmetria');
if isequal(A,A')==1
	fprintf('A è simmetrica!!\n');
	disp('test SDP'); tic
% 	if is_sdp(A)==1
% 		fprintf(' A è SDP\n')
% 	else
% 		fprintf('A non è SDP\n')
% 	end
	%chol(A) % TEST SDP MOLTO MA MOLTO PIù VELOCE. ABANDON CODE
	toc
else
	fprintf('A non è simmetrica!!\n');
end
disp('test DDS'); tic
if is_dds(A)==1
	fprintf(' A è DDS\n')
else
	fprintf('A non è DDS\n')
end
toc

% Osservazioni: 
% A non è SDP nè DDS pertanto non funzionano Choleskij, Jacobi, Gauss
% Siedel (J, GS cmq sconsigliati, avendo molti zeri sulla diagonale)

% posso affidarmi ai metodi diretti (sebbene la matrice sia larga e 
% sparsa ); oppure varianti del CG per A NON SDP => BiCGStab
%% Solving
tol=1.e-10;
itmax = 1000;
ndim = size(A,1);
x0 = rand(ndim,1);

% Diretti ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
t1=cputime;
[L,U,P]=lu(A); whos L U P
y=L\(P*b);
x=U\y;
t2=cputime; clear y
fprintf('fatt LU, CPU time=%1.6f\n',t2-t1);
%~~~~~~~~~~
t1=cputime; % efficienza ASSURDA =) quando matrice sparsa NON SDP
x=A\b;
t2=cputime;
fprintf('Backslash(Multifrontale), CPU time=%1.6f\n',t2-t1);
% Iterativi ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
t1=cputime;
[~,~,~,~,resvec_BiCGStab]= bicgstab(A,b,tol,itmax,[],[],x0);
t2=cputime;
fprintf('BiCGStab, CPU time=%1.6f\n',t2-t1);
%~~~~~~~~~~
t1=cputime;
droptol = 1.e-2; 
[Lt, Ut] = luinc(A,droptol); whos Lt Ut
[~,~,~,~,resvec_PBiCGStab]= bicgstab(A,b,tol,itmax,Lt,Ut,x0);
t2=cputime;
fprintf('BiCGStab con luinc, CPU time=%1.6f\n',t2-t1);
% disp('calcolo efficienza del precond P = Lt*Ut');
% disp('calcolo K(A\P)'); tic
% KALU = cond(A\(Lt*Ut))
% toc
% fprintf('K(A) / K(A\\P) = %3.2d\n', (KA/KALU)*100); clear Lt Ut
resvec_BiCGStab = resvec_BiCGStab/norm(b);
resvec_PBiCGStab = resvec_PBiCGStab/norm(b);
figure(5); clf;
semilogy(resvec_BiCGStab(1:2:end),'c'); hold on;
semilogy(resvec_PBiCGStab(1:2:end),'m');

legend('BiCGStab','PBiCGStab');