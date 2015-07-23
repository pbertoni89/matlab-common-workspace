clear all; close all; clc; format long e;

%% Dati
A = [ 1 1+.5e-15 3; 2 2 20; 3 6 4];
b = [ 5+.5e-15 24 13]';
xok = ones(3,1); % la vera soluzione

%% My
[ Lmy Umy ] = factLU(A);
xmy = Umy\(Lmy\b)
errmy = norm(xmy-xok)/norm(xok)
%xmys = bckU(Umy,fwdL(Lmy,b))  % OK
fprintf('il moltiplicatore che fa esplodere tutto è %d\n',Lmy(3,2));

%% Lu + Pivoting
[ Llu Ulu Plu ] = lu(A);
xlu = Ulu\(Llu\(Plu*b))
errlu = norm(xlu-xok)/norm(xok)
%xlus = bckU(Ulu,fwdL(Llu,Plu*b))
fprintf('al suo posto invece ora abbiamo %d\n',Llu(3,2));

%% Default (utilizza Lu+Pivoting)
% xde = A\b
% errde = norm(xde-xok)/norm(xok)

%% Plots
% figure('name','LU from Matlab'); clf;
% subplot(1,2,1); spy(Llu);
% subplot(1,2,2); spy(Ulu);
% 
% figure('name','LU from Myself'); clf;
% subplot(1,2,1); spy(Lmy);
% subplot(1,2,2); spy(Umy);

%format;