% TEORIA DEI SEGNALI
% Laboratorio Matlab del 11/03/2011

% Inizializzazione
% Cancello tutte le variabili
clear all
% Chiudo tutte le finestre
close all

% Asse temporale
dt = 0.01;
t = -10:dt:10;

% ********* Punto 1.i **********
x1 = 4*rect((t-3)/4);
x2 = 3*tri((t+2)/5);
x3 = gradino(4-t);


figure(1)   % Apre la finestra 1. Se non esiste la crea.
hold on     % Permette di sovrapporre più grafici nella stessa finestra
plot(t,x1);
plot(t,x2,'r'); % L'ultimo parametro specifica il colore da usare.
plot(t,x3,'k'); % Vedi "help plot" per dettagli.
hold off    % Chiude l'"hold on"

% ********** Punto 1.ii **********
x4 = x1+x2+x3;
x5 = x1.*x2.*x3;

figure(2)
hold on
plot(t,x4);
plot(t,x5,'r');
hold off

% ********** Punto 1.iii **********
% Qui usiamo la funzione sinc predefinita in Matlab. Si veda comunque la
% funzione mysinc

x6 = sinc(t);
x7 = cos(pi*t);
x8 = x6.*x7;

figure(3)
hold on
plot(t,x6,'b--'); % Questo comando crea un grafico tratteggiato
plot(t,x7,'r--'); % Vedi l'help
plot(t,x8,'k');
axis([min(t), max(t), -1, 1]); % Imposta gli assi del grafico visualizzato. Vedi help.
hold off

% ********** Punto 1.iv **********
x9=sinc(2*t);

figure(4)
plot(t,x9);
axis([min(t), max(t), -1, 1]);

% N.B. 
% Si ha x9 = x8.
%
% DIM.
% x8(t) = sinc(t)*cos(pi*t) 
%       = sen(pi*t)*cos(pi*t)/(pi*t) 
%       = [2*sen(pi*t)*cos(pi*t)]/[2*(pi*t)]
%       = sen(2*pi*t)/(2*pi*t) = sinc(2*t) = x9(t)

% ********** Punto 1.v **********
x10 = (sinc(t-2)).^2;

figure(5)
plot(t,x10);

% ********** Punto 1.vi **********
% Versione for/if
% y = zeros(size(t));
% for k = 1:length(t)
%     if (t(k)>=-5) && (t(k)<0)
%         y(k) = 2*sin(2*pi*t(k));
%     elseif (t(k)>=0) && (t(k)<1)
%         y(k) = t(k);
%     elseif (t(k)>=1) && (t(k)<7)
%         y(k) = 1;
%     elseif (t(k)>=7) && (t(k)<8)
%         y(k) = 8-t(k);
%     end
% end

% Versione logica
% y = 2*((t>=-5)&(t<0)).*sin(2*pi*t) + ((t>=0)&(t<1)).*t...
%     + ((t>=1)&(t<7)) + ((t>=7)&(t<8)).*(8-t);

% Versione "finestrata" (una tra le possibili)
y = 2*sin(2*pi*t).*rect((t+5/2)/5) + 4*tri((t-4)/4)-3*tri((t-4)/3);

figure(6)
plot(t,y,'LineWidth',2); % Esempio di manipolazione di proprieta' del grafico
set(gca,'FontSize',12,'XTick',-10:10); % Esempio di manipolazione di proprietà degli assi
axis([min(t) max(t) -2.5 2.5])
grid on % Attiva la griglia sulla finestra corrente 
pause;

close all;

% ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

% ***************
% * ESERCIZIO 2 *
% ***************

% ********* Punto 2.ii **********

fprintf('L''area del rect è : %.2f\n',integrale(rect(t),dt));
fprintf('L''area del tri è : %.2f\n',integrale(tri(t),dt));
fprintf('L''energia del rect è : %.2f\n',integrale(rect(t).^2,dt));
fprintf('L''energia del tri è : %.2f\n',integrale(tri(t).^2,dt));

T = 3; % periodo fondamentale
x11 = sin(2*pi/T*t(t>=0&t<T)); % un periodo del sin (x11 è più corto di t!!!)
fprintf('La potenza del sin è : %.2f\n',1/T*integrale(x11.^2,dt));  % 1/T viene prima

% ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

% ***************
% * ESERCIZIO 3 *
% ***************

% ********* Punto 3.i **********
% Introduciamo l'asse ausiliario tau, usato per l'integrazione. Per
% semplicità usiamo lo stesso asse t, ma non è necessario.
tau = t;
dtau = dt;
z = zeros(size(t));
for k = 1:length(t)
    % I segnali scritti a sinistra vanno interpretati come funzioni di tau
    % Stiamo integrando in tau, per ogni valore fissato di t. Il risultato
    % è quindi funzione di t.
    z(k) = integrale(rect(tau).*tri(t(k)-tau),dtau);
end

%figure(1); 
%plot(t,z,'b'); 
%title('$$rect(t)*tri(t)$$','Interpreter','latex','FontSize',20);
%legend({'$$rect(t)*tri(t)$$'},'Interpreter','latex');


% ********* Punto 3.ii **********
%Inizializziamo i vettori delle convoluzioni
z1 = zeros(size(t)); z2 = z1; z3 = z1; z4 = z1; z5 = z1;
for k = 1:length(t)
    % I segnali scritti a sinistra vanno interpretati come funzioni di tau
    % Stiamo integrando in tau, per ogni valore fissato di t. Il risultato
    % è quindi funzione di t.
    z1(k) = integrale((2*rect((tau-3)/2)).*(rect((t(k)-tau+1)/3)),dtau);
    z2(k) = integrale((3*tri(tau/2)).*(1i*tri(t(k)-tau-1)),dtau);
    z3(k) = integrale((sinc(tau)).*(-2*sin(2*pi*(t(k)-tau))),dtau);
    z4(k) = integrale(((1+1i)*rect(tau)).*(2*tri((t(k)-tau-3)/2)),dtau);
    z5(k) = integrale(((1/2).^tau.*gradino(tau)).*(rect((t(k)-tau-1)/2)),dtau);    
end


figure(2); hold on; plot(t,real(z1),'b'); plot(t,imag(z1),'r'); hold off; title('$$rect(t)*rect(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_1(t)*y_1(t))$$','$$\Im(x_1(t)*y_1(t))$$'},'Interpreter','latex');
figure(3); hold on; plot(t,real(z2),'b'); plot(t,imag(z2),'r'); hold off; title('$$tri(t)*jtri(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_2(t)*y_2(t))$$','$$\Im(x_2(t)*y_2(t))$$'},'Interpreter','latex');
figure(4); hold on; plot(t,real(z3),'b'); plot(t,imag(z3),'r'); hold off; title('$$sinc(t)*sin(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_3(t)*y_3(t))$$','$$\Im(x_3(t)*y_3(t))$$'},'Interpreter','latex');
figure(5); hold on; plot(t,real(z4),'b'); plot(t,imag(z4),'r'); hold off; title('$$jrect(t)*tri(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_4(t)*y_4(t))$$','$$\Im(x_4(t)*y_4(t))$$'},'Interpreter','latex');
figure(6); hold on; plot(t,real(z5),'b'); plot(t,imag(z5),'r'); hold off; title('$$eps(t)*rect(t)$$','Interpreter','latex','FontSize',20); legend({'$$\Re(x_5(t)*y_5(t))$$','$$\Im(x_5(t)*y_5(t))$$'},'Interpreter','latex');


