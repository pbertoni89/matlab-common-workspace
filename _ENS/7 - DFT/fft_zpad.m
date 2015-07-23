function Xp = fft_zpad( X, N )
%FFT_ZPAD Handles DFT zero padding.
%   length(X) should be an even number

    l = length(X);
    e = l/2 + 1;
    
    Xp = zeros( 1, l + N );

    Xp(1:e-1) = X(1:e-1);
    
    %e
    %X(e)
    
    if X(e) == 0
               
        %fprintf('Xp(%d:%d) = X(%d:%d)\n', e+N+1, l+N, e+1, l);
        Xp((e+N+1):(l+N)) = X((e+1):l);
        
    else
       
       Xp(e)   = X(e);
       Xp(e+N) = X(e);
       %fprintf('Xp(%d:%d) = X(%d:%d)\n', e+N+1, l+N, e+1, l);
       Xp((e+N+1):(l+N)) = X((e+1):l);
        
    end

end

