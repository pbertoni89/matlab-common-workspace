function [ X ] = dft_N_2d( x, N )
%DFTN Summary of this function goes here
%   Detailed explanation goes here

      W = tweedle( N );
    
%     if size(x,2) ~= 1
%        if size(x,1) ~= 1
%            fprintf('Warning: cannot transform a mono-dimensional array. Returning zero.\n\n');
%            X = zeros(1,N); 
%        else
%            x = x.';
%        end
%     end

    [ r c ] = size(x);
    X = zeros( r,c );
    t = zeros( r,1 );

    for i = 1 : r
          
        t = W * x(i,:).';
    
        X(i,:)  = t.';
    
    end
    
    clc;
    
end

