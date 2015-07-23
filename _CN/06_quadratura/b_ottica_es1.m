clear all; close all; clc; format longe

xa =  3.e-4;
xb = 14.e-4;
M = 51;
H = (xb-xa)/M;
x = linspace(xa,xb,M); % x son le lunghezze d'onda in cm

fE = @(x) (2.39e-11)./((x.^5).*(exp(1.432./(213*x))-1));

EnTrap = i_c_trap(fE,xa,xb,M)
EnMlab = trapz(x,fE(x))

maxAbsDerSec = 2.545420655473487e+8;
ErrMax = (((xb-xa)*H^2)/12)*maxAbsDerSec

	% En - EnTrap > 0 => En < ErrMax + EnTrap;
	% else            => En > EnTrap - ErrMax;
% =>
ub = EnTrap + ErrMax;
lb = EnTrap - ErrMax;
fprintf('%d < En < %d\n\n', lb,ub);

%% determinare M10 per approssimare con errore minore di e-10

% H^2 !<! ((e-10)*12)/((xb-xa)*maxAbsDerSec)
% M = (xb-xa)/H

H10 = sqrt( ((1.e-10)*12)/((xb-xa)*maxAbsDerSec) );
M10 = ceil( (xb-xa)/H10 )