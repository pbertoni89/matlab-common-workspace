
which es3_convoluzione;

close all;
clear;

dt= .01;
t= -20:dt:20;
tau= -20:dt:20;
z1= zeros(1,length(tau));
z2=z1; z3=z2; z4=z3; z5=z4; z6=z5; z0=z6;

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
% Algoritmo risolutivo

% x= f1(tau);

% for i=1:length(t)
%   y= f2( t(i)-tau );
%   z(i)= riemannInt(tau, tau(1), tau(length(tau)), x.*y );    
% end

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
x0= my_rect(t);
%y0= my_eps(t).*sin(2*pi*t);
y0= my_eps(t).*exp(-t);

z0norm= zeros(1, length(t));
z0shift= z0norm;

for i=1:length(t) % OK
   %y0norm= my_eps( t(i)-t ).* sin( 2*pi*(t(i)-t) );
   y0norm= my_eps( t(i)-t ).* exp( -(t(i)+t) );
   z0norm(i)= riemannInt(t, t(1), t(length(t)), x0.*y0norm );    
end

for k=1:length(t)    %% OK
   z0shift(k)= integrale ( x0 .* myshift( fliplr(y0), t(k)/dt), dt); 
end

figure('name', 'utilizzo myshift');
subplot(2,2,1); plot(t, x0, 'b'); title('rect(t)');
subplot(2,2,2); plot(t, y0, 'b'); title('e(t).sin(2.pi.t)');
subplot(2,2,3); plot(t, real(z0norm), 'b'); hold on; plot(t, imag(z0norm), 'r'); title('normale');
subplot(2,2,4); plot(t, real(z0shift), 'b'); hold on; plot(t, imag(z0shift), 'r'); title('myshift');
 
 pause;

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
x1= 2*my_rect((tau-3)/2);

for i=1:length(t)
   y1= my_rect( (t(i)-tau +1 )/3 );
   z1(i)= riemannInt(tau, tau(1), tau(length(tau)), x1.*y1);    
end

figure(1); 
hold on;
    plot(tau, real(z1), 'b');
    plot(tau, imag(z1), 'r');
hold off;
    title('$$rect(t)*rect(t)$$','Interpreter','latex','FontSize',20);
    legend({'$$\Re(z(t))$$','$$\Im(z(t))$$'},'Interpreter','latex');
    axis( [-6 6 -1 5] )

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
x2= 3*my_tri(tau/2);

for i=1:length(t)
   y2= 1i *my_tri( (t(i)-1) - tau);
   z2(i)= riemannInt(tau, tau(1), tau(length(tau)), x2.*y2);    
end

figure(2);
hold on;
    plot(tau, real(z2), 'b');
    plot(tau, imag(z2), 'r');
hold off;
    title('$$tri(t)*tri(t)$$','Interpreter','latex','FontSize',20);
    legend({'$$\Re(z(t))$$','$$\Im(z(t))$$'},'Interpreter','latex');
    axis( [-6 6 -1 5] )
    xlabel('time [sec]'); 

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
x3= my_sinc(tau);

for i=1:length(t)
   y3= -2*sin( 2*pi*t(i) - tau);
   z3(i)= riemannInt(tau, tau(1), tau(length(tau)), x3.*y3);    
end

figure(3);
hold on;
    plot(tau, real(z3), 'b'); 
    plot(tau, imag(z3), 'r');
hold off;
    title('$$sinc(t)*sin(t)$$','Interpreter','latex','FontSize',20);
    legend({'$$\Re(z(t))$$','$$\Im(z(t))$$'},'Interpreter','latex');
    axis( [min(t) max(t) min(x3)-2 max(x3)+2] )
    xlabel('time [sec]'); 
pause; close all;
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

x4= (1+1i)* my_rect(t);
y4= 2*my_tri( (t+3)/2);
z4norm= zeros(1, length(t));
z4shift= z4norm;

for i=1:length(t)    %% OK
   y4norm= 2*my_tri( (t(i) -t +3)/2 );
   z4norm(i)= riemannInt(tau, tau(1), tau(length(tau)), x4.*y4norm);    
end

for k=1:length(t)    %% OK
   z4shift(k)= integrale ( x4 .* myshift( fliplr(y4), -t(k)/dt), dt); 
end

figure('name', 'utilizzo myshift');
subplot(2,2,1); plot(t, x4, 'b'); title('$$(1+j)rect(t)$$');
subplot(2,2,2); plot(t, y4, 'b'); title('$$2tri((t+3)/2)$$');
subplot(2,2,3); plot(t, real(z4norm), 'r'); plot(t, imag(z4norm), 'r'); title('normale'); legend({'$$\Re(z(t))$$','$$\Im(z(t))$$'},'Interpreter','latex');
subplot(2,2,4); plot(t, real(z4shift), 'r'); plot(t, imag(z4shift), 'r'); title('myshift'); legend({'$$\Re(z(t))$$','$$\Im(z(t))$$'},'Interpreter','latex');
 

 pause;
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
x5= (1/2).^tau .* my_eps(tau);

for i=1:length(t)
   y5= 2*my_rect( (t(i)-1)/2 - tau);
   z5(i)= riemannInt(tau, tau(1), tau(length(tau)), x5.*y5);    
end

figure(5);
hold on;
    plot(tau, real(z5), 'b');
    plot(tau, imag(z5), 'r');
hold off;
    axis( [min(t) max(t) min(x5)-2 max(x5)+2] )
    xlabel('time [sec]'); 
    title('$$eps(t)*rect((t-1)/2)$$','Interpreter','latex','FontSize',20);
    legend({'$$\Re(z(t))$$','$$\Im(z(t))$$'},'Interpreter','latex');

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
x6= my_rect(tau);

for i=1:length(t)
   y6= my_tri( t(i)+2 - tau);
   z6(i)= riemannInt(tau, tau(1), tau(length(tau)), x6.*y6);    
end

figure(6);
hold on;
    plot(tau, real(z6), 'b');
    plot(tau, imag(z6), 'r');
hold off;
    axis( [min(t) max(t) min(x6)-2 max(x6)+2] )
    xlabel('time [sec]'); 
    title('$$tri(t+2)*rect(t)$$','Interpreter','latex','FontSize',20);
    legend({'$$\Re(z(t))$$','$$\Im(z(t))$$'},'Interpreter','latex');    
    

subplot    
    
    
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
% disp(z(1));  % convoluzione per t=-20
% disp(z(2000));  % convoluzione per t=0

% plot(t, convola(t, my_rect(t), my_rect(t+1)));
% hold on;
% pause;     IMPLEMENTARE LA FUNZIONE CONVOLA

pause;
close all;
return;