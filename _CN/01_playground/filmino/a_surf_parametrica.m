% disegno gamma(rho,theta) = ( r cos th, r sin th, th) = (x,y,z)
clear all; close all; clc;

figure('name','surface test');
[r,th] = meshgrid( 0:.1:2, 0:.1:2*pi );
x = 2*r .* cos(th); 
y = r .* sin(th);
z = th;

plot3(x,y,z2);
xlabel('x'); ylabel('y'); zlabel('z');