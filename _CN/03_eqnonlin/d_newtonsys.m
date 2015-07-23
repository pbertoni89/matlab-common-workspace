clear all; close all; clc;

% Plots
[x,y]=meshgrid(-3:.1:3);
z1=x.^2-y.^2-1;
z2=x.^2+y.^2-2*x-3;

figure(1)
mesh(x,y,z1); title('z1=f1(x,y)'); hold on; title('f1');
contour(x,y,z1,[0 0],'r','linewidth',2);

figure(2)
mesh(x,y,z2); title('z2=f2(x,y)'); hold on; title('f2');
contour(x,y,z2,[0 0],'g','linewidth',2);

figure(3)
contour(x,y,z1,[0 0],'r','linewidth',2); hold on; grid on;
contour(x,y,z2,[0 0],'g','linewidth',2);
plot(2,-1.73,'ob',2,+1.73,'ob',-1,0,'*b'); 
legend('f1=0','f2=0','semplice','semplice','multipla');
clear x y z1 z2;

% Computing
F = @(x) [ x(1)^2-x(2)^2-1, x(1)^2+x(2)^2-2*x(1)-3 ];
%  Jacobiano ( non prenderlo per x0 che lo rendano singolare!! )
JF =@(x) [ 2*x(1), -2*x(2) ; 2*x(1)-2, 2*x(2) ];

tol = 1e-8; nmax = 100;

x0_1 = [1; 1] 
jac = JF(x0_1)
[zero_1, resid_1, niter_1, ERR_1 ] = newtonsys(F, JF, x0_1, tol, nmax);
zero_1
resid_1
niter_1
x0_2 = [2; -1]
jac = JF(x0_2)
[zero_2, resid_2, niter_2, ERR_2 ] = newtonsys(F, JF, x0_2, tol, nmax);
zero_2
resid_2
niter_2
x0_3 = [-2; -2]
jac = JF(x0_3)
[zero_3, resid_3, niter_3, ERR_3 ] = newtonsys(F, JF, x0_3, tol, nmax);
zero_3
resid_3
niter_3

% More Plots

figure(4);
semilogy((1:niter_1), ERR_1, 'r', (1:niter_2), ERR_2, 'b', ...
		 (1:niter_3), ERR_3, 'g' );
grid on;
legend('(1,1)', '(2,-1)', '(-2,-2)');

% Results
% tutti gli outputs confermano la teoria.