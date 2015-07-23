function [ prod ] = prodscalare_tipo1( x, y, t)

    prod= riemannInt(t, t(1), t(length(t)), x .* conj(y) ); 

return;

