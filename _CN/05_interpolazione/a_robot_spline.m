clear all; close all; clc;
n = 5;

x = [2.00 4.25 5.25 7.81 9.20 10.60]';
y = [7.2 7.1 6.0 5.0 3.5 5.0]';
x1 = linspace(x(1), x(end), 100);

% igl
a = vander(x)\y;
y_igl = polyval(a,x1);
% icl
y_icl = interp1(x,y,x1);
% nearest
y_nea = interp1(x,y,x1,'nearest');
% spline
y_spl = spline(x,y,x1);
% plots
figure(1);
plot(x,y,'o'); hold on;
plot(x1,y_igl,'r');
plot(x1,y_icl,'b');
plot(x1,y_nea,'y');
plot(x1,y_spl,'g');
legend('x_i,y_i','igl','icl','nearest','spline cub');