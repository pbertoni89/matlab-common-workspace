function [x, niter, ERR, specrad] = gsjac( A, b, x0, tol, nmax, flag )
%MYGS Summary of this function goes here
%   Detailed explanation goes here

	n = size(A);
	I = eye(n);
	D = diag(diag(A));
	niter = 0;
	err = 1;
	ERR = [];
	x = x0;

	if strcmp(flag,'J')
		B = I - D\A;
		g = D\b;
	else
		%E = -tril(A,-1); %tmp = D-E; %B = I - tmp\A; % g = tmp\b;
		tr = tril(A);
		B = I-tr\A;
		g = tr\b;
	end
	
	specrad = max(abs(eig(B)));

	while niter<nmax && err>tol
		xnew = B*x + g;
		err = norm(xnew-x);
		ERR = [ERR err];
		x = xnew;
		niter = niter+1;
	end
end

