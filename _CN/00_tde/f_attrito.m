function Fa = f_attrito( t, dy, mode )
%F_ATTRITO Summary of this function goes here
%   Detailed explanation goes here
gam = 2;
c = 5;

if mode == 1
	if dy > 0
		Fa = -gam;
	elseif dy < 0 
		Fa = gam;
	else
		Fa = 0;
	end
elseif mode == 2
	if dy > 0
		Fa = -gam-c*dy;
	elseif dy < 0 
		Fa = gam-c*dy;
	else
		Fa = 0;
	end
end

end

