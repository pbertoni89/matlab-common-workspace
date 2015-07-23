%% 1
clc, close all, clear all

F = @(x,y) [ tan(x)-.6*sin(x)-.3*sin(y); ...
		   tan(y)-.6*sin(x)-.6*sin(y) ];
% non prendere JF per x0 che lo rendano singolare,
JF =@(x,y) [ 1/(cos(x).^2)-.6*cos(x), -.3*cos(y) ;
		    -.6*cos(x), 1/(cos(y).^2)-.6*cos(y) ];

tol = 1e-8; nmax = 100; xa = -2.1; xb = 2.1;

x = linspace(xa,xb,100); y = x; z = F(x,y);
subplot(1,2,1), plot(x,z(1,:),'r'), title('x_1')
subplot(1,2,2), plot(y,z(2,:),'g'), title('x_2')
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

F = @(x) [tan(x(1))-.6*sin(x(1))-.3*sin(x(2)), ...
		  tan(x(2))-.6*sin(x(1))-.6*sin(x(2))];
JF =@(x) [ 1/(cos(x(1)).^2)-.6*cos(x(1)), -.3*cos(x(2)) ;
		   -.6*cos(x(1)), 1/(cos(x(2)).^2)-.6*cos(x(2)) ];

tol = 1e-8; nmax = 100;

x0 = [0; 0] 
jac = JF(x0), det00 = det(jac)

[zero_1, resid_1, niter_1, ERR_1 ] = newtonsys(F, JF, x0, tol, nmax);
zero_1, resid_1, niter_1

%% 2 già fatto in un altro tde, tale e quale!!!