function X = dtft( x, n, f )

    X = zeros(1,length(f));

    for i=1:length(f)
        for j=1:length(n)
            
            X(i) = X(i) + x(j) * exp( - 1i * 2 * pi * f(i) * n(j) ); 
            
        end
    end

end

