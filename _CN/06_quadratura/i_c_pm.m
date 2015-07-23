function [ Iappr ] = i_c_pm( f, xa, xb, M )
%I_C_PM Summary of this function goes here
%   Detailed explanation goes here

H = (xb-xa)/(M);
xk = xa+H*[0:M]; % ho incluso 0 e M per gli estremi!

Iappr = 0;

for k = 1:M
	xavg= (xk(k+1)+xk(k))/2;
	Iappr = Iappr + f(xavg);
end

Iappr = H*Iappr;

end

