%% Problema di Poisson applicato alla diffusione
clear all; close all; clc;

f = @(x,y) (pi^2)*(x.^2+y.^2).*sin(pi*x.*y);
g = @(x,y) sin(pi*x.*y);

xa = -1; xb = 1; ya = -1; yb = 1;

NX = [20 40 80 160 ]';
HX = (xb-xa)./NX; 
ERR = zeros(length(NX),1);

for n = 1:length(NX)
	tic
	nx = NX(n), ny = nx;
	hx = HX(n); hy = hx;
	nx1 = nx+1; ny1 = ny+1;
	N = nx1*ny1;
	
	bordo = [(1:nx1)' ; (nx1:nx1:N-nx)' ; (1:nx1:N)' ; (N-nx:N)'];
	bordo = (unique(bordo))';
	interno = setdiff(1:N,bordo);

	al = -1/(hy^2); be = -1/(hx^2); ga = (-2*al-2*be);
	e = ones(N,1);
	A = spdiags([al*e, be*e, ga*e, be*e, al*e],[-nx1,-1,0,1,nx1],N,N);

	% IMP GENERAL non posso usare i = bordo se bordo è colonna...
		% posso invece usarlo se è riga, in generale evitare
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

	% porto le coordinate da due dimensioni a una
	x = linspace(xa,xb,nx1); y = linspace(ya,yb,ny1);
	xy = zeros(N,2);
	for i = 1:nx1
		for j = 1:ny1
			k = nx1*(j-1)+i;
			xy(k,1) = x(i);
			xy(k,2) = y(j);
		end
	end

	b = zeros(N,1);
	b(interno) = f(xy(interno,1),xy(interno,2));
	b(bordo) = g(xy(bordo,1),xy(bordo,2));

	u = A\b;
	u2 = reshape(u,nx1,ny1); u2 = u2';
	toc
	
	% Calcolo dell'errore nota la soluzione esatta f_ex = g
	dominio = union(bordo, interno)';
	u_ex = zeros(N,1);
	u_ex(dominio) = g(xy(dominio,1),xy(dominio,2));

	ERR(n) = max(abs(u-u_ex));
end

figure('name','Errori');
loglog(HX,HX.^2,'b',HX,ERR,'r'); grid on; legend('h^2','ERR');

figure('name','Campo di inquinamento'); % ultimo NX computato
mesh(x,y,u2); colorbar

figure('name','Campo di vento');
[E1,E2] = gradient(-u2,hx,hy); % ultimo NX computato
quiver(x,y,E1,E2);
axis square;