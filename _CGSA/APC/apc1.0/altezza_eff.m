function[altezza_eff] = altezza_eff(d,v_vento,t_aria,s,h_geom,v_fumi,t_fumi,r_camino,x);
%_______________________________________________________________________________________
%
%La funzione ALTEZZA_EFF calcola l'altezza efficace del punto di emissione
%utilizzando le formule di Briggs.
%
%Gli input necessari alla funzione sono, in ordine:
%
%d		dimensione emissione; puo' assumere valore 'g' (grandi impianti) e 'p' (piccoli)
%v_vento	velocita' vento [m/s]
%t_aria		temperatura aria ambiente
%s	
%h_geom		altezza geometrica del camino
%v_fumi		velocita' di uscita dei fumi dal punto di emissione [m/s]
%t_fumi		temperatura fumi	
%r_camino	raggio del camino [m]
%x		coordinata x
%
%La funzione presuppone in input un valore di velocita' del vento > 1 m/s
%
%
%L'output e'
%altezza_eff:		altezza efficace camino
%_______________________________________________________________________________________

%calcolo del parametro di galleggiamento
F=((t_fumi-t_aria)/t_fumi)*9.81*v_fumi*(r_camino^2);	

%si definisce, per ogni categoria di stabilita', il corrispondente gradiente
%di temperatura
switch s
case 'a'
   t_grad=-0.019;
case 'b'
   t_grad=-0.018;
case 'c'
   t_grad=-0.016;
case 'd'
   t_grad=-0.01;
case 'e'
   t_grad=0.005;
case 'f'
   t_grad=0.015;
end

%calcolo del parametro di stabilita

S=(9.81/t_aria)*((t_grad)+0.0098);								%parametro di stabilita'
% S=(9.81/t_aria)*((t_grad));
%si calcola il delta_h, ovvero il valore del sovrainnalzamento del pennacchio
%rispetto all'altezza geometrica
if d=='g'					%nel caso di 'grande' emissione
    
    %definisco  delta_h ed xf, distanza dalla sorgente a cui avviene il passaggio
    %tra fase di transizione e fase di livellamento, distinguendo tra
    %situazione stabile ed instabile
    if S<=0
        if v_vento<1
            v_vento=1;
        end
        xf=6.48*F^(2/5)*h_geom^(3/5);	
        if x<=xf
            if isreal(x^(2/3))==1
                delta_h=1.6*F^(1/3)*x^(2/3)*v_vento^(-1);
            else
                t=real(x^(2/3))^2+imag(x^(2/3))^2;
                delta_h=1.6*F^(1/3)*t*v_vento^(-1);
            end
            if delta_h>1.6*F^(1/3)*xf^(2/3)*v_vento^(-1)
                delta_h=1.6*F^(1/3)*xf^(2/3)*v_vento^(-1);
            end
        else
            delta_h=1.6*F^(1/3)*xf^(2/3)*v_vento^(-1);
        end
        
        %nel caso invece di stabilità
    elseif S>0 
        xf=2*v_vento*S^(-1/2);
        if v_vento>=1
            if x<=xf
                if isreal(x^(2/3))==1
                    delta_h=1.6*F^(1/3)*x^(2/3)*v_vento^(-1);
                else
                    t=real(x^(2/3))^2+imag(x^(2/3))^2;
                    delta_h=1.6*F^(1/3)*t*v_vento^(-1);
                end
            else
                delta_h=2.6*(F/(v_vento*S))^(1/3);
            end
        elseif v_vento<1
            delta_h=5.1*F^(1/4)*S^(-3/8);
        end
    end
   
elseif d=='p'				%nel caso di 'piccola' emissione
   
   delta_h=6*r_camino*((v_fumi/v_vento)-1);
   
else
	%nel caso si sbagli a inserire il valore relativo a dimensione emissione   
   disp('Il primo input deve essere ''g'' o ''p'' (Grandi o Piccoli impianti')   ;
   
end

%si calcola l'altezza efficace sommando l'altezza geometrica e il delta_h 
altezza_eff=h_geom+delta_h;	

   


