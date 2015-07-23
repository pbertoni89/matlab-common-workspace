function [ tn un ] = eul_impl( odef, tspan, y0, Nh )
% y0 va dato come vettore RIGA
% un è una matrice eqs Nh+1
	
	tn = linspace(tspan(1), tspan(2), Nh+1);
	h = tn(2)-tn(1);
	
	eqs = length(y0);
	un = zeros(eqs,Nh+1);
	un(:,1) = y0;
	
	tol  = 1.e-8;
	nmax = 30;
	B0 = eye(eqs);
	
	for n = 1:length(tn)-1
		
		F = @(u) u - un(:,n) - h*odef(tn(n+1),u);	
		% u è logicamente un(n+1)
		[un(:,n+1), ~, ~] = broyden(F, B0, un(:,n), tol, nmax);
		% broyden secanti per sistemi non lineari
	end
end