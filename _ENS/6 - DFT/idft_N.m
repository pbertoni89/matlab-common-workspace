function [ X ] = idft_N( x, N )
%IDFTN Inverse Discrete Fourier Transform of an array x by N points.
%  
    W = tweedle( -N );
    
    if size(x,2) ~= 1
       if size(x,1) ~= 1
           fprintf('Warning: cannot transform a mono-dimensional array. Returning zero.\n\n');
           X = zeros(1,N); 
       else
           x = x.';
       end
    end
    
    X = W * x;
    X = X / N;
    
    X = X.';
    
end

