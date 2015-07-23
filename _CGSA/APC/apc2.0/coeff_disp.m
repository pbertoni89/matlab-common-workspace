function[sigma] = coeff_disp(t,s,x);
%
%_______________________________________________________________________________________
%
%
%La funzione COEFF_DISP calcola i coefficienti di dispersione 
%sigmay e sigmaz utilizzando le formule di Briggs.
%
%La funzione puo' effettuare il calcolo considerando le formule:
%-	Briggs Open Country
%-	Briggs Urban	 
%
%La funzione va utilizzata in questo modo:
%%		coeff_disp(TIPO_TERRENO,STABILITA,X)
%
%in cui:
%			t puo' assumere i valori 'o' (Open Country) e 'u' (Urban);
%			s, rappresenta la stabilita', e assume i valori 'a', 'b', 'c', 'd', 'e', 'f';
%			x rappresenta la coordinata x.
%
%_______________________________________________________________________________________
%

switch t					
case 'o'					%nel caso di terreno Open Country...
   switch s				%...si usano formule diverse a seconda della classe di stabilita
   case 'a'
      sigma(1)=0.22*x*(1+0.0001*x)^(-1/2);
      sigma(2)=0.20*x;
   case 'b'
      sigma(1)=0.16*x*(1+0.0001*x)^(-1/2);
      sigma(2)=0.12*x;
   case 'c'
      sigma(1)=0.11*x*(1+0.0001*x)^(-1/2);
      sigma(2)=0.08*x*(1+0.0002*x)^(-1/2);
   case 'd'
      sigma(1)=0.08*x*(1+0.0001*x)^(-1/2);
      sigma(2)=0.06*x*(1+0.0015*x)^(-1/2);
   case 'e'
      sigma(1)=0.06*x*(1+0.0001*x)^(-1/2);
      sigma(2)=0.03*x*(1+0.0003*x)^(-1);
   case 'f'
      sigma(1)=0.04*x*(1+0.0001*x)^(-1/2);
      sigma(2)=0.016*x*(1+0.0003*x)^(-1);
   otherwise			%caso in cui si inserisce una classe di stabilita inesistente
      disp('Le categorie di stabilita variano da a ad f')   
   end
   
case 'u'					%caso di terreno Urban...
   switch s				%formule differenti al variare della classe di stabilita
   case {'a','b'}
      sigma(1)=0.32*x*(1+0.0004*x)^(-1/2);
      sigma(2)=0.24*x*(1+0.001*x)^(-1/2);
   case 'c'
      sigma(1)=0.22*x*(1+0.0004*x)^(-1/2);
      sigma(2)=0.020*x;
   case 'd'
      sigma(1)=0.16*x*(1+0.0004*x)^(-1/2);
      sigma(2)=0.014*x*(1+0.0003*x)^(-1/2);
   case {'e','f'}
      sigma(1)=0.11*x*(1+0.0004*x)^(-1/2);
      sigma(2)=0.08*x*(1+0.0015*x)^(-1/2);
   otherwise
      disp('Le categorie di stabilita variano da a ad f')   
   end
   
otherwise				%caso in cui si immette valore tipo terreno inesistente
      disp('Il primo parametro puo assumere solo i valori ''o'' (Open Country) e ''u'' (Urban)')   
end
   
   

       
             
