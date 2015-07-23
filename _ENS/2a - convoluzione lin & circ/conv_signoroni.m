function [w, n_w] = conv_signoroni(n_x, x, n_y, y)
%CONV_CUSTOM Convoluzione del corso di elab numerica
%
%[cn,cs]=conv_custom(xn,xs,yn,ys)
% calcola la convoluzione partendo dai segnali xs e ys
% e dalla rispettiva base dei tempi.
% xs e ys sono vettori riga
% xn e yn sono vettori riga di interi crescenti consecutivi
% di lunghezza pari a quella del segnale corrispondente

n_x_b = n_x(1);
n_x_e = n_x(size(n_y,2));

n_y_b = n_y(1);
n_y_e = n_y(size(n_y,2));

for n =( n_x_b + n_y_b ):( n_x_e + n_y_e )
   
   i = n - ( n_x_b + n_y_b ) + 1;                     %indicizzazione per l'asse n (+1 per i vettori MATLAB)
   w(i)=0;
   
   for m = max( n_x_b, n - n_y_e ): min( n_x_e, n - n_y_b )
      j = m - n_x_b + 1;                    %indicizzazione per l'asse m (+1)  
      w(i) = w(i) + x(j) * y(i-j+1);        %no i-j, ma i-j+1 ((+1-1)+1)
   end;
   
   n_w(i) = n;

end;