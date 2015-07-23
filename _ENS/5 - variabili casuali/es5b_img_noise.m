% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 5a - Variabili Casuali con Lena


clear all; close all; clc;

LENA= imread('lena','tif');
T = size(LENA,1); % == immagine quadrata

    MAXnoise = 80;
    MEDnoise = (255/2); % grigio medio
    
Unoise = ( randn( T, T ) * MAXnoise ) + 40 ;

    medUnoise = mean(mean(Unoise))
    varUnoise = var(var(Unoise))

beta =  .3;              % -1 < beta < 0   scurisce l'immagine
                         % 0 < beta < +1   schiarisce l'immagine
    
% electromagnetic storm!!!
    LENAdirty = double(LENA) + Unoise;
    LENAdirty = uint8(LENAdirty);

% tv filtering
    LENAcleanInt = LP_Integer_Matrix(LENAdirty, 1.3, 0);
    LENAcleanDoub = LP_Double_Matrix(LENAdirty, 1.3, 0);

% distribuire uniformemente i toni di grigio di un'immagine significa alzarne il contrasto.
    LENAequal = histeq(LENA);
    LENAdirty_equal = histeq(LENAdirty);
    LENAclean_equal = histeq(LENAcleanInt);
    LENAequal_clean = LP_Integer_Matrix(LENAequal, 1.3, 0);

    % porta l' 1% dei pixel al massimo/minimo valore, per alzare il contrasto. 
    LENAadjust = imadjust(LENA);
    
    
% più filtraggi: mooolto poco efficienti!!! deduco che  H(z).H(z) ~= H(z) ===> H(z) ~= 1 ???
    %     LENAclean2 = LP_filter_onMatrix(LENAclean, 1);
    %     LENAclean2 = LP_filter_onMatrix(LENAclean2, 1);
    %     LENAclean2 = LP_filter_onMatrix(LENAclean2, 1);
    %     LENAclean2 = LP_filter_onMatrix(LENAclean2, 1);

% per Unoise e LENAdirty, i valori oltre il range [0..255] vengono
% automaticamente clippati sia da imhist che da imshow.

figure(1); 
    subplot(1,3,1);    imhist(uint8(Unoise));
    subplot(1,3,2);    imhist(LENA);
    subplot(1,3,3);    imhist(LENAdirty);

    figure('name','ORIGINALE'); imshow(LENA);
    figure('name','ORIGINALE => EQUALIZZATA'); imshow(LENAequal);
    figure('name','ORIGINALE => AGGIUSTATA'); imshow(LENAadjust);
    
        brighten(beta);
    figure('name','ORIGINALE, SCURITA'); imshow(LENA);
        brighten(-beta);
    
    figure('name','TRASMESSA'); imshow(LENAdirty);
    figure('name','SOLO FILTRATA - convoluzione intera'); imshow(LENAcleanInt);
    figure('name','SOLO FILTRATA - convoluzione floating'); imshow(LENAcleanDoub);

        beta =  .3;              % -1 < beta < 0   scurisce l'immagine
        brighten(beta);          % 0 < beta < +1   schiarisce l'immagine
    figure('name','TRASMESSA => FILTRATA, SCURITA'); imshow(LENAcleanInt);
        brighten(-beta);    
    
    figure('name','TRASMESSA => EQUALIZZATA'); imshow(LENAdirty_equal);
    figure('name','TRASMESSA => FILTRATA => EQUALIZZATA'); imshow(LENAclean_equal);
    figure('name','TRASMESSA => EQUALIZZATA => FILTRATA'); imshow(LENAequal_clean);
    
    
    % CONCLUSIONI: la ricezione migliore avviene equalizzando E POI
    % filtrando. presumibilmente riesce a separare meglio le frequenze
    % rumorose da quelle dell'immagine, dunque il filtraggio è poi più
    % incisivo.

return;