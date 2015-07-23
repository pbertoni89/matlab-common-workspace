%% disegno la direzione di discesa e la sezione di phi lungo la direzione di discesa
% per gradiente

close all
x0=[-1;-2];
A=[1,0.6;0.6,1];b=[.1;.2];
sol=A\b;
phi=@(x)[0.5*x'*A*x-x'*b];
f=@(x)[2+phi(x)];%[0.4-phi(x).*exp(-(x(1).^2+x(2).^2))];

%
syms x y
fun=2+(0.5*[x,y]*A*[x;y]-[x,y]*b);
funx=diff(fun,x);
funy=diff(fun,y);

g1=vectorize(char(funx));
g2=vectorize(char(funy));
grad1=@(x,y)[eval(g1)];
grad2=@(x,y)[eval(g2)];
clear x y
%
r0=b-A*x0;
g0=[grad1(x0(1),x0(2));grad2(x0(1),x0(2))];
dk=[3;4];
[x1,y1]=meshgrid(-2.:0.1:2.);

n=length(y1); m=length(x1);z=zeros(n,m);
for i=1:n
    for j=1:m
    z(i,j)=f([x1(i,j);y1(i,j)]);
end
end
figure(1); clf

p1=mesh(x1,y1,z);
%set(p1,'Edgecolor',[0,1,1])
hold on
contour(x1,y1,z,15);
xlabel('x');
ylabel('y');


figure(2); clf
contour(x1,y1,z,25);hold on
plot(x0(1),x0(2),'ko','markerfacecolor','k')
plot(sol(1),sol(2),'ro','markerfacecolor','r')
xlabel('x');
ylabel('y');

alpha=linspace(0,1,100);
 zz=zeros(100,1);xx=zz;gg=zz;
for k=1:100
    for i=1:2
    xx(i,k)=x0(i)+alpha(k)*r0(i);
    gg(i,k)=x0(i)-45*alpha(k)*g0(i);
    end
    zz(k)=f([xx(1,k);xx(2,k)]);
end
figure(1)

% disegno la restrizione di f alla direzione r^k
plot3(xx(1,:),xx(2,:),zz,'k','linewidth',2)
% disegno la direzione di -grad
plot3(gg(1,:),gg(2,:),zeros(100,1),'k')    
figure(2)
plot([gg(1,1),gg(1,end)],[gg(2,1),gg(2,end)],'k')    

 alphak=r0'*r0/(r0'*A*r0);
xs=x0+alphak*r0;
figure(1);
plot3(xs(1),xs(2),f(xs),'bo','Markersize',5,'Markerfacecolor','b')
plot3(xs(1),xs(2),0,'bo','Markersize',5,'Markerfacecolor','b')
plot3(x0(1),x0(2),0,'ko','Markersize',5,'Markerfacecolor','k')
plot3([xs(1),xs(1)],[xs(2),xs(2)],[f(xs)-0.003,0],'k--')
plot3([x0(1),x0(1)],[x0(2),x0(2)],[f(x0)-0.003,0],'k--')


figure(2)
plot(xs(1),xs(2),'bo','Markersize',5,'Markerfacecolor','b')
text(-1.1,-1.7,'${\bf x}^{(k)}$',...
    'Interpreter','Latex') 
text(0.5,-0.3,'${\bf x}^{(k+1)}$',...
    'Interpreter','Latex')
text(0.7,1.5,'${\bf r}^{(k)}=-\nabla \phi({\bf x}^{(k)})$',...
    'Interpreter','Latex')


figure(1)
text(1,1.8,0,'${\bf r}^{(k)}=-\nabla \phi({\bf x}^{(k)})$',...
    'Interpreter','Latex')
text(-1.5,-1.7,0,'${\bf x}^{(k)}$',...
    'Interpreter','Latex') 
text(1.2,-0.5,0,'${\bf x}^{(k+1)}$',...
    'Interpreter','Latex')
view([70,28])
lx=xlabel('x');
set(lx,'Position',[28.94,-14.34,1.833])
ly=ylabel('y');
set(ly,'Position',[30.33,-11.38,1.746])
axis([-2,2,-2,2.5])
grid off
%axis off
% set(gca,'Box','off')
%print(1,'-deps2c','sezione')
% 
% %