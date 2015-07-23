% evoluzione del problema di diffusione di Poisson: 
% qua si modellizza il trasporto ad opera del VENTO.
clear all; close all; clc;

g = @(x,y) sin(pi*x.*y);

trasp = 0; % flag per attivare l'effetto del trasporto
	mu = 0.1;
	b1 = @(x,y) -y;
	b2 = @(x,y) +x;
	
xa = 0; xb = 1; ya = 0; yb = 1;
 
NX = [20 40 80 160 200]'; NY = NX;
HX = (xb-xa)./NX;  HY = (yb-ya)./NY;
ErrD = zeros(length(NX),1); ErrDT = ErrD;

prove = length(NX); lotsplots = 0; %plotta soluzioni u
n = 1;
while n <= prove || trasp == 0 % si suppone NX NY lunghi uguale

	if trasp == 0
		f = @(x,y)   (pi^2)*(x.^2+y.^2).*sin(pi*x.*y);
	else
		f = @(x,y)(mu*pi^2)*(x.^2+y.^2).*sin(pi*x.*y) + ...
					   pi  *(x.^2-y.^2).*cos(pi*x.*y);
	end
	
	nx = NX(n); ny = NY(n);
	hx = HX(n); hy = HY(n);

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
	
	b = zeros(N,1);
	b(interno) = f(xy(interno,1),xy(interno,2));
	b(bordo) = g(xy(bordo,1),xy(bordo,2));
	
	% genero matrice del sistema lineare
	e = ones(N,1);
	if trasp == 0
		al = -1/(hy^2);
		be = -1/(hx^2);
		ga = (-2*al-2*be);
		A = spdiags([al*e, be*e, ga*e, be*e, al*e], ...
			[-nx1,-1,0,1,nx1],N,N);
	else
		B1 = b1(xy(:,1),xy(:,2)); 
		B2 = b2(xy(:,1),xy(:,2)); 
	
		alpha = -1/hy^2; beta = -1/hx^2; gam = 2*(-alpha-beta);
		e1 = alpha*mu*e - B2/hy;
		e2 = beta*mu*e - B1/hx;
		e3 = gam*mu*e + B2/hy + B1/hx;
		e4 = mu*beta*e;
		e5 = mu*alpha*e;
		A = spdiags([e1,e2,e3,e4,e5],[-nx1,-1,0,1,nx1],N,N);
		
		%be_y = (-mu/(hy^2))*e;
		%be_x = (-mu/(hx^2))*e;

		%al_y = be_y - b2Pk/hy;
		%al_x = be_x - b1Pk/hx;
		%ga = -mu*(2/hy^2+2/hx^2) + b1Pk/hx + b2Pk/hy ;
		%A = spdiags([al_y, al_x, ga, be_x, be_y], ...
				%[-nx1,-1,0,1,nx1],N,N);
	end

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
	
	u = A\b;
	u2 = reshape(u,nx1,ny1); u2 = u2';
	
	if lotplots == 1
		figure(n);
		if trasp == 0
			subplot(2,2,1); mesh(x,y,u2); title('diff');
			subplot(2,2,3); spy(A); title('diff');
		else
			subplot(2,2,2); mesh(x,y,u2); title('traspdiff');
			subplot(2,2,4); spy(A); title('traspdiff');
		end
	end
	
	%% Calcolo dell'errore nota la soluzione esatta f_ex = g
	% in tutti e due i casi ho f_ex = g, per grandi misteri.
	dominio = union(bordo, interno)';
	uex = zeros(N,1);
	uex(dominio) = g(xy(dominio,1),xy(dominio,2));
	if trasp==0, ErrD(n) = max(abs(u-uex));
	else ErrDT(n) = max(abs(u-uex));
	end
	
	%% Ricambio trasp trasp-diff
	if n == prove && trasp == 0 % riattivo ciclo
		trasp = 1;
		n = 1;
	else
		n = n+1;
	end
end

figure('name','Storie')
loglog(HX,HX,HX,HX.^2,'c',HX,ErrD,'r',HX,ErrDT,'g','Linewidth',2);
legend('h','h^2','diff','difftrasp'); grid on;