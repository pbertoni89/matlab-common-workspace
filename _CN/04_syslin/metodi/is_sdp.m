function [ flag ] = is_sdp( A )
%IS_SDP Tests if A is whether or not "symmetric semidef positive"
	% Returns 1 if it is; 0 else.
	
	flag = 1;
	[r ~] = size(A); % no checks sul quadrato
	e = eig(A);
	
	if isequal(A,A')==0
		flag=0;
	end
	
	i = 1;
	while i<=r && flag==1
		if e(i) < 0
			flag=0;
		end
		i=i+1;
	end
end

