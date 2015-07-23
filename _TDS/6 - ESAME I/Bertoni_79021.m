
% Patrizio Bertoni 79021 INFLT2

% inizializzazioni

which Bertoni_79021;

clear;
close all;

    % Assi del tempo e frequenza
    dt= .01; df=dt;
    t= -10:dt:10;
    f= -15:df:15;

    
%% %% %% ESERCIZIO 1

%% Linearità:  S[a.x1+b.x2] deve= a.S[x1]+b.S[x2]
% Parametri per la linearità
alpha= 2; beta= 2;

x11= rect(t); x12= -x11;

y11= abs(alpha*x11+beta*x12);
y12= alpha*abs(x11)+beta*abs(x12);

figure('name','Studio linearità di y(t)= abs(x(t))');
subplot(1,2,1); plot(t, y11, 'b'); title('$$S[a.x1+b.x2]$$','Interpreter','latex','FontSize',20);  axis( [-3 3 -1 3] )
subplot(1,2,2); plot(t, y12, 'b'); title('$$a.S[x1]+b.S[x2]$$','Interpreter','latex','FontSize',20);  axis( [-3 3 -1 3] )

% I due ingressi dunque non possono essere linearmente combinati e il
% sistema è non lineare.

%% Tempo invarianza: dato x1(t), x2(t)=x1(t-t') =>  y2(t) deve= y1(t-t')

t0= 3;
x21= tri(t);  x22= tri(t-t0); 

y21= abs(x21);
y22= abs(x22);


figure('name','Studio tempo-invarianza di y(t)= abs(x(t))');
subplot(1,2,1); plot(t, y21, 'b'); title('$$y1(t)=S[x(t))]$$','Interpreter','latex','FontSize',20); grid on; axis( [-8 8 -0.5 1.5] )
subplot(1,2,2); plot(t-t0, y22, 'b'); title('$$y2(t)$$','Interpreter','latex','FontSize',20); grid on; axis( [-8 8 -0.5 1.5] )
% Il -t0 nell'argomento al plot fa sì che se i due grafici si sovrappongono, ho TI
% Si verifica in effetti tale situazione. Viceversa, posso plottare su t e verificare "a occhio" la traslazione di t0 verso sinistra.
% Il Sistema è dunque TI... quindi è in definitiva LTI.

%% ULTERIORI PROPRIETA'

% Memoria: Un sistema è senza memoria quando y(t') dipende solo dallo stesso istante t' . dicesi anche ISTANTANEO
% Causalità: il sistema è causale quando l'uscita in t dipende da x(t) solo in istanti t<=t' 
% Quindi se un sistema non ha memoria è anche causale (si dimostra insiemisticamente)

% Appare evidente la natura istantanea del sistema: l'inversione di segno
% concerne infatti solamente il valore di x(t) e non "intacca" l'asse del tempo.
% Il sistema è istantaneo quindi causale.

% Stabilità BIBO: dato un ingresso x(t) limitato da |M| grande a piacere, 
% se anche y(t) è limitato da un |N| grande a piacere il sistema è stabile BIBO.
%	abs(x(t))<M ==> esiste N: abs(y(t))<N

% Anche qua è chiaro che se dò in ingresso un valore limitato, otterrò in
% uscita lo stesso valore, al limite portato da segno - a +.


%% ESERCIZIO 2

h= 10*t.*t.*rect(t); % la risposta all'impulso è una parabola 10t^2, finestrata da un rettangolo in (-t/2,t/2)

H= fourierTrasf(h, t, f);

figure('name','Risposta del sistema alle sollecitazioni 3');
subplot(1,3,1); plot(t, h, 'b');                title('$$risposta\ all\ impulso$$','Interpreter','latex','FontSize',20);  axis( [-5 5 -.5 2.5] )
subplot(1,3,2); plot(f, abs(H), 'b');           title('$$spettro\ di\ ampiezza$$','Interpreter','latex','FontSize',20);  axis( [-10 10 -.5 1.5] )
subplot(1,3,3); plot(f, unwrap(angle(H)), 'b'); title('$$spettro\ di\ fase$$','Interpreter','latex','FontSize',20);      %axis( [-15 10 -80 4] )

% Il sistema non è causale; la parabola distorce il tempo in <0 se |t|<1 e
% in t>0 se |t|>=1

%% QUIT
pause; close all; return;
