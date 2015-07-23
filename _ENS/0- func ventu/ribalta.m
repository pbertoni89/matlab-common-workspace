% funzione ribaltamento ATTORNO ALL'ORIGINE

function y = ribalta(x,n)
    
    y = zeros(1,length(n)); %init
    
    p = find(n==0);
    
    y(p)=x(p);
    
    for i = 1:p
        y(i)= x( 2*p-i );
    end
    
    for i = (p+1):(2*p -1)
        y(i)= x( 2*p-i );
    end