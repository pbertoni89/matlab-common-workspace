% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 5a - Variabili Casuali con Lena


clear all; close all; clc;

% usato per scurire la gamma.
beta =  .3;              % -1 < beta < 0   scurisce l'immagine
                         % 0 < beta < +1   schiarisce l'immagine
LENA= imread('lena','tif');
[ r c ] = size(LENA);
                    

%%  Average Gaussian Noise

    MAXnoise = 80;
    MEDnoise = (255/2); % grigio medio
    
    AGNoise = ( randn( r, c ) * MAXnoise ) + 40 ;

    medUnoise = mean(mean(AGNoise));
    varUnoise = var(var(AGNoise));

     AGspecter = dft_N_2d(AGNoise,r);
    %AGspecter = fft2(AGNoise);

    AGmodule = abs(AGspecter)  ;
    AGphase  = angle(AGspecter) ;                
               
    
%% LENA
    Nfactor = 1*c;   % se N>length(x) => padding zeros in dft => interpolazione
    
    LENAspecter = dft_N_2d(single(LENA),Nfactor);
    LENA2 = fft2(single(LENA));
    LENAmodule  = zeros(r,c);
    LENAphase   = zeros(r,c);
    LENAunwrap  = zeros(r,c);
    
    for i = 1 : r
 
        LENAmodule(i,:)  = handle_fft( abs(LENAspecter(i,:)) )  ;
        LENAmodule(i,:)  = handle_fft( abs(LENAspecter(i,:)) )  ;
        LENAphase(i,:)  = handle_fft( angle(LENAspecter(i,:)) )  ;
        LENAp2(i,:)   = handle_fft( angle(LENA2(i,:)) )  ;
        LENAunwrap(i,:)  =  unwrap(LENAphase(i,:))  ;
        
    end
    
    
%% sfasa lineare   

    LENArephased = zeros(r,c);
    LENAretarded = zeros(r,c);
    
    tau = 0;
    n = 0:Nfactor-1;
    %SFAS =  -1i * 2 *pi * (tau / c) * n ;           % c fa la parte dell' N nella teoria.
    SFAS =   2 *pi * (tau / c) * n ;           % c fa la parte dell' N nella teoria.
    
    for i = 1 : r
        
        LENArephased(i,:) = LENAphase(i,:) - SFAS;  % leggi dell'esponenziale
        LENAretarded(i,:) = ifft( LENAmodule(i,:) .* exp( 1i * LENArephased(i,:) ) , Nfactor);
        
    end
    
    
%% electromagnetic storm!!!

    LENAdirty = single(LENA) + AGNoise;
    LENAdirty = uint8(LENAdirty);

    LENAdirty_specter = dft_N_2d(single(LENAdirty),r); 
    LENAdirty_module = zeros(r,c);
    LENAdirty_phase = zeros(r,c); 
    LENAdirty_unwrap = zeros(r,c);
    
    for i = 1 : r
        
        LENAdirty_module(i,:) =  handle_fft( abs(LENAdirty_specter(i,:))   );
        LENAdirty_phase(i,:)  =  handle_fft( angle(LENAdirty_specter(i,:)) );
        LENAdirty_unwrap(i,:) =  handle_fft( unwrap(LENAdirty_phase(i,:))  );

    end
 
    
%% OUTPUT    

% per AGNoise e LENAdirty, i valori oltre il range [0..255] vengono
% automaticamente clippati sia da imhist che da imshow.
    figure(1); 
    subplot(1,3,1);    imhist(uint8(AGNoise));
    subplot(1,3,2);    imhist(LENA);
    subplot(1,3,3);    imhist(LENAdirty);

    figure('name','ORIGINALE'); imshow(LENA);
    %figure('name','SPETTRO DI AMPIEZZA'); imshow(LENAmodule);
    figure('name','SPETTRO DI FASE'); imshow(LENAphase);    
    figure('name','SPETTRO DI FASE 2'); imshow(LENAp2); 
    figure('name','SPETTRO DI FASE UNWRAP'); imshow(LENAunwrap);               
    figure('name','SPETTRO DI FASE RIFASATO'); imshow(LENArephased);
    figure('name','RITARDATA DA SFASAMENTO'); imshow(LENAretarded);
    
    %figure('name','NOISE ORIGINALE'); imshow(AGNoise);
    %figure('name','NOISE SPETTRO DI AMPIEZZA'); imshow(AGmodule);
    %figure('name','NOISE SPETTRO DI FASE'); imshow(AGphase);             
    
   
    figure('name','TRASMESSA'); imshow(LENAdirty);
    %figure('name','TRASMESSA SPETTRO DI AMPIEZZA'); imshow(LENAdirty_module);
    figure('name','TRASMESSA SPETTRO DI FASE'); imshow(LENAdirty_phase);   
    figure('name','TRASMESSA SPETTRO DI FASE UNWRAP'); imshow(LENAdirty_unwrap); 
    
    %  Conclusioni: deduco che LA FASE HA L'INFORMAZIONE, il modulo è quasi
    %  invariante.
    
%     figure('name','SURFACE');
%     [x,y]= meshgrid(0:r-1,0:c-1);
%     colormap(jet);
%     surf(x,y, double(LENA));
%     hold on;
    %shading interp;
    
    
    
return;