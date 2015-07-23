function x = chebyspace(xa, xb, n)
%CHEBYSPACE Creates n Chebychev nodes inside range (xa,xb)
	x = (xb+xa)/2 + ((xb-xa)/2)*(-cos([0:n]*pi/n));
end

