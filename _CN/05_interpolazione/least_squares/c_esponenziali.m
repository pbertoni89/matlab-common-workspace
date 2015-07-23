clear all; close all; clc;

x = [0.055 0.181 0.245 0.342 0.419 0.465 0.593 0.752]';
y = [2.80 1.76 1.61 1.21 1.25 1.13 0.52 0.28]';

x_ex = linspace(x(1), x(end), 1000); % ex sta per extended.

% sono interessato a una funzione del tipo 
%	a1 e^(-x) + a2 e^(-2x) + a3 e^(-3x) + a4 e^(-4x)
% che approssimi i dati in senso LSA (least square approx)

% dobbiamo costruire le generiche phi_i
% X matrice ove le colonne sono i vettori delle funzioni phi_i
X = [ exp(-1*x) exp(-2*x) exp(-3*x) exp(-4*x) ];

a = X\y;

y_ls = a(1)*exp(-1*x_ex) + a(2)*exp(-2*x_ex) + ...
	   a(3)*exp(-3*x_ex) + a(4)*exp(-4*x_ex);

   
plot(x,y,'ko'); hold on;
plot(x_ex, y_ls, 'c');
 