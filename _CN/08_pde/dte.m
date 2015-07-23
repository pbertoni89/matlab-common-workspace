function [ ] = dte(f, g, b1, b2, u0, ht, tspan, mu, space, nx)
%F_DIFFTRASPEVO evoluzione del problema di diffusione di Poisson: 
% qua si modellizza il trasporto ad opera del VENTO.

gradplot = 0; % defines whether gradient should be plotted or not
verbose = 0;

% dimensione temporale
t0 = tspan(1); T = tspan(2);
Nt = ceil((T-t0)/ht);
tn = linspace(t0,T,Nt+1);
%% dimensione spaziale
xa = space(1); xb = space(2); ya = space(3); yb = space(4);
ny = nx;
hx = (xb-xa)./nx; hy = hx;
nx1 = nx+1; ny1 = ny+1;
N = nx1*ny1;

bordo = [(1:nx1)' ; (nx1:nx1:N-nx)' ; (1:nx1:N)' ; (N-nx:N)'];
bordo = (unique(bordo))';
interno = setdiff(1:N,bordo);

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

% genero matrice del sistema lineare
e = ones(N,1);

B1 = b1(xy(:,1),xy(:,2)); B2 = b2(xy(:,1),xy(:,2));

alpha = -1/hy^2; beta = -1/hx^2; gam = 2*(-alpha-beta);
e1 = alpha*mu*e - B2/hy;
e2 = beta*mu*e - B1/hx;
e3 = gam*mu*e + B2/hy + B1/hx;
e4 = mu*beta*e;
e5 = mu*alpha*e;
A = spdiags([e1,e2,e3,e4,e5],[-nx1,-1,0,1,nx1],N,N);

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

% aggiunta evolutiva (accesso indexed a sparse matrix, peso)
for i = interno
	A(i,i) = A(i,i) + 1/ht;
end
% fattorizzo A con LU, ora posso
[L U P] = lu(A);

%% t = t0
% la soluzione iniziale � nota, devo solo plottarla
u = u0(xy(:,1),xy(:,2));
uu=reshape(u,nx1,ny1); uu=uu';

if gradplot == 1, subplot(1,2,1);
    dte(f, g, b1, b2, u0, ht, tspan, mu, space, nx) 
end
surf(x, y, uu, 'EdgeColor','none'); view([0,90]); %colorbar;
title(['t=',num2str(t0)]); axis square;
if gradplot == 1, subplot(1,2,2), pause(0.0001)
	[E1,E2] = gradient(-uu,hx,hy); quiver(x,y,E1,E2), axis square;
end

%% t0 < t <= T
for i = 2:Nt+1;

	if verbose == 1, tic, end
    t=tn(i);
	b=zeros(N,1);
	% nei punti interni impongo f(t(n)) + u(t(n-1)) / ht
	% IMP: in questo momento u rappresenta la soluzione precedente
	b(interno) = f(xy(interno,1),xy(interno,2),t) ...
				 + u(interno)/ht;
	%nei punti di bordo impongo g (da di dirichtlet)
	b(bordo) = g(xy(bordo,1),xy(bordo,2),t);
	
	%risolvo il sistema
	u = U\(L\(P*b));
	
	uu = reshape(u,nx1,ny1); uu = uu';
	
	if gradplot == 1, subplot(1,2,1); end
	surf(x, y, uu, 'EdgeColor','none'); view([0,90]); 
	%colorbar; PESANTISSIMA
	title(['t=',num2str(t)]); axis square; pause(0.000001);
	if gradplot == 1, subplot(1,2,2);
		[E1,E2] = gradient(-uu,hx,hy); 
		quiver(x,y,E1,E2); axis square;
	end
	
	if verbose == 1, toc, end
end