function [ Y ] = LP_Integer_Matrix( X, gain, verbose )
%LP_FILTER  Low - pass filter for integer matrices.
%   [ Y ] = LP_Integer_Matrix( X, gain, verbose )
%      where:  X is a N-by-M matrix,
%      gain is the amplitude factor of the filter,
%      verbose if set 1 prints lots of dots.

warning('off','MATLAB:colon:nonIntegerIndex');
warning('off','MATLAB:conv2:uint8Obsolete');

% risposta all'impulso del filtro LOW - PASS
h = gain* [ .25 .5 .25 ];
%h = gain* [ -1 0 3 ];

%figure(1); imshow(X);

dim = size(X);

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

temp1 = zeros( dim(1), 2*dim_conv-1 ); % matrice sporca di convoluzione
Y = zeros( dim(1), dim_conv );  % risultato pulito

fprintf('filtering...\n');

if verbose == 1
        for r = 1 : dim(1)

            if mod(r,50)==0
                fprintf('\n');
            else
                fprintf('.');
            end

            img_padded = [   zeros(1, edge_img )     X(r,:)    zeros(1, edge_img )   ];

            temp1(r,:) = conv( img_padded, h_padded );

        end
else    
        for r = 1 : dim(1)

            img_padded = [   zeros(1, edge_img )     X(r,:)    zeros(1, edge_img )   ];

            temp1(r,:) = conv( img_padded, h_padded );

        end
end
fprintf('\n');

temp = uint8( temp1 ); 

raw = size(temp,2);

if (mod(raw,2)==1)
    Y = temp( :, 2 + (dim_conv+1)/2 : raw - (dim_conv+2)/2  );
else
    Y = temp( :, 1 + (dim_conv+1)/2 : raw - (dim_conv+2)/2  );
end

end

