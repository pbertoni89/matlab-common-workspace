function W = tweedle( N, w )

    ind = 0:N-1;
    indb = 0:N-2;

    last_col =   w .^ (indb*(N-1)).';
    
    last_row =   w .^ (ind*(N-1))   ; 
    
    if N == 1
 
        W = 1;
        
    else
        old = tweedle(N-1, w);

        W = [ old last_col ];
      
        W = [ W ; last_row ];
        
    end  
end

