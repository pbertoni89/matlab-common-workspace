function rep = pettine_impulsi( t, xT,T )

    % Riceve un asse del tempo, un periodo e il periodo base del segnale da
    % ripetere n volte (fino a riempire ottimamente t )

    rep= t;
    n= floor( ( t(length(t))-t(1) ) / T);
    i=0; 
    
    for k= 1:n
        
            %rep= rep+ (t- (k*T)*2).* my_rect((t -k*T)/T); 
            rep= rep+ myshift( xT, t( k+ floor(i/n)*length(t)   )/T );
       i= i+1;  
    end 
end

