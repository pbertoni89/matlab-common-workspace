clc; %cancella la command window
close all; %chiude tutte le figure
clear all; %cancella tutte le varibili

% Simulazione di un corpo di massa m soggetta a una forza u e una forza elastica e una viscosa.
% m*a=u-k*y-b*v
% a accelerazione
% v velocit�
% y posizione
% k costante elastica
% b costante smorzamento

% Nei sistemi meccanici, normalmente si considerano come grandezze di stato
% la posizione e la velocita.
% Si definisce quindi x1=y e x2=v
% la velocit� � la derivata della posizione quindi
% Dx1=x2 (dove con Dx1 intendo la derivata di x1)
% Dx2=a=-k/m*x1-b/m*x2+u/m

% definiamo x il vettore x=[x1;x2] e quindi
% Dx=[0 1;-k/m -c/m]*x+[0;1/m]*u

% l'uscita sar�
%y=[1 0]*x+0*u

% per cui
% A=[0 1;-k/m -b/m], B=[0;1/m], C=[1 0], D=0


% Dati m=1, k=0.25, c=4, u=2, tempo di simulazione 10
