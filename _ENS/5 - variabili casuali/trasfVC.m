function [ Y ] = trasfVC( a, U, f_y)  
%TRASFVC Trasforma una variabile distribuita uniformemente in una con f_y 
%desiderata.
    % a la variabile 'piccola'
    % U la uniforme (qualsiasi) di partenza
    % f_y la pdf desiderata della nuova vc

    Y = zeros( 1, length(U) );     % variabile casuale Y
    F = zeros( 1, length(a) );       % funzione integrale F_y
    
    de_a = a(2)-a(1); 

    for i = 2:length(a)
        F(i) = F(i-1) + f_y(i) * de_a ;   % sommatoria di costruzione integrale
    end

    zeroIndex = sum( F == 0 );
    oneIndex  = sum( F == F(length(F)) );

    Fclip = F( zeroIndex : length(F) - oneIndex + 1 );
    aClip = a( zeroIndex : length(F) - oneIndex + 1 );

    for u = 1:length(U)
        
        yIndex = abs( Fclip - U(u) ) == min( abs( Fclip - U(u) ) );
        
        Y(u) = aClip(yIndex);
    
    end

end

