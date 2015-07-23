function [ flag ] = is_dds( A )
%IS_DDS Tests if A is whether or not "strict diagonal dominance"
	% Returns 1 if it is; 0 else.
	
	flag = 1;
	[r c] = size(A);
	
	i = 1;
	while i<=r && flag==1
		d = abs(A(i,i));
		j = 1;
		while j<=c && flag==1
			if j~=i
				if abs(A(i,j)) >= d
					flag=0;
				end
			end
			j=j+1;
		end
		i=i+1;
	end
end

