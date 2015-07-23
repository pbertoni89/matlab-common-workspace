function [ zero, resid, niter, ERR ] = newtonsys( F, JF, x0, tol, nmax )

	err = 1;
	niter = 0;
	x = x0;
	ERR=[];
	
	while niter<nmax && err>tol
	 A = JF(x);
	 b = -F(x)';
	 z = A\b;
	 err = norm(z);
	 x = x + z;
	 ERR=[ERR; err];
	 niter = niter+1;
	end
	
	zero = x;
	resid = norm(F(zero));

end

