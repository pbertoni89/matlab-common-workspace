function [ dist ] = distanzaL2tipo2( x, y, t )

   %quadrato della distanza.. sotto radice
 dist= sqrt( normaL2tipo1(x,t)^2 + normaL2tipo1(y,t)^2 - 2*real( prodscalare_tipo1(x,y,t) ) );
    
return;

