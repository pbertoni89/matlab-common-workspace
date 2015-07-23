function back = fourierTrasf( x, t, f )

back= zeros(1, length(f));

    for i=1:length(f)
        esp= exp(-1i*2*pi*f(i).*t);
        back(i)= riemannInt(t, t(1), t(length(t)), x.*esp);    
    end

end

