clc; clear; close all;

n=100;
A=diag(1:n); A(1,:)=ones(1,n); A(:,1)=ones(n,1);

figure('name','A matrix'); clf;
subplot(1,2,1); spy(A); % nz in figure means #nonzero elements
title('full');

% >>whos mostra quanti elementi nulli sono stati memorizzati.
% come evitare questo? usando sparse diags.
Aspd = spdiags( (1:n)', 0 ,n , n );
Aspd(1,:) = ones(1,n);
Aspd(:,1) = ones(n,1);

subplot(1,2,2); spy(Aspd); title('sparse');

whos
% in sparse diags vengono usate delle variabili particolari.
% (pat) attenzione: non c'è scritto DA NESSUNA PARTE che la memoria
% allocata per ogni matrice debba essere contigua; non c'entra niente,
% niente con questo discorso. anche se è dinamica, è TUTTA allocata.

%% LU
[Llu Ulu Plu] = lu(Aspd);
figure('name','LU from Matlab'); clf;
subplot(1,2,1); spy(Llu);
subplot(1,2,2); spy(Ulu);
% si osserva la pivotazione su una riga; sarà spiegata

%% MY
[Lmy Umy ] = factLU(Aspd);
figure('name','LU from myself'); clf;
subplot(1,2,1); spy(Lmy);
subplot(1,2,2); spy(Umy);