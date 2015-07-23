function [ L U ] = factLU( A )
%FACTLU Summary of this function goes here
%   Detailed explanation goes here

n = size(A);

	for k = 1:n-1
		for i = k+1:n
			A(i,k) = A(i,k)/A(k,k);
			A(i,k+1:n) = A(i,k+1:n) - A(i,k).*A(k,k+1:n);
		end
	end

L = tril(A, -1) + eye(n);
% perchè abbiamo sommato identità?? perchè per ottimizzare l'algoritmo
% non l'abbiamo considerato, tanto è una diagonale di soli uni.
U = triu(A);

%% Riflessioni
% le nostre funzioni sono competitive con lu() per dimensioni
% piccole. Lavorando con n grandi, perderanno molto terreno.
end

