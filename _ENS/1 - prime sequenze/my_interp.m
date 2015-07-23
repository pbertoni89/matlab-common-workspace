function y = my_interp( x, I )
    % Interpolates sequence x with a factor I of zeros.
    % Does not require n axis because all the sequences are the same thing
    l = length(x);
    y= zeros(1, I*l );
   % validi= find(x);
    y(1) = x(1);
    
    for k = 2 : l
        y( (I * k)-1 ) = x(k);
    end
    
%     for i= 1:length(validi)  
%         %fprintf('confronto se |%d >= %d e |%d <= %d \n', n(validi(i))*I, n(1), n(validi(i))*I, n(length(n)));
%         if( n(validi(i))*I >= n(1) && n(validi(i))*I <= n(length(n)) )  % è interpolabile nel range             
%            if(n(validi(i))<0) % n<0
%                %fprintf('NEG: sposto y( %d - %d*%d ) in x( %d ) \n', validi(i), abs(n(validi(i))), I,  validi(i) );
%               y( validi(i) - abs(n(validi(i))) *(I-1) ) = x( validi(i) ); 
%            else         % n>=0
%                %fprintf('POS: sposto y( %d + %d*%d ) in x( %d ) \n', validi(i), abs(n(validi(i))), I,  validi(i) );
%               y( validi(i) + abs(n(validi(i))) *(I-1) ) = x( validi(i) ); 
%            end   
%         end
%     end
end