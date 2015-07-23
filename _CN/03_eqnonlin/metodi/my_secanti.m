function [zero, res, niter, ERR] = my_secanti( f, x0, x1, tol, nmax )
%SECANTI TODO
%   Essendo il metodo concettualmente simile a Newton (cambia solo la
%   derivata, che viene stimata) il test d'arresto sarà il medesimo.

	err = 1;
	niter = 0;
	xold = x0;
	x = x1;
	ERR=[];
	
	while niter<nmax && err>tol
		c = ( f(x) - f(xold) ) / ( x - xold );
		xnew = x - f(x)/c;
		
		err = abs(xnew-x);
		ERR=[ERR; err];
		niter = niter+1;
	
		xold = x;
		x = xnew;
	end
	
	zero = x;
	res = f(zero);
end

