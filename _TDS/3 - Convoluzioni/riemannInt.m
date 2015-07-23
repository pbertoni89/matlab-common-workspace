
function back= riemannInt( t, a, b, x)

   g = t(2)-t(1);   % trovo il passo (granularità

   ind_a = int32( ( (a - t(1))/g) +1);
   ind_b = int32( ( (b - t(1))/g) +1);  % trovo gli indici degli estremi (nel tempo)

   back=0;
   
   for i=ind_a:ind_b
      
       back= back+ g*x(i);
       
   end
   
return;