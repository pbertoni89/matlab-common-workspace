clear; close all; clc;
format long e;

a = [ +1 -3 -3 +7 +6 ];
x_macch = roots(a) % cerca le radici del polinomio x4 -3x3 -3x2 +7x +6

x_vere = [3; 2; -1; -1]; %ordinate perchè conosco l'ordine di output
% altrimenti assestare! FIXME

% Results
% riflessione sull'errore relativo, per radici multiple e semplici

errori = abs( x_macch - x_vere ) ./ abs( x_vere )
% qua avevo 3,2 con molteplicità 1 pertanto -16/1 = -16
% qua avevo -1 con molteplicità 2 pertanto -16/2 = -8

%% altro poly

a = [ 1 -4 6 -4 1 ];
x_macch = roots(a)

x_vere = [1; 1; 1; 1]; % altrimenti assestare! FIXME

errori = abs( x_macch - x_vere ) ./ abs( x_vere )
% qua avevo +1 con molteplicità 4 pertanto -16/4 = -4