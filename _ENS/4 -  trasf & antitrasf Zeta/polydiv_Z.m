
function [q,qc,c] = polydiv_Z(b,a,K,c)
 %
 %   Polynomial division by convolution.
 %
 %   Calculate inverse Z-transform (Polynomial division) up to K terms:
 %          q(z) = b(z)/a(z),
 %   where
 %          b(z) = b(0) + ... + b(k)/z^k + ... + b(n)/z^n. 
 %          a(z) = a(0) + ... + a(k)/z^k + ... + a(m)/z^m. 
 %          q(z) = q(0) + ... + q(k)/z^k + ... + q(K)/z^K + ...... 
 %
 %   If coefficients of b(x) and a(x) are all integers, we set  c = 0,
 %   so that the entire process involve mostly integer multiplications.
 %   The round-off errors may thus be eliminated.
 %
 %   This code is similar to the code by Tamer Abdelazim Mellik,
 %   "Calculate inverse Z-transform by long division." 
 %

  n = length(b);   % numero di zeri
  m = length(a);   % numero di poli
  
  b = [ b, zeros(1, K-1-n+m ) ]; % verificare che non si sovrapponga al MIO padding
   
  if m == 1 
    q = b/a;  
    qc = b;  
    c = a;    
    return;    
  end
    
  if c == 0 
    w(1) = a(1)^K;  
  else
    w(1) = 1; 
    c = 1;  
  end
  
  for k = 2 : K+1
      w(k) = [b(k-1),-a(min(k-1,m):-1:2)]*[w(1),w(max(2,k+1-m):k-1)]'/a(1);
  end
  
  qc = w(2:K+1);
  q = qc;
