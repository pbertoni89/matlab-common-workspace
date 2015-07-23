function Xs = handle_fft( X )
% Swaps the two subsequences of the DFT array, resulting something similar
% to DTFT ( negative frequencies on the left side )
%   v[i], 0<i<N/2    are positive frequencies;
%   v[i], N/2<i<N-1  are negative frequencies.
% If N is an odd number, the function pads dft with one zero  


N = length(X);

if mod(N,2)==1
    X = [ X 0 ];
end

Xs = [ X( (N/2)+1 : N ) X( 1 : N/2) ]; 

%Xs(1) = X(1);
% for i = 2 : N
%    fprintf('Xs(%d)=X(%d)  ( %f )\n', i, N-i+2, X(N-i+2) );
%     Xs(i) = X(N-i+1);
%     
% end


end

