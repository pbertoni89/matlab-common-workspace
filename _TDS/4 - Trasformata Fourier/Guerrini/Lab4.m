% TEORIA DEI SEGNALI
% Laboratorio Matlab del 18/03/2011

clear all;
close all;

dt = 0.01;
df = 0.01;
t = -10:dt:10;
f = -15:df:15;

% ***************
% * ESERCIZIO 2 *
% ***************

% Punto 1

x1 = rect(t);
X1 = T_Fourier(x1,t,f);
inv_x1 = Inv_T_Fourier(X1,f,t);

x2 = tri(t);
X2 = T_Fourier(x2,t,f);
inv_x2 = Inv_T_Fourier(X2,f,t);

x3 = exp(-pi*t.^2);
X3 = T_Fourier(x3,t,f);
inv_x3 = Inv_T_Fourier(X3,f,t);

figure('name','Trasformate note');
subplot(3,3,1); plot(t,x1); title('$$x_1(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,2); plot(f,real(X1)); title('$$X_1(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,3); plot(t,real(inv_x1)); title('$$\hat{x}_1(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,4); plot(t,x2); title('$$x_2(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,5); plot(f,real(X2)); title('$$X_2(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,6); plot(t,real(inv_x2)); title('$$\hat{x}_2(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,7); plot(t,x3); title('$$x_3(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,8); plot(f,real(X3)); title('$$X_3(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,9); plot(t,real(inv_x3)); title('$$\hat{x}_3(t)$$','Interpreter','latex','FontSize',15); grid on;


% ***************
% * ESERCIZIO 2 *
% ***************

% Punto 2

x4 = (sinc(t).^2).*cos(2*pi*5*t);
X4 = T_Fourier(x4,t,f);
inv_x4 = Inv_T_Fourier(X4,f,t);

x5 = sinc(t).*(cos(2*pi*5*t).^2);
X5 = T_Fourier(x5,t,f);
inv_x5 = Inv_T_Fourier(X5,f,t);

figure('name','Trasformate note');
subplot(2,3,1); plot(t,x4); title('$$x_4(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,3,2); plot(f,real(X4)); title('$$X_4(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,3,3); plot(t,real(inv_x4)); title('$$\hat{x}_4(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,3,4); plot(t,x5); title('$$x_5(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,3,5); plot(f,real(X5)); title('$$X_5(f)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,3,6); plot(t,real(inv_x5)); title('$$\hat{x}_5(t)$$','Interpreter','latex','FontSize',15); grid on;


% ***************
% * ESERCIZIO 3 *
% ***************

% Punto 1


x6 = rect(t);
x7 = tri(t);
X6_7 = T_Fourier(x6,t,f).*T_Fourier(x7,t,f);
x6_7 = Inv_T_Fourier(X6_7,f,t);

x8 = rect(t);
x9 = sinc(3*t);
X8_9 = T_Fourier(x8,t,f).*T_Fourier(x9,t,f);
x8_9 = Inv_T_Fourier(X8_9,f,t);

x10 = sinc(t).^2;
x11 = sinc(3*t);
X10_11 = T_Fourier(x10,t,f).*T_Fourier(x11,t,f);
x10_11 = Inv_T_Fourier(X10_11,f,t);

figure('name','Trasformate note');
subplot(3,3,1); plot(t,x6); title('$$x_6(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,2); plot(t,x7); title('$$x_7(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,3); plot(t,x6_7); title('$$x_{6-7}(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,4); plot(t,x8); title('$$x_8(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,5); plot(t,x9); title('$$x_9(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,6); plot(t,x8_9); title('$$x_{8-9}(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,7); plot(t,x10); title('$$x_{10}(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,8); plot(t,x11); title('$$x_{11}(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,3,9); plot(t,x10_11); title('$$x_{10-11}(t)$$','Interpreter','latex','FontSize',15); grid on;


% ***************
% * ESERCIZIO 3 *
% ***************

% Punto 2
y1 = sinc(5*t);
Y1 = T_Fourier(y1,t,f);
y2 = sinc(5*(t-1/2));
Y2 = T_Fourier(y2,t,f);
y3 = sinc(5*(t-1));
Y3 = T_Fourier(y3,t,f);

figure;
subplot(3,1,1); plot(f,real(Y1),'b'); hold on; plot(f,imag(Y1),'r'); title('$$Y_1(f)$$','Interpreter','latex','FontSize',20); grid on; legend({'$$\Re(Y_1(f))$$','$$\Im(Y_1(f))$$'},'Interpreter','latex');
subplot(3,1,2); plot(f,real(Y2),'b'); hold on; plot(f,imag(Y2),'r'); title('$$Y_2(f)$$','Interpreter','latex','FontSize',20); grid on; legend({'$$\Re(Y_2(f))$$','$$\Im(Y_2(f))$$'},'Interpreter','latex');
subplot(3,1,3); plot(f,real(Y3),'b'); hold on; plot(f,imag(Y3),'r'); title('$$Y_3(f)$$','Interpreter','latex','FontSize',20); grid on; legend({'$$\Re(Y_3(f))$$','$$\Im(Y_3(f))$$'},'Interpreter','latex');


% ***************
% * ESERCIZIO 4 *
% ***************

% Punto 1

B = 2;
h = 2*B*sinc(2*B*t);

h1 = h.*rect(t/4);
H1 = T_Fourier(h1,t,f);
figure('name','Fenomeni di Gibbs, B=2');
subplot(2,3,1); plot(t,h1); title('$$x_1^1(t)$$','Interpreter','latex','FontSize',20); grid on;
subplot(2,3,4); plot(f,H1); title('$$X_1^1(f)$$','Interpreter','latex','FontSize',20); grid on;

h2 = h.*rect(t/10);
H2 = T_Fourier(h2,t,f);
subplot(2,3,2); plot(t,h2); title('$$x_2^1(t)$$','Interpreter','latex','FontSize',20); grid on;
subplot(2,3,5); plot(f,H2); title('$$X_2^1(f)$$','Interpreter','latex','FontSize',20); grid on;

h3 = h;
H3 = T_Fourier(h2,t,f);
subplot(2,3,3); plot(t,h3); title('$$x_3^1(t)$$','Interpreter','latex','FontSize',20); grid on;
subplot(2,3,6); plot(f,H3); title('$$X_3^1(f)$$','Interpreter','latex','FontSize',20); grid on;

% Punto 2

B = 10;
h = 2*B*sinc(2*B*t);

h1 = h.*rect(t/4);
H1 = T_Fourier(h1,t,f);
figure('name','Fenomeni di Gibbs, B=10');
subplot(2,3,1); plot(t,h1); title('$$x_1^2(t)$$','Interpreter','latex','FontSize',20); grid on;
subplot(2,3,4); plot(f,H1); title('$$X_1^2(f)$$','Interpreter','latex','FontSize',20); grid on;

h2 = h.*rect(t/10);
H2 = T_Fourier(h2,t,f);
subplot(2,3,2); plot(t,h2); title('$$x_2^2(t)$$','Interpreter','latex','FontSize',20); grid on;
subplot(2,3,5); plot(f,H2); title('$$X_2^2(f)$$','Interpreter','latex','FontSize',20); grid on;

h3 = h;
H3 = T_Fourier(h2,t,f);
subplot(2,3,3); plot(t,h3); title('$$x_3^2(t)$$','Interpreter','latex','FontSize',20); grid on;
subplot(2,3,6); plot(f,H3); title('$$X_3^2(f)$$','Interpreter','latex','FontSize',20); grid on;






