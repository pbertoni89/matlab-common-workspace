function  z = ccirc_ind_N( x, y, N )
%CONV_CIRC_INDIRETTA Computes circular convolution by passing in the DFT domain.
%   Given two sequences x, y ( the possible gap between lengths will be padded)
%   Given N samples of DFT transforming (it is also the convolution parameter.)
%     if N is passed 0, it will be set up to convolution lenght ( 2*L -1 )

    lX = length(x);
    lY = length(y);
    
    if lX > lY
       y = [ y zeros(1,lX-lY) ];
    elseif lX < lY
       x = [ x zeros(1,lY-lX) ]; 
    end

    if N==0
       N =  lX*2 -1;
    end
    %lX = length(x);
    %lY = length(y);
    
    X =  dft_N( x, N );
    Y =  dft_N( y, N );
    
    Z = X .* Y;
    
    z = idft_N( Z, N );

end

