%% SIMMETRICA DECOMP per utilizzare CHOLESKIJ
% purtroppo le benchmark di confronto con il sistema semplice parlan
% chiaro: questo metodo si rivela più pesante. La causa è l'accesso più
% invasivo alla matrice A, che è spdiags (gli accessi tramite indice, sia
% in forma for che in forma logica, sono propri delle matrici full.

clear all; close all; clc;

g = @(x,y) 0*x + 0*y; % bordo
e = 1.128823459953265e-11;
f = @(x,y) (exp(-120*((x-.25).^2+(y-.25).^2)) + ...
		   2*exp(-200*((x-.75).^2+(y-.75).^2)))    /e ;

xa = 0; xb = 2; ya = 0; yb = 2;

NX = 7; %NX = 25:25:250;
NY = NX;

HX = (xb-xa)./NX; HY = (yb-ya)./NY; 
TIMESYMM = zeros(length(NX),1);

for n = 1:length(NX)
	
	nx = NX(n); ny = NY(n);
	hx = HX(n); hy = HY(n);

	nx1 = nx+1; ny1 = ny+1;
	N = nx1*ny1;
	
	t1 = cputime; % istruzioni prima erano invarianti

	bordo = [(1:nx1)' ; (nx1:nx1:N-nx)' ; (1:nx1:N)' ; (N-nx:N)'];
	bordo = (unique(bordo))';
	interno = setdiff(1:N,bordo);

	% porto le coordinate da due dimensioni a una
	x = linspace(xa,xb,nx1); y = linspace(ya,yb,ny1); xy =zeros(N,2);
	for i = 1:nx1
		for j = 1:ny1
			k = nx1*(j-1)+i;
			xy(k,1) = x(i);
			xy(k,2) = y(j);
		end
	end
	
	% matrice A
	al = -1/(hy^2);
	be = -1/(hx^2);
	ga = (-2*al-2*be);
	e = ones(N,1);
	A = spdiags([al*e, be*e, ga*e, be*e, al*e], ...
		[-nx1,-1,0,1,nx1],N,N);

	% Il blocco seguente sostituisce il ciclo
	%		for i = bordo, A(i,:) = 0;A(i,i) = 1; end
	% con griglie 300x300 si notano performance 12.8 -> 4.6 sec avg
	A(1,2) = 0; A(1,nx1+1) = 0;
	A(N,N-1) = 0; A(N,N-nx1) = 0;
	for i = bordo(2:(nx*2+ny*2)-1) % (nx*2+ny*2)= length(bordo)
		if i<=nx1
			A(i,i-1) = 0; A(i,i+1) = 0; A(i,i+nx1) = 0;
		elseif i>=N-nx
			A(i,i-1) = 0; A(i,i+1) = 0; A(i,i-nx1)=0;
		else
			A(i,i+1)=0; A(i,i+nx1)=0; A(i,i-1)=0; A(i,i-nx1)=0;
		end
		A(i,i) = 1; 
	end
	
	Aii = A(interno,interno);
	Aib = A(interno,bordo);
	
	% termini noti all'interno
	bi = f(xy(interno,1),xy(interno,2));
	% termini noti sul bordo
	bb = g(xy(bordo,1),xy(bordo,2));

	% risoluzione sistema
	R   = chol(Aii); 
	ui   = R\(R'\(bi-Aib*bb));
	
	% riordino variabili
	u(interno) = ui;
	u(bordo) = bb;

	t2 = cputime;
	TIMESYMM(n)=t2-t1;
	fprintf('NX = %d, CPU time=%1.30f\n', nx, TIMESYMM(n));
	
	u2 = reshape(u,nx1,ny1); u2 = u2';
end

figure('name','Potenziale elettrostatico'); % ultimo NX computato
mesh(x,y,u2);

figure('name','Campo elettrostatico');
[E1,E2] = gradient(-u2,hx,hy); % ultimo NX computato
quiver(x,y,E1,E2);
axis square;

figure('name','Benchmarks');
plot(NX,TIMESYMM,'r');
legend('TIME');
xlabel('n'); ylabel('secs');