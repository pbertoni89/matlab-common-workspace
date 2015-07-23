
which fourier;

clear;
close all;

% Assi del tempo e della frequenza
t= -10:.01:10;
f= -15:.01:15;

%% i) TRASFORMATE DI FOURIER NOTE
% notazione:  trasf/inv denota l'operazione da compiere | A/B/C la funzione  |  t/f la variabile d'appoggio    

trasfAt= my_rect(t);                  invAf= my_sinc(f);
trasfBt= my_tri(t);                   invBf= my_tri(f);
trasfCt= exp(-pi* t.*t );             invCf= exp(-pi* f.*f );

trasfAf= fourierTrasf(trasfAt,t,f);   invAt= fourierInv(invAf,t,f);
trasfBf= fourierTrasf(trasfBt,t,f);   invBt= fourierInv(invBf,t,f);
trasfCf= fourierTrasf(trasfCt,t,f);   invCt= fourierInv(invCf,t,f);

figure('name',' Trasformate note');
subplot(3,3,1); plot(t,trasfAt); title('$$rect(t)$$','Interpreter','latex','FontSize',15); grid on;            axis( [-2 2 -0.5 2] )
subplot(3,3,2); plot(t,trasfBt); title('$$tri(t)$$','Interpreter','latex','FontSize',15); grid on;             axis( [-2 2 -0.5 2] )
subplot(3,3,3); plot(t,trasfCt); title('$$gauss(pi.t)(t)$$','Interpreter','latex','FontSize',15); grid on;     axis( [-3 3 -0.5 2] )
subplot(3,3,4); plot(f,trasfAf); title('$$trasf(rect(t))$$','Interpreter','latex','FontSize',15); grid on;     axis( [-15 15 -0.5 2] )
subplot(3,3,5); plot(f,trasfBf); title('$$trasf(tri(t))$$','Interpreter','latex','FontSize',15); grid on;      axis( [-3 3 -0.5 2] )
subplot(3,3,6); plot(f,trasfCf); title('$$trasf(gauss(pi.t))$$','Interpreter','latex','FontSize',15); grid on; axis( [-2 2 -0.5 2] )
subplot(3,3,7); plot(t,invAt); title('$$inv(sinc(f))$$','Interpreter','latex','FontSize',15); grid on;         axis( [-2 2 -0.5 2] )  
subplot(3,3,8); plot(t,invBt); title('$$inv(tri(f))$$','Interpreter','latex','FontSize',15); grid on;          axis( [-2 2 -0.5 2] )  
subplot(3,3,9); plot(t,invCt); title('$$inv(gauss(pi.f))$$','Interpreter','latex','FontSize',15); grid on;     axis( [-2 2 -0.5 2] )  

%%
% ii) TRASFORMATE PARTICOLARI

Xt= my_sinc(t).*my_sinc(t).*cos(10*pi*t);
Yt= my_sinc(t).*cos(10*pi*t).*cos(10*pi*t);

Xf= fourierTrasf(Xt,t,f);
Yf= fourierTrasf(Yt,t,f);

figure('name',' Trasformate sconosciute');
subplot(2,2,1); plot(t,Xt); title('$$x(t)$$','Interpreter','latex','FontSize',15); grid on;  axis( [-2 2 -1 1] )
subplot(2,2,2); plot(t,Yt); title('$$y(t)$$','Interpreter','latex','FontSize',15); grid on;  axis( [-10 10 -0.5 2] )
subplot(2,2,3); plot(f,Xf); title('$$X(f)$$','Interpreter','latex','FontSize',15); grid on;  axis( [-15 15 -0.5 2] )
subplot(2,2,4); plot(f,Yf); title('$$Y(f))$$','Interpreter','latex','FontSize',15); grid on; axis( [-15 15 -0.5 2] )
   

%% iii) Proprietà della TdF

t= -10:.01:10;
tau= t;
f= -15:.01:15;

es3x1= my_rect(t);
es3x2= my_tri(t);
es3x3= my_sinc(3*t);
es3x4= my_sinc(t).*my_sinc(t);

% Convoluzione

y= zeros(1,length(t));   % vettore temporaneo
conv1=y; conv2= conv1; conv3= conv2;

for i=1:length(t)
    y= my_tri(t(i)-tau);
   conv1(i)= riemannInt(tau, tau(1), tau(length(tau)), es3x1 .* y);    
end
y= zeros(1,length(t));   
for i=1:length(t)
    y= my_sinc(3*(t(i)-tau));
   conv2(i)= riemannInt(tau, tau(1), tau(length(tau)), es3x1 .* y );    
end
y= zeros(1,length(t));   
for i=1:length(t)
    y= my_sinc(t(i)-tau).*my_sinc(t(i)-tau);
   conv3(i)= riemannInt(tau, tau(1), tau(length(tau)), es3x3 .* y);    
end

prod1= fourierTrasf(es3x1,t,f).*fourierTrasf(es3x2,t,f); prod1anti= fourierInv(prod1,t,f);
prod2= fourierTrasf(es3x1,t,f).*fourierTrasf(es3x3,t,f); prod2anti= fourierInv(prod2,t,f);
prod3= fourierTrasf(es3x3,t,f).*fourierTrasf(es3x4,t,f); prod3anti= fourierInv(prod3,t,f);

figure('name','Proprieta: convoluzione&prodotto');
subplot(2,3,1); plot(t,conv1); title('$$rect(t)*tri(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,3,2); plot(t,conv2); title('$$rect(t)*sinc(3t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,3,3); plot(t,conv3); title('$$sinc(3t)*sinc2(t)(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,3,4); plot(t,prod1anti); title('$$inv(trasf1.trasf2)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,3,5); plot(t,prod2anti); title('$$inv(trasf1.trasf3)$$','Interpreter','latex','FontSize',15); grid on;
subplot(2,3,6); plot(t,prod3anti); title('$$inv(trasf3.trasf4)$$','Interpreter','latex','FontSize',15); grid on;


%% exit
pause; close all; return;
