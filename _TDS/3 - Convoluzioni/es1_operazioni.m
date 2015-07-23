
which es1_operazioni;

tS= -20:0.01:20; % tempo fine ed esteso

% ********************************************************************
% Operazioni su segnali

fprintf('\n*************************************************\nStep i\n');

 x1=4*my_rect((tS-3)/4);
 plot(tS,x1, 'r');
 hold on;
 axis( [min(tS) max(tS) min(x1)-1 max(x1)+1] )
 
 pause;
 hold off;
 
 x2=3*my_tri((tS+2)/5);
 plot(tS, x2, 'r');
 axis( [min(tS) max(tS) min(x2)-1 max(x2)+1] )
 
 pause;
 hold off;
 
 x3=my_eps(4-tS);
 plot(tS, x3, 'r');
 hold on;
 axis( [min(tS) max(tS) min(x3)-1 max(x3)+1] )
 % axis auto  % è pessimo
 
 pause; 
 hold off;

fprintf('\n*************************************************\nStep ii\n');
 
 x4= x1+x2+x3;
 plot(tS, x4, 'r');
 hold on;
 pause;
 
 x5= x1.*x2.*x3;
 plot(tS, x5, 'b');
 hold off;
 pause;
 
fprintf('\n*************************************************\nStep iii\n');
 
 x6= my_sinc(tS);
 plot(tS, x6, 'r');
 hold on;
 pause;
 
 x7= cos(pi*tS);
 plot(tS, x7, 'b');
 hold on;
 pause;
 
 x8= x6.*x7;
 plot(tS, x8, 'k');
 pause;
 hold off;
 
 fprintf('\n*************************************************\nStep iv\n');

 plot(tS, x8, 'g');
 hold on;
 pause;
 x9= my_sinc(2*tS);
 plot(tS, x9, 'r');
 hold off;
 pause; 

 % I segnali si sovrappongono identicamente. Il motivo
 
 fprintf('\n*************************************************\nStep v\n');
 
 x10= my_sinc(tS-2).*my_sinc(tS-2);
 plot(tS, x10, 'r');
 hold off;
 pause;
 
  fprintf('\n*************************************************\nStep vi\n');
  
  y= zeros(1,length(tS));
   % metodo patrizio: incredibilmente stupido.
  for k=1:length(tS)  % NON PARTE DA tS(1): l'indice parte da 1!!
      
      if tS(k)<-5||tS(k)>8
          y(k)=0;
          
      elseif tS(k)>-5&&tS(k)<0
          y(k)= 2*cos( 2*pi*tS(k) );

      elseif tS(k)>0&&tS(k)<1
          y(k)= tS(k);

      elseif tS(k)>=7&&tS(k)<=8
          y(k)= 8-tS(k);
      else
          y(k)=1;
      end
      
  end
 
  plot(tS, y, 'b');
  axis( [ -10 10 -2.5 2.5] )
  hold off;
  pause;
  
 close;
return;