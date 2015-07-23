% Esercizio del Clima visto nell'esercitazione precedente,
% ora confrontato all'interpolazione tramite spline.

clear all; close all; clc;

n = 5;

L = -55:10:65;
DT = [3.7 3.7 3.52 3.27 3.2 3.15 3.15 3.25 3.47 3.52 3.65 3.62 3.52]';
L1 = linspace(L(1), L(end), 1000);

%% IGL
a = vander(L)\DT;
DT1 = polyval(a,L1);

figure(1);
plot(L,DT,'o'); hold on;
plot(L1,DT1,'y');

Lroma = 42;
Loslo = 59;

%DTroma = polyval(a, Lroma); % il vettore ascisse è un punto solo!
%DToslo = polyval(a, Loslo);
%plot(Lroma, DTroma, 'k^');
%plot(Loslo, DToslo, 'r^');

% Le forti variazioni del polinomio alle estremità dell’intervallo
% non sono giustificabili fisicamente, ma vengono da IGL, che pecca
% quando i punti x sono equispaziati. 
% In particolare, la stima per Oslo è assurda!

% Attenzione: le maggiori oscillazioni sono agli estremi del range

% icl
DT1c = interp1(L,DT,L1);
% spline
DTs = spline(L,DT,L1);

plot(L1,DT1c,'b');
plot(L1,DTs,'g');

% la spline è decisamente migliore della polinomiale!!
% => posso finalmente valutare meglio Roma e Oslo.
DTroma = spline(L,DT,Lroma);
DToslo = spline(L,DT,Loslo);

plot(Lroma, DTroma, 'k^');
plot(Loslo, DToslo, 'r^');

legend('L_i,\DeltaT_i','\pi_8(L)','icl','s_3','roma','oslo');
xlabel('Latitude'); ylabel('\DeltaT');