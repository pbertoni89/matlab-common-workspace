function x = antidtft( X, n, f )
%DTFT Returns sequence from Discrete Time Fourier Transform
%   needs a specter, its axis, axis to be returned.
    
    x = zeros(1,length(n));
    
    for i=1:length(n)
        
        esp= exp( 1i * 2 * pi * n(i).*f );
        x(i) = riemannInt(f,-.5,.5, X.*esp );
        
    end
    
end

