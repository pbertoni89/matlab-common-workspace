function [ tn un ] = crnk_nich( odef, tspan, y0, Nh )
% y0 va dato come vettore RIGA
% un è una matrice eqs Nh+1
	
	tn = linspace(tspan(1), tspan(2), Nh+1);
	h = tn(2)-tn(1);
	
	eqs = length(y0);
	un = zeros(eqs,Nh+1);
	un(:,1) = y0;
	
	tol  = 1.e-8;
	nmax = 50;
	B0 = eye(eqs);
	
	for n = 1:length(tn)-1

		F = @(u) u - un(:,n) - ...
			(h/2)*( odef(tn(n),un(:,n)) + odef(tn(n+1),u) );
		[un(:,n+1), ~, ~] = broyden(F, B0, un(:,n), tol, nmax);	
	end
end