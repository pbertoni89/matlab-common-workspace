
% Grossi problemi con assi delle ascisse 'strani'. sembra debbano esser
% simmetrici o avviene un errore.
%

function y = my_shift( x, n, n0 )

    y= zeros(1, length(n));
    
    nnull= find(x); % dove nnull significa non nulli.
    
    in_nnull = nnull(1); fn_nnull= nnull(length(nnull));
    
    
       for i= in_nnull : fn_nnull  % dovrei essere dentro i margini
            if( i+abs(n0) <= length(n) && i-abs(n0) >= 1)
             y(i+n0) = x(i);
            end
       end
       
end

