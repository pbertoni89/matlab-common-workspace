function [a] = succ_integrale(N)
%SUCC_INTEGRALE Summary of this function goes here
%   Detailed explanation goes here
	a = zeros(N+1,1);
	a(1) = log(6/5);
	
	for n=1:N
		a(n+1) = 1/n - 5*a(n);
	end
	
	nn=(0:N)';
	
	figure(4); clf;
	plot(nn, a, '*');

end

