clc; clear all; close all;

b = [2 0 6 6]';

U = [1 1 3 0; 0 1 2 -1; 0 0 4 1; 0 0 0 3];
x1 = bckU(U,b)
% x1lu = U\b OK

L = [ 1 0 0 0; 2 3 0 0; -1 1 2 0; 2 -1 5 3];
x2 = fwdL(L,b)
% x2lu = L\b OK

%%
clear all; format short; clc;
A = [10 4 3 -2; 20 2 20 -1; 3 -6 4 3; -3 0 3 1];
b = [5 24 13 -2]';

[Lmy Umy] = factLU(A)
[Llu Ulu Plu] = lu(A) % L = inv(Plu)*Llu
%Ltril = tril(A,-1)
%Utriu = triu(A,0) non c'entrano un cazzo....

ymy = fwdL(Lmy,b);
xmy = bckU(Umy,ymy)

ylu = Llu\(Plu*b);
xlu = Ulu\ylu