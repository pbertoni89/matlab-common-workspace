function k = attrito220604( t, tp )
%F_ATTRITO Summary of this function goes here
%   Detailed explanation goes here
k1 = 180/11; k2 = 180;

	if t > tp
		k = k2;
	else
		k = k1;
	end
end