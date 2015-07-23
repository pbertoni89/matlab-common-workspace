function [ norm ] = normaL2tipo2( x, t )

    nullvect= zeros( 1, length(t) );
    norm= distanzaL2tipo1(x, nullvect, t);
    
return;

