function s = c_sommatoria( n )
%C_SOMMATORIA Summary of this function goes here
%   Detailed explanation goes here

s=0;
% se n=0 il ciclo non viene eseguito; mi sincero dagli errori di inputs
for i = n:-1:1
	s = s + i/n;
end

end

