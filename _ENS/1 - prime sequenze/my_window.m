function y = my_window(x,n)

    y = zeros(1,length(n));
    zero = find(n==0);
    
    sx_edge = n(1);
    dx_edge = n(length(n));

    %fprintf('i margini valgono %d e %d', sx_edge, dx_edge);
    
    for i = ( zero + sx_edge ):( zero + dx_edge )

        y(i)=x( i + dx_edge );
        
    end