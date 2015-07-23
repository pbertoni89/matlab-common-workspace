% funzione traslazione y=x(n-n0)

function y = shift(x,n,n0)
    if (n0>=0)
        y(1:n0)=zeros(1,n0);  % sono quelli inseriti dall'estremo, che "nascono dal nulla"
        y( n0+1 : length(n) ) = x( 1 : (length(n)-n0) ); % tutti gli altri traslati
    else 
        y = zeros( 1,length(n) );
        y( 1 : (length(n)+n0) ) = x( (-n0+1) : length(n) );
    end