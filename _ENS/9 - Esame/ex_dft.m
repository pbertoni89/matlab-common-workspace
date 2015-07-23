function [ X ] = my_dft( x, N )  

    w = exp( -1i * 2 * pi * 1 / N );

    W = tweedle( N, w);
    
    if length(x) < N
        x = [ x  zeros(1, N-length(x)) ];
    end    

    X = W * x.';
    
    X = X.';
    
end

