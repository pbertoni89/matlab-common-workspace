function [ x ] = bckU( U, b )
%TRISUP Data una matrice triangolare superiore U,
	% un vettore b, restituisce un vettore x tale che
	% Ux = b

	n = length(b);
	x = zeros(n,1);
	
	% scritto implicitamente il prodotto scalare tra due vettori.
	for i = n:-1:1
		x(i) = (b(i) - U(i,i+1:n)*x(i+1:n) )/U(i,i);		
	end
end