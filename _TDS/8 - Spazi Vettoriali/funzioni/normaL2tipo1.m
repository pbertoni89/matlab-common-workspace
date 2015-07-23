function [ norm ] = normaL2tipo1( x, t )

    norm= sqrt( riemannInt( t, t(1), t(length(t)), (abs(x)).^2 ) );

return;

