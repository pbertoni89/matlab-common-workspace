% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 3: prime elaborazioni di immagini
%
% algoritmo COLONNA PER COLONNA
%

clear; clc; close all;
i = 1;

% come effettuare una convoluzione su una matrice?? riga per riga.
%   X_10 * h = Y_10
%   X_20 * h = Y_20
%   X_30 * h = Y_30
%   X_40 * h = Y_40
%   X_50 * h = Y_50

amp = 1;
% risposta all'impulso del filtro LOW - PASS
h = amp * [ .25 .5 .25 ];
% risposta all'impulso del filtro HIGH - PASS
%h = amp *[ -30 0 30 ];

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

figure(1); imshow(img); 

dim = size(img);


%% H ZERO PADDING

edge_img = length(h)-1;

dim_conv =  edge_img + dim(1) + edge_img; % dimensione colonna da convolvere

edge_h = floor( (dim(1)-length(h))/2 );

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

h_padded = h_padded';

% PREALLOCATING MATRIX

%temp = zeros(  2*dim_conv-1 , dim(2) ); % matrice sporca di convoluzione
%y_img = zeros( dim_conv , dim(2) );  % risultato pulito


% COL BY COL CYCLE

for c = 1 : dim(2)
   
    img_padded = [   zeros(edge_img, 1) ;  img(:,c)  ;  zeros(edge_img,1 )   ];  % OK
    
    %temp(r,:) = my_conv_core( img_padded, h_padded ); % si verifica cosa strana commutandoli
    temp(:,c) = (conv( img_padded', h_padded' ))' ;
 
end

% INTEGER 8 BIT UNS CASTING 

temp = uint8( temp ); 

% EDGE CLEANING

raw = size(temp,1); % dimensione  colonna sporca di nero

if (mod(raw,2)==1)
    %fprintf(' da %f a %f ', 1+dim_conv/2, raw-dim_conv/2 ); 
    y_img = temp( 2 + (dim_conv+1)/2 : raw - (dim_conv+2)/2  ,: );
else
    %fprintf(' da %f a %f ', dim_conv/2, raw-dim_conv/2 ); 
    y_img = temp( 1 + (dim_conv+1)/2 : raw - (dim_conv+2)/2 ,: );
end

figure(2); imshow(y_img);