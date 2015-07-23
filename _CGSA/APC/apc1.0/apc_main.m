function apc_main(data);
global conc_tot;
global c_f;
global conc_parz;

% clear conc_tot;
c_f=[0 0 0 0];
%Questo e' lo script che, presi dalla interfaccia dati relativi al dominio e dati relativi
%ai camini, calcola le concetrazioni di inquinanti (attraverso al funzione calc_conc
%e poi stampa a video delle mappe di concentrazione
%


%si dichiarano alcune variabili come globali
global Xin;
global Xfin;
global passoX;
global Yin;
global Yfin;
global passoY;
global Zin;
global Zfin;
global passoZ;

Xin=0;
Xfin=20000;
passoX=100;
Yin=0;
Yfin=20000;
passoY=100;
Zin=0;
Zfin=500;
passoZ=10;



n_camini=3;
n_citta=2;

ca=[data.presenza_camino_1 data.presenza_camino_2 data.presenza_camino_3];

%si assegna alla variabile t il relativo valore inserito con l'interfaccia (Open Country o Urban),
switch data.tipologia_terreno
    case 2  
        data.tipologia_terreno='o';
    case 3
        data.tipologia_terreno='u';
end;


%si assegna alla variabile s il relativo valore inserito con l'interfaccia
switch data.classe_stabilita
    case 2  
        data.classe_stabilita='a';
    case 3
        data.classe_stabilita='b';
    case 4  
        data.classe_stabilita='c';
    case 5
        data.classe_stabilita='d';
    case 6  
        data.classe_stabilita='e';
    case 7
        data.classe_stabilita='f';
end;


%si assegna alla variabile t il relativo valore inserito con l'interfaccia (Open Country o Urban),
switch data.dimensione_impianto_camino_1
    case 2  
        data.dimensione_impianto_camino_1='p';
    case 3
        data.dimensione_impianto_camino_1='g';
end;
switch data.dimensione_impianto_camino_2
    case 2
        data.dimensione_impianto_camino_2='p';
    case 3
        data.dimensione_impianto_camino_2='g';
end;
switch data.dimensione_impianto_camino_3
    case 2
        data.dimensione_impianto_camino_3='p';
    case 3
        data.dimensione_impianto_camino_3='g';
end;



%inizializzo la variabile che dovra' contenere le concentrazioni totali di inquinanti
conc_tot=0;		

%passo alla funzione tutti i dati necessari al calcolo della concentrazione generata 
%dall'i-esimo camino
for j=1:n_camini
   conc_parz{j}=0;
   str = int2str(j); 
   if eval(['data.presenza_camino_',str])==1
       conc=calc_conc(data.tipologia_terreno,data.classe_stabilita,data.velocita_vento,...
           data.direzione_vento,data.temperatura_aria,eval(['data.dimensione_impianto_camino_',str]),...
           eval(['data.coordinate_camino_',str]),eval(['data.altezza_geometrica_camino_',str]),...
           eval(['data.raggio_camino_',str]),eval(['data.rateo_di_emissione_camino_',str]),...
           eval(['data.velocita_uscita_fumi_camino_',str]),eval(['data.temperatura_uscita_fumi_camino_',str]));
       conc_parz{j}=conc;				%valori di concentrazione dei singoli camini
       conc_tot=conc_tot+conc;			%valori totali di concentrazione
   end
end

%ciclo che stampa le mappe di concentrazione dei singoli camini
for k=1:n_camini
    str=int2str(k);
    if eval(['data.presenza_camino_',str])==1
        c_f(k)=figure('position',[150 50 960 510]); 		%apre una nuova finestra
        [c,h]=contourf(Xin:passoX:Xfin,Yin:passoY:Yfin,conc_parz{k}(:,:,1));	%crea la mappa
        colorbar('vert');			%inserisce una barra per visualizzare concentrazioni
        clabel(c,h);				%inserisce etichette agli assi
        hold on;
        str = int2str(k); 
        coord=eval(['data.coordinate_camino_',str]);
        plot (coord(1),coord(2),'ro');
        hold on;
        for l=1:n_citta
            str = int2str(l); 
            if eval(['data.presenza_citta_',str])==1
                coord=eval(['data.coordinate_citta_',str]);
                plot (coord(1),coord(2),'r^');
            end
        end
        hold off;
    end
end



%mappa delle concentrazioni dell'insieme dei camini
if  length(find(ca>0))>1
    c_f_t=figure('position',[150 50 960 510]); 		%apre una nuova finestra
    c_f=[c_f c_f_t];
    [c,h]=contourf(Xin:passoX:Xfin,Yin:passoY:Yfin,conc_tot(:,:,1));
    colorbar('vert');
    clabel(c,h);				%inserisce etichette agli assi
    hold on;
    k=1;
    for k=1:n_camini
        str = int2str(k);
        if eval(['data.presenza_camino_',str])==1
            coord=eval(['data.coordinate_camino_',str]);
            plot (coord(1),coord(2),'ro');
        end
    end
    hold on;
    for k=1:n_citta
        str = int2str(k); 
        if eval(['data.presenza_citta_',str])==1
            coord=eval(['data.coordinate_citta_',str]);
            plot (coord(1),coord(2),'r^');
        end
    end
    % plot (posizione_citta(1),posizione_citta(2),'r^');
    hold off;
end;











