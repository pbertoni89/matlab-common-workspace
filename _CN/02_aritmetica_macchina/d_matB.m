clear all; close all; clc;
load matriceB;
spy(B)

%% quando visualizza 0.0000 NON SONO veramente degli 0 puliti!!!
format long e;
sizeB = size(B)
eigB = eig(B);
N = size(eigB,1);
stem(1:N,eigB); title('eigB');

rankB = rank(B)
detB = det(B)
disp('questo è un controsenso!');

% det = produttoria autovalori. essendo essi tutti diversi da zero,
%       ci aspettiamo chiaramente che esso sia diverso da zero!!!!!
%   INVECE NO. dov'è l'errore?
%
%       check rank. essendo pieno,
%

prodott = eigB(1);
vv = zeros(N,1);
vv(1) = prodott;

for i=2:N % potevo usare prod(X) pure qua?
	vv(i) = prodott * eigB(i);
end

figure
plot((1:N), vv); title('produttoria eigB: underflow');

% cos'è successo?? sotto e-320 vedo tutto 0 pieno... UNDERFLOW.

% ora che faccio? vediamo mantisse ed esponenti degli eigs.
[pm, pe] = log2(eigB);  % tale che pm.2^(pe) = log2(eigB)
parte_dec = prod(pm) % 2.601983048668451e-016
esponente = sum(pe) %= -1277, per il quale andiamo in underflow.
disp('ordine in underflow.');

