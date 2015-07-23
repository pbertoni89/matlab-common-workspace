function [ X ] = dft_N( x, N )
%DFTN Discrete Fourier Transform of an array x by N points.
%  

    %W = tweedle( N );
    W = tweedle( N );
    
    if size(x,2) ~= 1
       if size(x,1) ~= 1
           fprintf('Warning: cannot transform a mono-dimensional array. Returning zero.\n\n');
           X = zeros(1,N); 
       else
           x = x.';
       end
    end
    
    if length(x) > N
        %fprintf('N is insufficient. Stretching x.\n');
        x = x(1:N);
    elseif length(x) < N
        %fprintf('N is overwhelmed. Padding x.\n');
        x = [ x ; zeros(N-length(x), 1) ];
    end    
    
    X = W * x;
    
    X = X.';
    
end

