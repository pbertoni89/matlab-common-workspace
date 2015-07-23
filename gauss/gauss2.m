function z = gauss2( x,y,Mu,C)
%MYGAUSS Summary of this function goes here
%   x e y assi
%   Mu vettore di 2 medie
%   Cx matrice 2x2 di covarianza

isSdp = chol(C) % prints out error on sdp

%z1 = exp(-( (x-Mu(1))'*inv(Cx)*(x-Mu(1))))/((2*pi)^3*sqrt(det(Cx)));
z = exp( -( C(1,1)*(x-Mu(1)).^2 + ...
            2*C(1,2)*(x-Mu(1)).*(y-Mu(2)) + ...
            C(2,2)*(y-Mu(2)).^2)            ) ;
      
end

