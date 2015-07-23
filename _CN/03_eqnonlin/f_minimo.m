clear; close all; clc;

a= -10; b= 10;
x = linspace(a, b, 100);

tol = 1e-8; nmax = 100;

% esistendo un solo punto di minimo, esso è la radice di f'(x)
f  = @(x) x.^2 - 3*sin(x);
df = @(x)  2*x - 3*cos(x);
d2f = @(x)  2   + 3*sin(x);

x0_1 = 0; x0_2 = -1;
tg_1 = @(x) df(x0_1)+d2f(x0_1)*(x-x0_1);
tg_2 = @(x) df(x0_2)+d2f(x0_2)*(x-x0_2);

% Newton
[zero_1n res_1n nit_1n err_1n ] = my_newton(df,d2f,x0_1,tol,nmax);
[zero_2n res_2n nit_2n err_2n ] = my_newton(df,d2f,x0_2,tol,nmax);
% Secanti
x0_s = 0; x1_s = .3;
[zero_s res_s nit_s err_s ] = my_secanti(df,x0_s,x1_s,tol,nmax);

figure(1);
plot(x, f(x), 'b'); grid on; hold on;
plot(x, df(x),'b--'); 
plot([a b],[tg_1(a) tg_1(b)],'g');
plot([a b],[tg_2(a) tg_2(b)],'m');
plot(err_1n, zeros(size(err_1n)),'ok');
plot(err_2n,zeros(size(err_2n)),'or');
% non plottabile senza cancellare dalla vista il resto dei fenomeni:
% come previsto, l'errore esplode in modulo prima di tornare a cvg
legend('f(x)','f''(x)','tan in 0', 'tan in -1', ...
	   'errs da 0', 'errs da -1');
axis([-10 10 -20 30]);

figure(2);
semilogy((1:nit_1n), err_1n, 'r', ...
		 (1:nit_2n), err_2n, 'g', (1:nit_s), err_s, 'b');
grid on;
legend('x_0 = 0','x_0 = -1','secanti');

%% Results
% newton in -1 impiega tante iterazioni: df(-1) lo spinge
% lontanissimo dalla radice...