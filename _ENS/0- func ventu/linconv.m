function [cn,cs] = conv_custom(xn,xs,yn,ys)
%CONV_CUSTOM Convoluzione del corso di elab numerica
%
%[cn,cs]=conv_custom(xn,xs,yn,ys)
% calcola la convoluzione partendo dai segnali xs e ys
% e dalla rispettiva base dei tempi.
% xs e ys sono vettori riga
% xn e yn sono vettori riga di interi crescenti consecutivi
% di lunghezza pari a quella del segnale corrispondente

Nbx=xn(1);
Nex=xn(size(xn,2));
Nby=yn(1);
Ney=yn(size(yn,2));
for n=(Nbx+Nby):(Nex+Ney)
   i=n-(Nbx+Nby)+1;                     %indicizzazione per l'asse n (+1 per i vettori MATLAB)
   cs(i)=0;
   for m=max(Nbx,n-Ney):min(Nex,n-Nby)
      j=m-Nbx+1;                        %indicizzazione per l'asse m (+1)  
      cs(i)=cs(i)+xs(j)*ys(i-j+1);      %no i-j, ma i-j+1 ((+1-1)+1)
   end;
   cn(i)=n;
end;