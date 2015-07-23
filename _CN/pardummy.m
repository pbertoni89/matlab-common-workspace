function [ nn ] = pardummy( A, p )
%PARDUMMY Counts not-null elements in a matrix A,
	% in a PARALLEL WAY if p is flagged on.
	nn = 0;
	[r c] = size(A);
	
	if p == 1
		parfor i=1:r
			i
			riga = A(i,:);
			for j=1:c
				if riga(j)~=0
					nn = nn+1;
				end
			end
		end
	else
		for i=1:r
			i
			riga = A(i,:);
			for j=1:c
				if riga(j)~=0
					nn = nn+1;
				end
			end
		end
	end
end

