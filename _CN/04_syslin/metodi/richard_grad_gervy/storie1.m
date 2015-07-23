%
% Confronto tra metodo del gradiente e del gradiente coniugato.
% Richiama le functions: grad1.m e conjgra1.m
%
%
clear;
close all

A=[10,6;6,6];b=[11;2];
x=[-40;50];nmax=100;toll=1.e-10;
%
% metodo del gradiente
%
clf
zoom on
fprintf('Risolvo il sistema lineare Ax=b con \n')
A
b
fprintf('le isolinee della forma quadratica (paraboloide) associata \n')
fprintf('al sistema Ax=b sono rappresentate in figura 2\n')
[xG,itG,ErrG]=grad1(x,A,b,nmax,toll);
%
% gradiente coniugato
%
x=[-40;50];
[xCG,itCG,ErrCG]=conjgra1(x,A,b,nmax,toll);
figNumber=figure( ...
        'Name','Storie di convergenza',...
        'Visible','on');

semilogy((1:itG+1)',ErrG,'m');
hold on
h2=semilogy((1:itCG+1)',ErrCG);
set(h2,'Color',[0.06,0.68,1.])
h1=semilogy((1:itG+1)',ErrG,'m.');
set(h1,'MarkerSize',10);
h2=semilogy((1:itCG+1)',ErrCG,'*');
set(h2,'Color',[0.06,0.68,1.])
title('Storie di convergenza di Grad e GC')

xlabel('k'); ylabel('||r_k||/||b||')
grid on
legend('Gradiente','Gradiente coniugato')
