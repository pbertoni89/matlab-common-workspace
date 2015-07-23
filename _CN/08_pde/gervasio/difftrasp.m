% input: (xa,xb) x (ya,yb) per il dominio
xa=0; xb=1;
ya=0; yb=1;
% definisco il coefficiente di diffusione
mu=0.1;
b1=@(x,y)-y;
b2=@(x,y)x;
% funzioni del problema
f=@(x,y)mu*pi^2*(x.^2 + y.^2).*sin(pi*x.*y)+...
    pi*(x.^2-y.^2).*cos(pi*x.*y);  
g=@(x,y)sin(pi*x.*y);
% n. intervallini lungo x e y
NN=[20,40,80,160];
Err=[];
for nx=NN
    ny=nx;

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
% costruisco la matrice del -laplaciano
% hx=(xb-xa)/nx;  hy=(yb-ya)/ny;
% alpha=-1/hy^2; beta=-1/hx^2; gam=2/hx^2+2/hy^2;
% e=ones(N,1);
% A=spdiags([alpha*e,beta*e,gam*e,beta*e,alpha*e],...
%     [-nx1,-1,0,1,nx1],N,N);

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
%spy(A)
% costruisco il termine noto
b=zeros(N,1);
% nei punti di bordo impongo g (dato di Dirichlet)
b(l_bordo)=g(xy(l_bordo,1),xy(l_bordo,2));
% nei punti interni impongo f (termine forzante)
b(l_interni)=f(xy(l_interni,1),xy(l_interni,2));

% risolviamo il sistema lineare
u=A\b;

% % rimappo la soluzione su due indici
% 
% uu=reshape(u,nx1,ny1);
% uu=uu';
% 
% % rappresento la soluzione
% 
% figure(1); clf
% mesh(x,y,uu)

% calcalo l' errore
 %soluzione esatta
 uex=@(x,y)sin(pi*x.*y);
% valuto la sol esatta sulla mesh
U=uex(xy(:,1),xy(:,2));

err=max(abs(U-u));
Err=[Err;err];
fprintf('Errore = %13.6e \n',err)

end
H=1./NN;
figure(2);clf
loglog(H,Err,H,H,H,H.^2,'linewidth',2);
grid on
legend('Errore','H','H^2')
























