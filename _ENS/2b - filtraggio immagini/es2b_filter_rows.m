% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 3: prime elaborazioni di immagini
%
% algoritmo RIGA PER RIGA
%

clear; clc; close all;
i = 1;

% come effettuare una convoluzione su una matrice?? riga per riga.
%   X_10 * h = Y_10
%   X_20 * h = Y_20
%   X_30 * h = Y_30
%   X_40 * h = Y_40
%   X_50 * h = Y_50

% risposta all'impulso del filtro LOW - PASS
h = 2*[ .45 .5 .45 ];
%h = [ -1 0 1 ];
h = 1 *h;
% risposta all'impulso del filtro HIGH - PASS
%h = [ -30 0 30 ];


%% IMAGE LOADING

fprintf('Benvenuti!!! scegliere su quale immagine applicare il filtro.\n\n');
                fprintf(' 1) lena.tif\n');
                fprintf(' 2) vintage.jpg\n');
                fprintf(' 3) house.tif\n');
                fprintf(' 4) clock.tif\n');
                fprintf(' 5) generata runtime\n');

                scelta= input('');
                while( scelta<1 || scelta>4 )
                 fprintf('Valore non ammesso!\n'); 
                 scelta = input('');
                end
if scelta==1
    img = imread('lena','tif');
elseif scelta==2
    img = imread('vintage','jpg');
elseif scelta==3
    img = imread('house','tif');
elseif scelta==4
    img = imread('clock','tif');
else
    img = uint8(rand(50,50)*255);
end

figure('name','Immagine scelta'); imshow(img);

                                                                            % ANALISI SPETTRALE INEFFICACE, MI ESCONO VALORI BASSISSIMI => CAPIRE
                                                                            % specter = fft2(img);
                                                                            % mod_specter = uint8(abs(specter));
                                                                            % fas_specter = uint8(angle(specter));
                                                                            % figure('name','Modulo dello spettro'); imshow(mod_specter);
                                                                            % figure('name','Fase dello spettro'); imshow(fas_specter);



dim = size(img);

 % H ZERO PADDING

edge_img = length(h)-1;

dim_conv =  edge_img + dim(2) + edge_img; % dimensione riga da convolvere

edge_h = floor( (dim(2)-length(h))/2 );

if ( mod(dim_conv,2)==1)
    if ( mod(length(h),2)==1) 
        h_padded = [   zeros(1, edge_h + edge_img )    h    zeros(1, edge_h + edge_img )   ];         % conv dispari, h dispari
    else
        h_padded = [   zeros(1, edge_h + 1 + edge_img )    h    zeros(1, edge_h + edge_img )   ];     % conv dispari, h pari
    end 
else
    if ( mod(length(h),2)==1) 
        h_padded = [   zeros(1, edge_h + 1 + edge_img )    h    zeros(1, edge_h + 0 + edge_img )   ]; % conv pari, h dispari
    else
        h_padded = [   zeros(1, edge_h + edge_img )    h    zeros(1, edge_h + edge_img )   ];         % conv pari, h pari
    end
end


% PREALLOCATING MATRIX

temp = zeros( dim(1), 2*dim_conv-1 ); % matrice sporca di convoluzione
y_img = zeros( dim(1), dim_conv );  % risultato pulito


% ROW BY ROW CYCLE

for r = 1 : dim(1)
   
    img_padded = [   zeros(1, edge_img )     img(r,:)    zeros(1, edge_img )   ];  % OK
    
    %temp(r,:) = my_conv_core( img_padded, h_padded ); % si verifica cosa strana commutandoli
    temp1(r,:) = conv( img_padded, h_padded );
 
end

% INTEGER 8 BIT UNS CASTING 

temp = uint8( temp1 ); 

% EDGE CLEANING

raw = size(temp,2); % dimensione riga sporca di nero

if (mod(raw,2)==1)
    %fprintf(' da %f a %f ', 1+dim_conv/2, raw-dim_conv/2 ); 
    y_img = temp( :, 2 + (dim_conv+1)/2 : raw - (dim_conv+2)/2  );
else
    %fprintf(' da %f a %f ', dim_conv/2, raw-dim_conv/2 ); 
    y_img = temp( :, 1 + (dim_conv+1)/2 : raw - (dim_conv+2)/2  );
end

figure('name','Immagine filtrata'); imshow(y_img);