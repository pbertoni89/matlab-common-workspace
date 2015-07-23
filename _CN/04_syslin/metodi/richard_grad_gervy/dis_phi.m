%%
% soluzione di Ax=b e punto di minimo del funzionale
%
%
close all; clear; clc;
A=[10,6;6,6];b=[11;2];
xsol=A\b;
phi=@(x)[0.5*x'*A*x-b'*x];
x1=(-55:1:55); y1=x1;
n=length(y1); m=length(x1);z=zeros(n,m);
for i=1:n
    for j=1:m
        z(i,j)=phi([x1(j);y1(i)]);
    end
end
figure(1); clf
meshc(x1,y1,z)
hold on
plot3(xsol(1),xsol(2),-1,'o','Markersize',8,'markerfacecolor','r')
xlabel('x_1'); ylabel('x_2');zlabel('phi(x)')
figure(2); clf
contour(x1,y1,z,40)
hold on
plot(xsol(1),xsol(2),'o','Markersize',8,'markerfacecolor','r'); grid on
xlabel('x_1'); ylabel('x_2');

% print(1,'-deps2c','phi_mesh')
% print(2,'-deps2c','phi_cont')


