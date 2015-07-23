function y = sinc( n )
%SINC Returns the sine of the number, multiplied by pi
% and divided by pi*n ; if n=0, returns 1 as Taylor series predict.
% Obviously, the call sinc(n*1) will return all zeros. try multiplying it!

    y = zeros(1,length(n));

    y(n==0) = 1;
    
    y(n~=0) = sin( pi*n(n~=0) ) ./ ( pi*n(n~=0) ) ;
    
end

