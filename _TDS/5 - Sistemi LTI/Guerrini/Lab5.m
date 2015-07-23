% TEORIA DEI SEGNALI
% Laboratorio Matlab del 25/03/2011

clear all;
close all;

dt = .01;
t = -10:dt:10;
df = .01;
f = -15:df:15;



% ***************
% * ESERCIZIO 1 *
% ***************

% Input definition

alpha = 3;
beta = 2;

x1 = 2*rect(t);
x2 = tri(t-1);
xlc = alpha*x1+beta*x2;

t0 = 3;
x1shift = myshift(x1,t0/dt);

% Punto 1 - linearita

% S1

T = 2;
h = rect((t-T/2)/T);

y11 = zeros(size(t));
y21 = zeros(size(t));
for k = 1:length(t)
%     y11(k) = integrale(h*2.*rect(t(k)-t),dt); % explicit
%     y21(k) = integrale(h.*tri(t(k)-t-1),dt); % explicit
%     y11(k) = integrale(h.*myshift(fliplr(x1),t(k)/dt),dt); % flip and shift
%     y21(k) = integrale(h.*myshift(fliplr(x2),t(k)/dt),dt); % flip and shift
    y11(k) = integrale(x1(max(1,k-T/dt):k-1),dt); % convolution with rect = integral
    y21(k) = integrale(x2(max(1,k-T/dt):k-1),dt); % convolution with rect = integral
end

ya1 = alpha*y11+beta*y21;
figure(1);
plot(t,ya1,'r'); title('$$y_{a1}(t)=\alpha S_1[x_1(t)]+\beta S_1[x_2(t)]$$','Interpreter','latex','FontSize',15); grid on;
axis([min(t) max(t) min(ya1)-0.5 max(ya1)+0.5])

yb1 = zeros(size(t));
for k = 1:length(t)
%     yb1(k) = integrale(h.*(alpha*2*rect(t(k)-t)+beta*tri(t(k)-t-1)),dt); % explicit
%     yb1(k) = integrale(h.*myshift(fliplr(xlc),t(k)/dt),dt); % flip and shift
    yb1(k) = integrale(xlc(max(1,k-T/dt):k-1),dt); % convolution with rect = integral
end

figure(2);
plot(t,yb1,'b'); title('$$y_{b1}(t)=S_1[\alpha x_1(t)+\beta x_2(t)]$$','Interpreter','latex','FontSize',15); grid on;
axis([min(t) max(t) min(yb1)-0.5 max(yb1)+0.5])
pause;

% S2

y12 = x1.^2;
y22 = x2.^2;
ya2 = alpha*y12+beta*y22;
figure(3);
plot(t,ya2,'r'); title('$$y_{a2}(t)=\alpha S_2[x_1(t)]+\beta S_2[x_2(t)]$$','Interpreter','latex','FontSize',15); grid on;
axis([min(t) max(t) min(ya2)-0.5 max(ya2)+0.5])

yb2 = xlc.^2;
figure(4);
plot(t,yb2,'b'); title('$$y_{b2}(t)=S_2[\alpha x_1(t)+\beta x_2(t)]$$','Interpreter','latex','FontSize',15); grid on;
axis([min(t) max(t) min(yb2)-0.5 max(yb2)+0.5])
pause;

% S3

t2 = 2*t;   % invece di tenere t costante e calcolare x in t/2
            % si tiene x costante e si mette 2t (scalatura reciproca).
            % Dato che così le uscite sono vettori uguali agli ingressi
            % la linearita si vede subito.
y13 = x1;
y23 = x2;
ya3 = alpha*y13+beta*y23;
figure(5);
plot(t2,ya3,'r'); title('$y_{a3}(t)=\alpha S_3[x_1(t)]+\beta S_3[x_2(t)]$','Interpreter','latex','FontSize',15); grid on;
axis([min(t2) max(t2) min(ya3)-0.5 max(ya3)+0.5])

yb3 = xlc;
figure(6);
plot(t2,yb3,'b'); title('$$y_{b3}(t)=S_3[\alpha x_1(t)+\beta x_2(t)]$$','Interpreter','latex','FontSize',15); grid on;
axis([min(t2) max(t2) min(yb3)-0.5 max(yb3)+0.5])
pause;

close all;

% Punto 2 - Time invariance

% S1

yta1 = zeros(size(t));
for k = 1:length(t)
%     yta1(k) = integrale(h*2.*rect(t(k)-t-t0),dt); % explicit
%     yta1(k) = integrale(h.*myshift(fliplr(x1shift),t(k)/dt),dt); % flip and shift
    yta1(k) = integrale(x1shift(max(1,k-T/dt):k-1),dt); % convolution with rect = integral
end

figure(1);
plot(t,yta1,'r'); title('$$y_{ta1}(t)=S_1[x_1(t-t_0)]$$','Interpreter','latex','FontSize',15); grid on;
axis([min(t) max(t) min(yta1)-0.5 max(yta1)+0.5])

ytb1 = myshift(y11,t0/dt);
figure(2);
plot(t,ytb1,'b'); title('$$y_{tb1}(t)=y_{11}(t-t_0)$$','Interpreter','latex','FontSize',15); grid on;
axis([min(t) max(t) min(ytb1)-0.5 max(ytb1)+0.5])
pause;

% S2

yta2 = x1shift.^2;
figure(3);
plot(t,yta2,'r'); title('$$y_{ta2}(t)=S_2[x_1(t-t_0)]$$','Interpreter','latex','FontSize',15); grid on;
axis([min(t) max(t) min(yta2)-0.5 max(yta2)+0.5])

ytb2 = myshift(y12,t0/dt);
figure(4);
plot(t,ytb2,'b'); title('$$y_{tb2}(t)=y_{12}(t-t_0)$$','Interpreter','latex','FontSize',15); grid on;
axis([min(t) max(t) min(ytb2)-0.5 max(ytb2)+0.5])
pause;

% S3

t2 = 2*t;
yta3 = x1shift; % di nuovo, uscita=ingresso e poi cambio il vettore dei tempi
figure(5);
plot(t2,yta3,'r'); title('$y_{a3}(t)=S_3[x_1(t-t0)]$','Interpreter','latex','FontSize',15); grid on;
axis([min(t2) max(t2) min(yta3)-0.5 max(yta3)+0.5])

ytb3 = x1;  % uscita=ingresso non traslato, il vettore dei tempi deve essere scalato
            % reciprocamente e poi traslato dell'opposto
figure(6);
plot(t2+t0,ytb3,'b'); title('$$y_{tb3}(t)=y_{13}(t-t0)$$','Interpreter','latex','FontSize',15); grid on;
axis([min(t2+t0) max(t2+t0) min(ytb3)-0.5 max(ytb3)+0.5])
pause;

% Punto 3

% S1 è LTI. h(t)=0 per t<0 => causale. h(t) è assolutamente integrabile =>
% stabile BIBO. h(t) non è una delta in t=0 => ha memoria.

% S2 è NL, TI. È istantaneo => causale e senza memoria. Se l'ingresso è
% limitato da M, l'uscita è limitata da M^2 => stabile BIBO.

% S3 è L, TV. Se t<0, l'uscita anticipa l'ingresso (y(-10)=x(-5)); se t>0,
% l'uscita segue l'ingresso (y(10)=x(5)) => non causale, con memoria.
% L'uscita assume gli stessi valori che assume l'ingresso = stabile BIBO.

% ***************
% * ESERCIZIO 2 *
% ***************

close all;

% h già definito

H = T_Fourier(h,t,f);
figure(1)
plot(f,abs(H),'b'); % |H(f)|: modulo del sinc
title('$\vert H_1(f)\vert$','Interpreter','latex','FontSize',15); grid on;
figure(2)
plot(f,unwrap(angle(H)),'r');
% <H(f): salti di fase della trasformata del rect (quando il sinc cambia segno)
% + componente lineare data dal ritardo (pendenza negativa perchè t0>0)
title('$<H_1(f)$','Interpreter','latex','FontSize',15); grid on;

fvet = .2:.2:1;

x = zeros(length(fvet),length(t));
y = zeros(length(fvet),length(t));
for n = 1:length(fvet)
    x(n,:) = cos(2*pi*fvet(n)*t);
    for k = 1:length(t)
        y(n,k) = integrale(h.*myshift(fliplr(x(n,:)),t(k)/dt),dt); % flip and shift
    end
    figure(2+n);
    plot(t,y(n,:));
    title(sprintf('$$y_%d(t)$$',n),'Interpreter','latex','FontSize',15); grid on;
    findex = 1+(fvet(n)+15)/df;
    tindex = find(t==0);
    fprintf('|H(f_%d)| = %.2f; infatti max(y_%d(t))=%.2f.\n\n',...
        n,abs(H(findex)),n,max(y(n,T/dt:end)));
    fprintf('<H(f_%d) = %.2f; infatti la fase di y_%d(t) vale %.2f.\n\n',...
        n,angle(H(findex)),n,acos(y(n,tindex)/max(y(n,T/dt:end))));
    % dove il modulo è zero la fase non è significativa...
end

% y(t) per f_5=1 è nullo perchè |H(1)|=0; d'altro canto, l'uscita per
% quella frequenza d'ingresso è in tutti gli istanti pari all'integrale 
% di 2 periodi completi.

