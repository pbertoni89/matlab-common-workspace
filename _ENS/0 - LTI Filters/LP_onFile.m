function [ Yimg ] = LP_filter_onFile( file, ext )
%LP_FILTER Summary of this function goes here
%   Detailed explanation goes here


i = 1;

% risposta all'impulso del filtro LOW - PASS
h = [ .25 .5 .25 ];

% inserire controllo stringhe
img = imread(file,ext);

figure(1); imshow(img);

dim = size(img);

edge_img = length(h)-1;

dim_conv =  edge_img + dim(2) + edge_img;

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

temp = zeros( dim(1), 2*dim_conv-1 ); % matrice sporca di convoluzione
Yimg = zeros( dim(1), dim_conv );  % risultato pulito

for r = 1 : dim(1)
   
    img_padded = [   zeros(1, edge_img )     img(r,:)    zeros(1, edge_img )   ];  % OK
    temp1(r,:) = conv( img_padded, h_padded );
 
end

temp = uint8( temp1 ); 

raw = size(temp,2);

if (mod(raw,2)==1)
    Yimg = temp( :, 2 + (dim_conv+1)/2 : raw - (dim_conv+2)/2  );
else
    Yimg = temp( :, 1 + (dim_conv+1)/2 : raw - (dim_conv+2)/2  );
end

end

