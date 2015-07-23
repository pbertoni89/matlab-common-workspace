function [ zero, res, niter, ERR ] = my_newton( f, f1, x0, tol, nmax )

	err = 1;
	niter = 0;
	x = x0;
	ERR=[];
	
	while niter<nmax && err>tol
		xnew = x - f(x)/f1(x);
		err = abs(xnew-x);
		ERR=[ERR; err];
		niter = niter+1;
		x = xnew;
	end
	
	zero = xnew;
	res = f(zero);

end

