clear all; close all; clc;
%definizione dei vettori x1,x2 ed il vettore delle uscite y
x1=[4 4.8 4.6 4.4 4.8 5]';
x2=[11.7 16.5 18.2 17.9 19 18.9]';
y=[7.1 8.2 8.1 9.8 11.6 13]';

%definizione della Matrice M
M=[x1, x2, ones(length(x1),1) ];  

% Calcolo del vettore contenente i parametri del modello (t)
t = (inv(M'*M))*M'* y;

%coefficienti delle due curve
a=t(1);
b=t(2);
c=t(3);

ys = a*x1 + b*x2 + c;

stem3(x1,x2, y,'*b'); hold on; grid on;
plot3(x1,x2, ys,'r');

% tanto più i parametri sono linearmente legati, 
% tanto migliore è la regressione (lineare...)