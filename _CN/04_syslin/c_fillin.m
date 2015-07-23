clc; clear all; close all;

n = 20;
b = ones(n,1);

%a(i , i ) = 2 per i = 1, ..., n
%a(i , i - 4) = 1 per i = 5, ..., n
%a(i , i + 10) = 1 per i = 1, ..., 10
%a(1, j ) = 1 per j = 1, ..., 15
%a(i , 1) = 1 per i = 1, ..., 10

A = spdiags( [ b 2*b b ], [ -4 0 10 ], n, n);

A(1, 1:15) = ones(15,1);
A(1:10, 1) = ones(10,1);

figure('name','A matrix');
spy(A);

[ Lmy Umy ] = factLU(A);
[ Llu Ulu ] = lu(A);

figure('name','LU from Matlab'); clf;
subplot(1,2,1); spy(Llu);
subplot(1,2,2); spy(Ulu);

figure('name','LU from myself'); clf;
subplot(1,2,1); spy(Lmy);
subplot(1,2,2); spy(Umy);
