function Xs = swap_dft( X )

N = length(X);

if mod(N,2) == 1
    X = [ X 0 ];  % padding
end

Xs = [ X( (N/2)+1 : N ) X( 1 : N/2) ]; 

end

