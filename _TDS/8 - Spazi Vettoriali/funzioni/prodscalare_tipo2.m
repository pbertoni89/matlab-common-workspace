function [ prod ] = prodscalare_tipo2( x, y, t)

   prod= normaL2tipo1(x,t) * normaL2tipo1(y,t)* cos( angle(x.*y) );

return;

