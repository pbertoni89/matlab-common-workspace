function [ Iappr ] = i_c_trap( f, xa, xb, M )
%I_C_PM Summary of this function goes here
%   Detailed explanation goes here

H = (xb-xa)/(M);
xk = xa+H*[0:M];

Iappr = 0;

 % ora considero solo gli interni!! xa=0 e xb=xM li sommo dopo
for k = 2:M
	Iappr = Iappr + f(xk(k));
end

Iappr = H*Iappr + (H/2)*(f(xk(1))+f(xk(end)));

end
