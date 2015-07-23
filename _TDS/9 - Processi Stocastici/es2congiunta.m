
which es2;

clear all; close all;

dim= 10000;

Ux = rand( 1, dim );  % anche se X è spalmata tra [0,2] NON MOLTIPLICO QUI!!
Uy = rand( 1, dim );

X=    2   * (Ux.^(1/4)) ;
Y= (X/2) .* (Uy.^(1/2)) ;

myHist1D(X); title('pdf di X')
myHist1D(Y); title('pdf di Y')

myHist2D(X,Y); title('pdf di XY')

return;