function w = my_conv_core( x, y )

    Nx = length(x);  % they are pre-filtered
    Ny = length(y);  % they are pre-filtered
    
    %% CONVOLUTION ALGORITHM WITH TOEPLITZ MATRIX
    
    c = [ y zeros( 1, Nx-1 ) ];

    r = [ y(1) zeros( 1, Ny-1 ) ];

    T = toeplitz(c,r);
       
    X = x;
    
    w = T * X';
    
    w = w';
    
end

