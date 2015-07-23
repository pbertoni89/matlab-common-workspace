function [ tn un ] = custom_multi(odef, tspan, y0, Nh, order)
%CUSTOM_MULTI Si veda eqdiff4.pdf per il testo
%	si veda l_multi_te200706 per le risposte

	tn = linspace(tspan(1), tspan(2), Nh+1);
	h = tn(2)-tn(1);
	
	eqs = length(y0);									
	un = zeros(eqs,Nh+1);
	
		un(:,1) = y0; % dato
		% un(:,2) è la sol di un'ODE. offro due schemi per averla
		if order == 4
			[~, u1] = rk4(odef,[0 h], y0, 1);
		else
		if order == 2
			[~, u1] = eul_expl(odef,[0 h], y0, 1);
		end 
		end
		un(:,2) = u1(:,2); % u1(:,1) = y0
	
	for n = 2:length(tn)-1
		un(:,n+1) = (1/3)*un(:,n) + (2/3)*un(:,n-1) + ...
					 (h/6)*( 11*odef(tn(n),un(:,n)) - ...
					            odef(tn(n-1),un(:,n-1))); 
	end

end