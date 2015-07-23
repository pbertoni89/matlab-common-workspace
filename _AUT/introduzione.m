
which introduzione;

clear;
close all;

A= [ 1 0 ; -2 -1];

b= [ 1 ; 2 ];

c= [ 1 0 ];

d= 0;

x0= [ 1 0];

S= ss(A, b, c, d);

g= ft(S);





pause;
return;