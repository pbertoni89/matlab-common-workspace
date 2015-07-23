%% 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear all; clc; close all; format longe

N = 8; e = ones(N,1); myeps = 1.e-3; tol = 1.e-6; maxit = 30;
A = spdiags([-.1*e .8*e -.1*e],-1:1,N,N); A(1,1) = 1; A(N,N) = 1;
b = .6*e; b(1) = 1; b(N) = 1; btild = b*(1+myeps);
xex = ones(N,1);

ub = condest(A)*( norm(btild-b)/norm(b) + eps/2);
x0 = rand(N,1);
% sono interessato a metodi iterativi; la matrice è sparse!
xpcg  = pcg(A,b    ,tol,maxit,[],[],x0);
xtild = pcg(A,btild,tol,maxit,[],[],x0);
err = norm(xtild-xpcg)/norm(xpcg);

if err <= ub
	fprintf('%d <= %d\n',err, ub)
else
	fprintf('something went wrong\n')
end

% rank(full(A))
% A è di rango pieno: non esiston sottomatrici principali singolari
% => MEG termina benissimo senza pivotazioni
% [L U P] = lu(A) infatti mostra P = eye(N)

% è possibile usare pcg perchè A è sdp. una chiamata a chol(full(A))
% difatti non dà warning. Comunque l'ho già usato, chiamo un diretto
[L U P] =lu(A); xlu = U\(L\(P*b));

fprintf('errore PCG = %d\n',norm(xpcg-xex)/norm(xex));
fprintf('errore LU  = %d\n',norm(xlu -xex)/norm(xex));
%% 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear all; clc; close all;

F = @(x) [ 4*(x(1).^2+x(2).^2)-3*x(1).*x(2)-1 ...
		   (x(1).^2-2*x(2)).*cos(x(2))+3*x(1) ];
JF = @(x)[ 8*x(1)-3*x(2), 8*x(2)-3*x(1); 2*x(1).*cos(x(2))+3, ...
		   (2*x(2)-x(1).^2).*sin(x(2))-2*cos(x(2)) ];
	   	   
tol = 1e-8; nmax = 100;

x0_1 = [1; 1] 
jac = JF(x0_1)
[zero_1, resid_1, niter_1, ~ ] = newtonsys(F, JF, x0_1, tol, nmax)

% x0 = [ 0 0 ] fa sì che det(JF(x0)) = 0 => non bene x Newton

%% 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear all; clc; close all;

V0 = [0 2.5 3.5 6 9];
figure('name','Attrito Piecewise')
for i = 1:length(V0)
	y0(2) =V0(i);
	[t y] = rk4(dy,[t0 T],y0,n);
	
	maxL = L*ones(size(t));
	subplot(length(V0),2,(i*2)-1)
	plot(t,y(1,:),'g',t,maxL,'r'), ylabel('x')
	title(['v0=',num2str(V0(i))])
	
	subplot(length(V0),2,(i*2)) 
	plot(t,y(2,:)), ylabel('v')
end
% attrito di tipo2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dy = @(t,y) [1*y(2); Fa(t,y(2),2)/m];
V0 = [9 21 35 40 ];
figure('name','Attrito viscoso')
for i = 1:length(V0)
	y0(2) =V0(i);
	[t y] = rk4(dy,[t0 T],y0,n);
	
	maxL = L*ones(size(t));
	subplot(length(V0),2,(i*2)-1)
	plot(t,y(1,:),'g',t,maxL,'r'), ylabel('x')
	title(['v0=',num2str(V0(i))])
	
	subplot(length(V0),2,(i*2)) 
	plot(t,y(2,:)), ylabel('v')
end
% stabilità schema ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% attrito1: gli eigs sono 0,0. pertanto h*lambda = 0 e si ha stab
% per ogni h possibile.
% attrito2: gli eigs sono -c,0 = -5,0.
% ricordo che l'estremo sx della regione abstab di RK4 vale -2.8, 
h0 = -2.8/(-5) % c = -5 definito in f_attrito
% dimostro che h > h0 non offrono stabilità.
h = h0+1.e-1; n = ceil((T-t0)/h);
dy = @(t,y) [1*y(2); Fa(t,y(2),2)/m];
figure('name','Step non accurati per RK4 con attrito Viscoso')
for i = 1:length(V0)
	y0(2) =V0(i);
	[t y] = rk4(dy,[t0 T],y0,n);
	
	maxL = L*ones(size(t));
	subplot(length(V0),2,(i*2)-1)
	plot(t,y(1,:),'g',t,maxL,'r'), ylabel('x')
	title(['v0=',num2str(V0(i))])
	
	subplot(length(V0),2,(i*2)) 
	plot(t,y(2,:)), ylabel('v')
end
% dimostro che h < h0 offrono stabilità.
h = h0-1.e-1; n = ceil((T-t0)/h);
dy = @(t,y) [1*y(2); Fa(t,y(2),2)/m];
V0 = [0 2.5 3.5 6 9];
figure('name','Step accurati per RK4 con attrito Viscoso')
for i = 1:length(V0)
	y0(2) =V0(i);
	[t y] = rk4(dy,[t0 T],y0,n);
	
	maxL = L*ones(size(t));
	subplot(length(V0),2,(i*2)-1)
	plot(t,y(1,:),'g',t,maxL,'r'), ylabel('x')
	title(['v0=',num2str(V0(i))])
	
	subplot(length(V0),2,(i*2)) 
	plot(t,y(2,:)), ylabel('v')
end