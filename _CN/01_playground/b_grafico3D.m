clear all; clc; close all;

[x,y] = meshgrid( -2:.1:2 , -2:.1:2 );
f=@(x,y)[ x.*exp(-x.^2-y.^2)]; %#ok<*NBRAK>
z = f(x,y);

figure(1);
%surf(x,y,z);
surfc(x,y,z);

figure(2);
%mesh(x,y,z);
meshc(x,y,z);

figure(3);
contour(x,y,z);
% colorbar;

pause; close all;