% Patrizio Giuliano Bertoni 79021

%% 1
clc, close all, clear all

f = @(x) exp(x) -2*atan(x);
Ia = -5; Ib = 2; Next = 100; % esteso
xext = linspace(Ia,Ib,Next); yext = f(xext);
onlyPlotErr = 1; % flag per graficare solo le storie di cvg

%1.a
N = 4:4:32; errIGL_Eq = []; errIGL_Ch = [];  errICL_Eq = [];
H = (Ib-Ia)./N;
for n = N
	n
	xeq  = linspace(Ia, Ib, n);      % per IGL_Eq
    xeq1 = linspace(Ia, Ib, n+1);    % per ICL_Eq
	xch  = chebyspace(Ia,Ib,n);      % per IGL_Ch
	
	yeq  = f(xeq); 
    ych  = f(xch);
    yeq1 = f(xeq1);
    
	aeq = vander(xeq)\yeq'; 
    ach = vander(xch)\ych';
    
    yicl = interp1(xeq1,yeq1,xext);
  
	peq = polyval(aeq,xext); 
    pch = polyval(ach,xext);
    
    if onlyPlotErr == 0
        figure, subplot(1,3,1), plot(xext,yext,'k',xext,peq,'r')
        legend('f(x)','IGL_{EQ}')
        subplot(1,3,2), plot(xext,yext,'k',xext,pch,'g')
        title(['n=',num2str(n)]), legend('f(x)','IGL_{CH}')
        subplot(1,3,3), plot(xext,yext,'k',xext,yicl,'b')
        legend('f(x)','ICL_{EQ}')
    end
	
	errIGL_Eq = [ errIGL_Eq max(abs(yext-peq)) ];
	errIGL_Ch = [ errIGL_Ch max(abs(yext-pch)) ];
    errICL_Eq = [ errICL_Eq max(abs(yext-yicl))];
end

%1.b
% Si è ritenuto più significativo comparare gli errori con le dimensioni H
% piuttosto che con gli intervalli N; anche perchè la teoria ci dice che
% uno dei metodi (ICL), sotto certe condizioni, si comporta come H.^2.
% Volendo però è possibile cambiare il flag seguente.
compareH = 1; figure('name','Storie di Convergenza')
if compareH == 1
    loglog(H,errIGL_Eq,'r',H,errIGL_Ch,'g',H,errICL_Eq,'b', ...
                    H,H,'y',H,H.^2,'c',H,H.^3,'m'), grid on
    legend('IGL_{EQ}','IGL_{Ch}','ICL_{EQ}','h','h^2','h^3')
    xlabel('h')
else
    loglog(N,errIGL_Eq,'r',N,errIGL_Ch,'g',N,errICL_Eq,'b', ...
                    N,N,'y',N,N.^2,'c',N,N.^3,'m'), grid on
	legend('IGL_{EQ}','IGL_{Ch}','ICL_{EQ}','n','n^2','n^3')
    xlabel('n')
end, title('Errore')

% la teoria non offre condizioni necessarie e/o sufficienti per la 
% convergenza dell'IGL sui nodi equispaziati; generalmente 
% sui gradi elevati nascono oscillazioni vicino agli estremi. 
% Si può ipotizzare la divergenza, visto il comportamento dell'errore
% sugli n più grandi.
% Si può però ragionare sui warnings che appaiono per esperimenti con n>=20
% e attribuire la divergenza all'imprecisione macchina (per propagazione)
% però tali warning sono ottenuti anche con Chebychev (il quale converge), 
% il che ci porta a escluderli.
% ricordiamo che i warnings appaiono per la risoluzione del sistema lineare
% di Van Der Monde.

% la teoria assicura che se i nodi sono presi al senso di Chebychev
% la convergenza è assicurata per ogni n naturale. Infatti inizialmente
% l'errore si comporta come h^2 ma poi addirittura accelera.
% Con i dati del tema esame non è possibile assistere alla divergenza
% numerica anche di IGL_Ch, che avviene unicamente per propagazione degli
% errori di macchina su n >= 36.

% per l'interp composito ci appoggiamo al teorema che garantisce una
% dipendenza quadratica dell'errore da H, qualora f interpolata sia di
% classe C2: così avviene effettivamente, e nei grafici si osserva bene.
    %ddf = @(x) exp(x) + (4*x)./((1+x.^2).^2);
    %ddy = ddf(xext); figure, plot(xext,ddy,'k'), legend('f''''')
% è possibile usare questo risultato per calcolare C nell'espressione
% di upper bound per l'errore ICL:
    % maxErrICL <= C H^2 max|ddy|
% e quindi ottenere un buon metodo per governare la tolleranza sulle
% interpolazioni future della stessa f, basandosi su H.

%% 2
clc, close all, clear all

g = @(x,y) 0*x + 0*y; % bordo
f = @(x,y) 1 + 0*x; % interno

xa = 0; xb = 1; ya = 0; yb = 1;

%2.a
NX = 4:4:32; NY = NX;
HX = (xb-xa)./NX; HY = (yb-ya)./NY; 
KA = zeros(1,length(NX)); % vettore per i K condizionamento

for n = 1:length(NX) 
    
	nx = NX(n); ny = NY(n); hx = HX(n); hy = HY(n);
	nx1 = nx+1; ny1 = ny+1; N = nx1*ny1;
	
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
	% con griglie 300x300 si notano performance 12.8 -> 4.6 sec in media
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
	
	KA(n) = cond(full(A(interno,interno)));

    if nx == 20
        
        b = zeros(N,1);
        b(interno) = f(xy(interno,1),xy(interno,2));
        b(bordo) = g(xy(bordo,1),xy(bordo,2));
        
        u = A\b;
        u2 = reshape(u,nx1,ny1); u20 = u2';
        figure('name','Soluzione per n = 20');
        mesh(x,y,u20), xlabel('x'), ylabel('y'), colorbar
    end
end

%2.b
figure('name','K(A)'), plot(NX,KA), xlabel('NX')
%2
P = 1:4; colors = {'k','g','r','b'};
figure('name','Determinazione empirica dipendenza K(A) da N')
for p = P
	ratio = KA./(NX.^p);
	subplot(2,2,p), plot(NX,ratio,colors{p}), title(['p=',num2str(p)])
end
% la dipendenza è quadratica: 
% asintoticamente è ragionevole pensare a un rapporto costante! 
% ora ricalcolo il rapporto giusto per arrivare a C
p = 2
ratio = KA./(NX.^p); C = ratio(end)

%2.c
funK = @(n) C*n.^2; nbig = 1.e5;
disp('Per una matrice Ainterna di dimensione nxn, ')
fprintf('n = %i, si stima K(Ainterna) = %d\n\n', nbig, funK(nbig));
disp('pertanto supponendo gli errori sui dati siano dell''ordine di epsilon, ')
fprintf('si stima l''errore relativo sulla soluzione <= %d\n',funK(nbig)*eps);


