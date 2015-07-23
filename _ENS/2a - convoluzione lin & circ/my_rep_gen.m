function xp = my_rep_gen( xb, n )
%MY_REP_GEN genera una sequenza periodica dato un periodo base e il suo
%asse.

   i_zero = find(n==0);
   
   per = length(xb);
   
   bg = n(1); en = n(length(n));

%     for i= i_zero : en - per
%        
%         for j= 0 : per-1
%             xp(i+j) = xb(j+1);
%  
%         end
%     end
%     
%     for i= i_zero - 1 :(-1): 1
%        
%         for j= 0 : per-1
%             xp(i+j) = xb(j+1);
%  
%         end
%     end

    for i = 1: per : length(n)- 1
        for j= 0 : per-1
            if i+j <= length(n)
             fprintf(' i<%d, procedo. in posizione n(%d+%d)=%d metto %d \n', length(n)-2, i, j, n(i+j), xb(j+1) );
             xp(i+j) = xb(j+1);
            end
         end
    end
    
    fprintf('ora confronto %d = %d -1\n', length(xp), length(n));
    %sistemo scarti. dovuto ad algoritmo qui sopra non efficientissimo
    if length(xp) == length(n)-1
        fprintf(' \n \n SONO ENTRATO!!!    \n\n\n');
        pause;
        xp(length(n)) = xb(1);
    end

        
end