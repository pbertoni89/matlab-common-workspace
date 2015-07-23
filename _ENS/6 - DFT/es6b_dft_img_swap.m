% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 5a - Variabili Casuali con Lena


clear all; close all; clc;

H= imread('house','tiff');
[ rH cH ] = size(H);
C= imread('clock','tiff');
[ rC cC ] = size(C);

if rH~=rC || cH~=cC
    fprintf('Immagini di dimensioni diverse\n');
    return;
else
    r = rH;
    c = cH;
end
%%

Hspecter = zeros(r,c);
for i = 1 : r
    Hspecter(i,:) = fft(H(i,:),c);
end

%Hspecter2 = fft2(H);       % la mia sembra più aggraziata, perlomeno con la fase

Hmodule = abs(Hspecter) / sqrt(c);
Hphase = angle(Hspecter);

%Hmodule2 = abs(Hspecter2) / sqrt(c);
%Hphase2 = angle(Hspecter2);

%%

Cspecter = zeros(r,c);
for i = 1 : r
    Cspecter(i,:) = fft(C(i,:),c);
end

Cmodule = abs(Cspecter) / sqrt(c);
Cphase = angle(Cspecter);

%% ORIGINAL SPECTERS

figure(1); 
    subplot(1,2,1);    imhist(H); title('HOUSE');
    subplot(1,2,2);    imhist(C); title('C');

    figure('name','HOUSE'); imshow(H);
    figure('name','HOUSE MODULE'); imshow(Hmodule);
    figure('name','HOUSE PHASE'); imshow(Hphase);
    %figure('name','HOUSE MODULE2'); imshow(Hmodule2);
    %figure('name','HOUSE PHASE2'); imshow(Hphase2);
    
    figure('name','CLOCK'); imshow(C);
    figure('name','CLOCK MODULE'); imshow(Cmodule);
    figure('name','CLOCK PHASE'); imshow(Cphase);

%% SWAPPING MODULES

Hdummy = Cmodule .* exp( 1i * Hphase);
Cdummy = Hmodule .* exp( 1i * Cphase);

Hanti = zeros(r,c);
Canti = Hanti;

 for i = 1 : r
     Hanti(i,:) = ifft(Hdummy(i,:),c);
 end

 for i = 1 : r
     Canti(i,:) = ifft(Cdummy(i,:),c);
 end

 figure('name','HOUSE WITH CLOCK MODULE'); imshow(Hanti);
 figure('name','CLOCK WITH HOUSE MODULE'); imshow(Canti);
 
 %% SWAPPING PHASES  (ma è la stessa cosa!!!)

% Hdummy = Hmodule .* exp( 1i * Cphase);
% Cdummy = Cmodule .* exp( 1i * Hphase);
% 
%  for i = 1 : r
%      Hanti(i,:) = ifft(Hdummy(i,:),c);
%  end
% 
%  for i = 1 : r
%      Canti(i,:) = ifft(Cdummy(i,:),c);
%  end
% 
%  figure('name','HOUSE WITH CLOCK PHASE'); imshow(Hanti);
%  figure('name','CLOCK WITH HOUSE PHASE'); imshow(Canti);
    
return;