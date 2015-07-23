function y =  my_rotate( x, n )

    y= zeros(1, length(n));
    
    validi= find(x);
    
    center= ceil( length(n)/2 );
    
    for i= 1:length(validi)
       
       gap = validi(i) - center;
       
       y( center - gap) = x ( center + gap );
        
    end
end

