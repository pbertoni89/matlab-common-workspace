function y = my_decimate( x, n, D )

    y= zeros(1, length(n));
    
    validi= find(x);
    
    for i= 1:length(validi)
       
        if( mod( n(validi(i)), D) == 0  )  % è decimabile
            %fprintf('il mod( %d, %d) ha restituito %d: ENTRO \n', n(validi(i)), D, mod( n(validi(i)), D)); 
           
           if(n(validi(i))<0) % n<0
               %fprintf('NEG: sposto y( %d + %d/%d ) in x( %d ) \n', validi(i), abs(n(validi(i))), D,  validi(i) );
              y( validi(i) + abs(n(validi(i))) *(D-1)/D ) = x( validi(i) ); 
           else         % n>=0
               %fprintf('POS: sposto y( %d - %d/%d ) in x( %d ) \n', validi(i), abs(n(validi(i))), D,  validi(i) );
              y( validi(i) - abs(n(validi(i))) *(D-1)/D ) = x( validi(i) ); 
           end
           
        end
        
    end
end

