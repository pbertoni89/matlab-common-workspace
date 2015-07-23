% TEORIA DEI SEGNALI
% Laboratorio Matlab del 11/03/2011

clear all
close all

% Asse temporale
dt = 0.01;
t = -10:dt:10;

% ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

tau = t;
dtau = dt;
z0 = zeros(size(t));
z1 = z0; z2 = z1; z3 = z1; z4 = z1; z5 = z1;
z0s = z0; z1s = z0s; z2s = z1s; z3s = z1s; z4s = z1s; z5s = z1s;

x0 = my_rect(t);               y0 = my_tri(t);
x1 = 2*my_rect((t-3)/2);       y1 = my_rect((t+1)/3);
x2 = 3*my_tri(t/2);            y2 = 1i*my_tri(t-1);
x3 = my_sinc(t);               y3 = -2*sin(2*pi*t);
x4 = (1+1i)*rect(t);           y4 = 2*my_tri((t+3)/2);
x5 = .5.^t.*my_eps(t);         y5 = my_rect((t-1)/2);

for k = 1:length(t)
    
    z0(k) = integrale( x0 .*  my_tri(t(k)-t)          ,dt);
    z1(k) = integrale( x1 .*  my_rect((t(k)-t+1)/3)   ,dt);
    %z2(k) = integrale( x2 .*  (1i)*my_tri(t(k)-t-1)     ,dt);
   % z2(k) = integrale( x2 .*  my_tri(t(k)-t)     ,dt);
    z3(k) = integrale( x3 .*  -2*sin(2*pi*(t(k)-t))   ,dt);
    z4(k) = integrale( x4 .*  2*my_tri((t(k)-t-3)/2)  ,dt);
    z5(k) = integrale( x5 .*  my_rect((t(k)-t-1)/2)   ,dt);    
    
    z0s(k)= integrale ( x0 .* myshift( fliplr(y0), t(k)/dt), dt);
    z1s(k)= integrale ( x1 .* myshift( fliplr(y1), t(k)/dt), dt); 
    z2s(k)= integrale ( x2 .* myshift( fliplr(y2), t(k)/dt), dt); 
    z3s(k)= integrale ( x3 .* myshift( fliplr(y3), t(k)/dt), dt); 
    z4s(k)= integrale ( x4 .* myshift( fliplr(y4), t(k)/dt), dt); 
    z5s(k)= integrale ( x5 .* myshift( fliplr(y5), t(k)/dt), dt); 
    
end


figure(1); hold on; plot(t,real(z0),'b'); plot(t,imag(z0),'r'); hold off; title('$$rect(t)*tri(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_0(t)*y_0(t))$$','$$\Im(x_1(t)*y_1(t))$$'},'Interpreter','latex');
figure(2); hold on; plot(t,real(z1),'b'); plot(t,imag(z1),'r'); hold off; title('$$rect(t)*rect(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_1(t)*y_1(t))$$','$$\Im(x_1(t)*y_1(t))$$'},'Interpreter','latex');
figure(3); hold on; plot(t,real(z2),'b'); plot(t,imag(z2),'r'); hold off; title('$$tri(t)*jtri(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_2(t)*y_2(t))$$','$$\Im(x_2(t)*y_2(t))$$'},'Interpreter','latex');
figure(4); hold on; plot(t,real(z3),'b'); plot(t,imag(z3),'r'); hold off; title('$$sinc(t)*sin(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_3(t)*y_3(t))$$','$$\Im(x_3(t)*y_3(t))$$'},'Interpreter','latex');
figure(5); hold on; plot(t,real(z4),'b'); plot(t,imag(z4),'r'); hold off; title('$$jrect(t)*tri(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_4(t)*y_4(t))$$','$$\Im(x_4(t)*y_4(t))$$'},'Interpreter','latex');
figure(6); hold on; plot(t,real(z5),'b'); plot(t,imag(z5),'r'); hold off; title('$$eps(t)*rect(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_5(t)*y_5(t))$$','$$\Im(x_5(t)*y_5(t))$$'},'Interpreter','latex');

figure('name','1s'); hold on; plot(t,real(z0s),'b'); plot(t,imag(z0s),'r'); hold off; title('$$rect(t)*tri(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_0(t)*y_0(t))$$','$$\Im(x_1(t)*y_1(t))$$'},'Interpreter','latex');
figure('name','2s'); hold on; plot(t,real(z1s),'b'); plot(t,imag(z1s),'r'); hold off; title('$$rect(t)*rect(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_1(t)*y_1(t))$$','$$\Im(x_1(t)*y_1(t))$$'},'Interpreter','latex');
figure('name','3s'); hold on; plot(t,real(z2s),'b'); plot(t,imag(z2s),'r'); hold off; title('$$tri(t)*jtri(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_2(t)*y_2(t))$$','$$\Im(x_2(t)*y_2(t))$$'},'Interpreter','latex');
figure('name','4s'); hold on; plot(t,real(z3s),'b'); plot(t,imag(z3s),'r'); hold off; title('$$sinc(t)*sin(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_3(t)*y_3(t))$$','$$\Im(x_3(t)*y_3(t))$$'},'Interpreter','latex');
figure('name','5s'); hold on; plot(t,real(z4s),'b'); plot(t,imag(z4s),'r'); hold off; title('$$jrect(t)*tri(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_4(t)*y_4(t))$$','$$\Im(x_4(t)*y_4(t))$$'},'Interpreter','latex');
figure('name','6s'); hold on; plot(t,real(z5s),'b'); plot(t,imag(z5s),'r'); hold off; title('$$eps(t)*rect(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_5(t)*y_5(t))$$','$$\Im(x_5(t)*y_5(t))$$'},'Interpreter','latex');



return;