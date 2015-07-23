function X = dtft( x, n, f )
%DTFT Returns Discrete Time Fourier Transform
%   needs a sequence, its axis, axis to be returned.

    X = zeros(1,length(f));

    for i=1:length(f)
       
        for j=1:length(n)
            
            X(i) = X(i) + x(j) * exp( - 1i * 2 * pi * f(i) * n(j) );  
        end
    end

end

