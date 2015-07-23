
function [ q, c ] = long_div(b,a,K)
 %
 %   Polynomial division by convolution.
 %
 %   Calcola la divisione polinomiale fino a K termini
 %          q(z) = b(z)/a(z),
 %   dove
 %          b(z) = b(0) + ... + b(k)/z^k + ... + b(n)/z^n. 
 %          a(z) = a(0) + ... + a(k)/z^k + ... + a(m)/z^m. 
 %          q(z) = q(0) + ... + q(k)/z^k + ... + q(K)/z^K + ...... 
 %

  n = length(b);    % numero di zeri
  m = length(a);   % numero di poli
  
  b = [ b, zeros( 1, K-1-n+m )]; % verificare che non si sovrapponga al MIO padding
   
  % diviso per un reale
  if m == 1 
    q = b/a;   
    c = a;    
  else     
      w(1) = 1; 
      c = 1;  

      for k = 2 : K+1
          w(k) = [  b(k-1),  -a( min(k-1,m) :-1: 2) ] * [ w(1), w(max(2,k+1-m) : k-1) ]' / a(1);
      end

      q = w(2:K+1);
  end
  