function back = fourierInv( x, t, f )

back= zeros(1, length(t));

    for i=1:length(t)
        esp= exp(1i*2*pi*t(i).*f);
        back(i)= riemannInt(f, f(1), f(length(f)), x.*esp);    
    end

end
