% Venturini Nicola 76937
% ESERCITAZIONE 2   

clear all;
close all;

n=-10:10;

% ESERCIZIO 1
%A

z1=conv_lin(shift(rectN(n,5),n,3),shift(rectN(n,7),n,-1),n);

hold on
stem(n,z1,'k','filled','linewidth',4)
stem(n,shift(rectN(n,5),n,3),'b','filled','linewidth',3);
stem(n,shift(rectN(n,7),n,-1),'r','filled');

%B

% ESERCIZIO 2






