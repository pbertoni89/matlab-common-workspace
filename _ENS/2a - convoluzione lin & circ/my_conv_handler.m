function c = my_conv_handler( x, y , n_x, n_y )
   
    %% ZERO PADDING
   
    x_trues = find(x);
    y_trues = find(y);
    
    x_clean = x ( x_trues );
    y_clean = y ( y_trues );
    
    Nx = length( x_clean );
    Ny = length( y_clean );

    gap = Nx-Ny;
    
    if(gap<0) 
   
         for i=1: - gap
            x_clean( Nx+i ) = 0;
         end   
         
    elseif (gap>0)
   
          for i=1:gap
            y_clean( Ny+i ) = 0;
          end
          
    end


    %% PROCEDURE CALL
    
    w = my_conv_core(x_clean, y_clean);
    
    
    %% ZERO CLEANING
    
    w = w( 1 : length(w) - abs(gap) );
    
    
    %% GESTIONE DEL NUOVO ASSE
    
    x_begin = n_x( x_trues(1) );
    y_begin = n_y( y_trues(1) );
    
    x_end = n_x( x_trues(Nx) );
    y_end = n_y( y_trues(Ny) );
    
    n_w = floor( x_begin + y_begin ): floor( x_end + y_end );  % big array
    n_w = n_w( find(w) ); 

    
    c = [ w ; n_w ];
    
end

