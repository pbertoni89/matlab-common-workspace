function val = dente_sega( t, T )

    val=t;
    n= ceil( ( t(length(t))-t(1) ) / T);
    
    for k=floor(-n/2):floor(n/2)
        
            val= val+ (t- (k*T)*2).* my_rect((t -k*T)/T); 
    end 
end

