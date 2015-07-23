function [ tn un ] = eul_expl( odef, tspan, y0, Nh )
% y0 va dato come vettore RIGA, un è una matrice eqs x Nh+1

	tn = linspace(tspan(1), tspan(2), Nh+1);
 	h = tn(2)-tn(1); %  = (tspan(2)-tspan(1))/Nh

	eqs = length(y0);									
	un = zeros(eqs,Nh+1);
	un(:,1) = y0; 

	for n = 1:length(tn)-1
		un(:,n+1) = un(:,n) + h*odef(tn(n),un(:,n)); 
	end
end