function [ alpha niter errhist ] = ptofisso( phi, x0, tol, nmax )
%PTOFISSO Summary of this function goes here
%   Detailed explanation goes here

	err = 1;
	x = x0;
	niter = 0;
	errhist = [];
	
	while err>tol && niter<nmax
		
		err = norm(phi(x)-x);
		errhist = [errhist err];
		x = phi(x);
		niter = niter+1;
		
	end

	alpha = x;
end

