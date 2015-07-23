function x = mygauss(t)
%MYGAUSS Impulso gaussiano (energia)
%   MYGAUSS(t) implementa l'impulso gaussiano di area unitaria
%
%   Opera su vettori.

x = 1/(sqrt(2*pi)) * exp(-t.^2/2);