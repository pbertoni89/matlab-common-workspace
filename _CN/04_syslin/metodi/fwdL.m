function [ x ] = fwdL( L, b )
%TRIINF Data una matrice triangolare inferiore L,
	% un vettore b, restituisce un vettore x tale che
	% Lx = b

	n = length(b);
	x = zeros(n,1);
	
	% scritto implicitamente il prodotto scalare tra due vettori.
	for i = 1:n
		x(i) = (b(i) - L(i,1:i-1)*x(1:i-1) )/L(i,i);		
	end
end