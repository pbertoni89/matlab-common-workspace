function W = tweedle_rec( N, w )
%Tweedle Generates Tweedle matrix.
%   requires N number of samples
%   requires w = exp( - 1i * 2 * pi / N ) )  because of the recursion.

    ind = 0:N-1;
    indb = 0:N-2;

    %fprintf('\n\n\n--------------------------------------------- N=%d\n',N);
    
    %last_col_pot = indb*(N-1)
    last_col =   w .^ (indb*(N-1)).';
    
    %last_col_pot = ind*(N-1)
    last_row =   w .^ (ind*(N-1)) ; 
    
    if N==1
 
        W = 1;
        
    else

        old = tweedle(N-1, w);

        %fprintf('\ncycle N=%d | linking %d cols of old with %d cols of last', N, size(old,1), length(last_col) );  
        W = [ old last_col ];
        
        %fprintf('\ncycle N=%d | linking %d rows of old with %d rows of last', N, size(old,2), length(last_row) );
        W = [ W ; last_row ];
        
    end
    
    
end

