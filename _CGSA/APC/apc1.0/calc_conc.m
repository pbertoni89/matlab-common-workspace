function[conc] = calc_conc(t,s,v_vento,d_vento,t_aria,d,posizione,h_geom,r_camino,q_emiss,v_fumi,t_fumi);
%
%la funzione CALC_CONC calcola le concentrazioni per l'i-esimo camino   

global Xin;
global Xfin;
global passoX;
global Yin;
global Yfin;
global passoY;
global Zin;
global Zfin;
global passoZ;

%si definisce il dominio in termini di coordinate iniziali, finali e come passo temporale

%inizializzo i contatori per 'caricare' i valori di concentrazione nella matrice conc
i=0;					
j=0;
k=0;

%formule per la rotazione del SDR: passo da angolo in gradi ad angolo in radianti
alph = (d_vento+90)*pi/180;		
cosa = cos(alph);
sina = sin(alph);
R=[cosa -sina; sina cosa];		

%inizializzo la matrice in cui si 'caricheranno' le concentrazioni di inquinante
dim1=((Xfin-Xin)/passoX)+1;
dim2=((Yfin-Yin)/passoY)+1;
dim3=((Zfin-Zin)/passoZ)+1;

conc=zeros(dim1,dim2,dim3);

%qui sono presenti tre cicli annidati che calcolano, per i punti del dominio,
%i valori di concentrazione
for x = Xin:passoX:Xfin,
   i=i+1;
   j=0;
   for y = Yin:passoY:Yfin,
      j=j+1;
      k=0;
      
      newcoord=R*[x-posizione(1),y-posizione(2)]';		%roto-traslazione del SDR
         xr=newcoord(1);
         yr=newcoord(2);
         
         %chimata alla funzione che calcola, per ogni valore di xr,
         %i coefficienti di dispersione a partire dal tipo di terreno, 
         %dalla classe di stabilita' e dalla coordinata xr
         sigma=coeff_disp(t,s,xr);	
         sy=sigma(1);			
         sz=sigma(2);					
         
         %chiamata alla funzione che calcola, per ogni valore di xr, l'altezza
         %efficace da poi usare nel calcolo delle concentrazioni
         H = altezza_eff(d,v_vento,t_aria,s,h_geom,v_fumi,t_fumi,r_camino,xr);
         
         %si considera la parete di dominio interessato dalla propagazione di inquinante
         if (xr > 0) 						
             for z = Zin:passoZ:Zfin,
                 
                 k=k+1;         
                 
                 %Concentrazioni in mug/m3
                  conc(j,i,k) = (q_emiss/(2*pi*v_vento*sy*sz) * exp(-0.5*yr^2/sy^2)*(exp(-0.5*(z-H)^2/sz^2)+exp(-0.5*(z+H)^2/sz^2)))*1000000;
%                               conc(j,i,k) = q_emiss/(pi*v_vento*sy*sz) * exp(-0.5*yr^2/sy^2)*(exp(-0.5*(H)^2/sz^2))*1000;
                 %           profilo(i) = q_emiss/(2*pi*v_vento *sy*sz) *exp(-0.5*yr^2/sy^2)*(exp(-0.5*(H)^2/sz^2))*1000;
                 
             end
         end
     end
 end
  
