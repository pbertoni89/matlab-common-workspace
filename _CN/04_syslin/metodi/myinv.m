function [ invA appr ] = myinv( A )
%MYINV Summary of this function goes here
%   Detailed explanation goes here

% l'idea è risolvere il vettore di sistemi lineari
% A inv(A) = I dove ogni sistema lineare è A xj = ej

	n = size(A);
	I = eye(n);
	[ L U P ] = lu(A);
	
	for j = 1:n
		b = I(:,j);
		
		y = L\(P*b);
		x = U\y;
		
		appry = fwdL(L,b);
		apprx = bckU(U,appry);
		
		invA(:,j) = x;
		appr(:,j) = apprx;
		% approssimata perchè SENZA PIVOTAZIONE!
	end
end

