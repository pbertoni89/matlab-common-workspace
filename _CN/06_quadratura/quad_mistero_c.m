function [ Iappr ] = quad2_mistero_c( f, xa, xb, n )
%I_C_PM Summary of this function goes here
%   Detailed explanation goes here

H = (xb-xa)/(n);
x = xa+H*(0:n);

Iappr = 0;

for k = 1:n
	pt1 = ( 2*x(k) +1*x(k+1))/3;
	pt2 = ( 1*x(k) +2*x(k+1))/3;
	Ik  = ( f(x(k)) + 3*f(pt1) + 3*f(pt2) + f(x(k+1)));
	Iappr = Iappr + ((x(k+1)-x(k))/8)*Ik;
end
end