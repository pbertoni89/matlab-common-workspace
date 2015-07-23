%% Disegno la parabola lungo la direzione rk e il punto di minimo
% disegno la nuova curva di livello
clear;close all

A=[1,0.4;0.4,1];b=[.3;.1];
xsol=A\b;
phi=@(x)[0.5*x'*A*x-x'*b];
xm1=(-5:0.1:5); ym1=xm1;
n=length(ym1); m=length(xm1);z=zeros(n,m);
for i=1:n
    for j=1:m
        zm(i,j)=phi([xm1(j);ym1(i)]);
    end
end

x0=[1;-2];
%x0=[1.095520421607378e+00; -3.761528326745718e-01];
r0=b-A*x0;

figure(1); clf
contour(xm1,ym1,zm,50)
hold on
contour(xm1,ym1,zm,phi(x0),'r')

plot(x0(1),x0(2),'o','Markersize',6,'markerfacecolor','b')
xlabel('x_1'); ylabel('x_2');
title('contour di phi(x)  e la direzione del gradiente in x0=[1;-2]')

plot(xsol(1),xsol(2),...
    'o','Markersize',6,'markerfacecolor','r')
 alpha=linspace(-8,8,100);
for i=1:100
    xx(:,i)=x0+alpha(i)*r0;
end
plot([xx(1,1),xx(1,100)],[xx(2,1),xx(2,100)],'linewidth',2)
 axis square
 pause
 
 alpha1=r0'*r0/(r0'*A*r0);
 x1=x0+alpha1*r0;
 plot(x1(1),x1(2),...
    'o','Markersize',6,'markerfacecolor','g')

 %print(1,'-deps2c','curve_x1')
 pause
 
 % seconda iterazione
 
r1=b-A*x1;


contour(xm1,ym1,zm,phi(x1),'r')

 alpha=linspace(-8,8,100);
for i=1:100
    xx(:,i)=x1+alpha(i)*r1;
end
plot([xx(1,1),xx(1,100)],[xx(2,1),xx(2,100)],'linewidth',2)
 axis square
 pause
 
 alpha2=r1'*r1/(r1'*A*r1);
 x2=x1+alpha2*r1;
 plot(x2(1),x2(2),...
    'o','Markersize',6,'markerfacecolor','k')

 print(1,'-deps2c','curve_x2')
 
%  %%
%  
%  %%
% 
% xx1=(-8:0.5:8); yy1=xx1;
% n=length(yy1); m=length(xx1);z=zeros(n,m);
% for i=1:n
%     for j=1:m
%         z(i,j)=phi([xx1(j);yy1(i)]);
%     end
% end
% 
%  figure(2);clf
%  for i=1:100
%      z1(i)=phi(xx(:,i));
%  end
%  meshc(xx1,yy1,z);hold on
%  plot3(xx(1,:),xx(2,:),z1,'r','linewidth',2)
%  hold on
%  plot3([xx(1,1),xx(1,100)],[xx(2,1),xx(2,100)],[0,0],'b','linewidth',1)
%  plot3(x0(1),x0(2),phi(x0),'o','Markersize',6,'markerfacecolor','b')
% xlabel('x_1'); ylabel('x_2');
% title('sezione di phi(x)  lungo la direzione del gradiente in x0=[1;-2]')
%  plot3(x1(1),x1(2),phi(x1),...
%     'o','Markersize',6,'markerfacecolor','g')
%  grid on
% 
%  view([-34,84])
% axis([-15,15,-15,15,-1,20])
%  print(2,'-deps2c','minimo_loc')
%  
%  % disegno la nuova curva di livello di quota phi(x^1)
% 
%  figure(3);clf
% contour(xm1,ym1,zm,50)
% hold on
% plot(x0(1),x0(2),'o','Markersize',6,'markerfacecolor','b')
% xlabel('x_1'); ylabel('x_2');
% title('contour di phi(x)  e la direzione del gradiente in x0=[1;-2]')
% 
% plot(xsol(1),xsol(2),...
%     'o','Markersize',6,'markerfacecolor','r')
%  alpha=linspace(-8,8,100);
% for i=1:100
%     xx(:,i)=x0+alpha(i)*r0;
% end
% plot([xx(1,1),xx(1,100)],[xx(2,1),xx(2,100)],'linewidth',2)
%  axis square
%  
%  alpha1=r0'*r0/(r0'*A*r0);
%  xnew=x0+alpha1*r0;
%  plot(xnew(1),xnew(2),...
%     'o','Markersize',6,'markerfacecolor','g')
% 
% 
%   contour(xm1,ym1,zm,phi(xnew),'r')
%    print(3,'-deps2c','curve_x3')