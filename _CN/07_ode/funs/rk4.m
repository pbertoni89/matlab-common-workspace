function [ tn un ] = rk4( odef, tspan, y0, Nh )
% y0 va dato come vettore RIGA
% un è una matrice eqs Nh+1

	tn = linspace(tspan(1), tspan(2), Nh+1);
	h = tn(2)-tn(1);
	
	eqs = length(y0);
	un = zeros(eqs,Nh+1);
	un(:,1) = y0;
	
	for n = 1:length(tn)-1
		tmid = .5*(tn(n)+tn(n+1));
		
		K1 = odef(tn(n),   un(:,n));
		K2 = odef(tmid,    un(:,n) + (h/2)*K1);
		K3 = odef(tmid,    un(:,n) + (h/2)*K2);
		K4 = odef(tn(n+1), un(:,n) + (h)  *K3);
		
		un(:,n+1) = un(:,n) + (h/6)*(K1 + 2*K2 + 2*K3 + K4);
	end
end