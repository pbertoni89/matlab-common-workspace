% input: (xa,xb) x (ya,yb) per il dominio
xa=-1; xb=1;
ya=-1; yb=1;

choice=menu('caso test','primo','secondo');
if choice==1
% definisco il coefficiente di diffusione
mu=0.01;
b1=@(x,y)1+0*x;
b2=@(x,y)1+0*x;
% definisco il dato u0( la soluzione al tempo iniziale)
u0=@(x,y)10*(abs((x+0.5).^2+(y+0.5).^2)<0.01);

% funzioni del problema
f=@(x,y,t)0+0*x;  
g=@(x,y,t)0+0*x;
elseif choice==2
% definisco il coefficiente di diffusione
mu=0.01;
b1=@(x,y)-y;
b2=@(x,y)x;
% definisco il dato u0( la soluzione al tempo iniziale)
u0=@(x,y)0+0*x;

% funzioni del problema
f=@(x,y,t)20*(sin(t)+2)*(abs((x+0.5).^2+(y+0.5).^2)<0.01)+...
    20*(sin(t)+2)*(abs((x-0.6).^2+(y-0.6).^2)<0.01);  
g=@(x,y,t)0+0*x;
end
% n. intervallini lungo x e y
nx=100; 
ny=nx;

% definisco l'intervallo temporale
t0=0; T=20; tspan=[t0,T];
% numero di passi temporali o passo in tempo
ht=0.05;
Nt=ceil((tspan(2)-tspan(1))/ht);
tn=linspace(tspan(1),tspan(2),Nt+1);

% costruire la mesh
nx1=nx+1;
x=linspace(xa,xb,nx1);
ny1=ny+1;
y=linspace(ya,yb,ny1);
N=nx1*ny1; % numero globale di nodi
xy=zeros(N,2);
% xy contiene ascisse e ordinate di tutti i punti
for i=1:nx1
    for j=1:ny1
        k=(j-1)*nx1+i; % numerazione a unico indice
        xy(k,1)=x(i); xy(k,2)=y(j);
    end
end


% costruire la matrice dell'operatore di diffusione trasporto
hx=(xb-xa)/nx;  hy=(yb-ya)/ny;
% valuto il trasporto
B1=b1(xy(:,1),xy(:,2));
B2=b2(xy(:,1),xy(:,2));
alpha=-1/hy^2; beta=-1/hx^2; gam=2/hx^2+2/hy^2;
e=ones(N,1);
% diagonale associata ai punti k-nx1
e1=mu*alpha*e-B2/hy;
% diagonale associata ai punti k-1
e2=mu*beta*e-B1/hx;
% diagonale associata i punti k
e3=mu*gam*e+B1/hx+B2/hy;
% diagonale associata ai punti k+1
e4=mu*beta*e;
% diagonale associata ai punti k+nx1
e5=mu*alpha*e;
A=spdiags([e1,e2,e3,e4,e5],[-nx1,-1,0,1,nx1],N,N);

%spy(A)
% costruzione liste bordo e punti interni
lista=(1:N)'; % punti di tutto Omega
l_bordo=[(1:nx1)';... % lato basso
    (1:nx1:N)';... % lato sinistro
    (nx1:nx1:N)';... % lato destro
    (nx1*ny+1:N)']; % lato alto
l_bordo=unique(l_bordo); % lista dei punti di bordo
l_interni=setdiff(lista,l_bordo); % lista dei punti interni
% sistemo le righe di A associate ai punti di bordo
for k=1:length(l_bordo)
    k1=l_bordo(k);
    A(k1,:)=0; A(k1,k1)=1;
end
% aggiungo il pezzo I/ht solo per i punti interni
for k=1:length(l_interni)
    k1=l_interni(k);
    A(k1,k1)=A(k1,k1)+1/ht;
end
% fattorizzo A con lu
[L,U,P]=lu(A);

% inizializzo la soluzione al tempo t0
u=u0(xy(:,1),xy(:,2));
t=t0;
figure(1); clf
uu=reshape(u,nx1,ny1);
uu=uu';
surf(x,y,uu,'EdgeColor','none'); % disegno la superficie
view([0,90]) % visione dall’alto
colorbar % scala di colori
axis([-1,1,-1,1,0,8])
title(['t=',num2str(t)])
pause(0.01) %

% inizio il ciclo temporale 
for n=2:Nt+1
    t=tn(n);
% costruisco il termine noto
b=zeros(N,1);
% nei punti interni impongo f(t_n)+u(t_(n-1))/ht 
b(l_interni)=f(xy(l_interni,1),xy(l_interni,2),t)+...
    u(l_interni)/ht;
% nei punti di bordo impongo g (dato di Dirichlet)
b(l_bordo)=g(xy(l_bordo,1),xy(l_bordo,2),t);
% risolviamo il sistema lineare
 u=U\(L\(P*b));

% % rimappo la soluzione su due indici
% 
uu=reshape(u,nx1,ny1);
uu=uu';
% 
% % rappresento la soluzione
% 
figure(1);  
surf(x,y,uu,'EdgeColor','none'); % disegno la superficie
view([0,90]) % visione dall’alto
colorbar % scala di colori
title(['t=',num2str(t)])
%axis([-1,1,-1,1,0,8])
caxis([0,8])
pause(0.01) %
end























