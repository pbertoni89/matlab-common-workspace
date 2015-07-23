%implementazione dell'algoritmo di Langstaff
function [ ] = algLangstaff(limiteStazioni,minVarS,errOss,areaAddiz,handles )

global allScenari;
global popolazione;
global freqAccad;

tic %ancora da cui parto a misurare il tempo di esecuzion (vedi toc dopo)
if get(handles.checkBoxOutput, 'Value') == 1
    name = datestr(now,'Lang_dd-mm-yy_HH.MM.ss'); %nome della simulazione
    mkdir(datestr(now,strcat('output/',name))); %cartella che contiene la simulazione
    fid1 = fopen(strcat('output/',name,'/',name,'.txt'),'wt'); %apro il file di output per tutte le stazioni
    fid2 = fopen(strcat('output/',name,'/',name,'_result.txt'),'wt'); %apro il file di output che contiene i dati riassuntivi
    fprintf(fid1,strcat('File di input inquinamento:',get(handles.editFileInput,'String'),...
        '\nNumero massimo di stazioni:',num2str(limiteStazioni),'\nFile di input popolazione:',get(handles.editPopolazione,'String'),...
        '\nMinima varianza spiegata:',num2str(minVarS),'\nErrore di osservazione:',num2str(errOss),...
        '\nMinima area non coperta:',...
        num2str(areaAddiz),'\n\nLegenda: O = stazione; # = cluster; vuoto = -\n\n'));   
end   

set(handles.textInProgress, 'Visible','on','String','Calcolo della FOM e delle potenziali stazioni in corso ...');
refresh(monet2);
[rig,col] = size(allScenari{1});
[waste,nScenari] = size(allScenari);

efficienze=[];
allClusterScenari = {};
dosaggioTotale = 0;
minimaVarSpieg = minVarS/100; %ad es 45 diventa 0.45

set(handles.tableOutput,'ColumnName',{'X','Y','1-picco, 0-valle','FOM','copertura [%]','copertura tot [%]'}, 'Data',{});
refresh(monet2);

FOM = zeros(rig,col); %matrice che conterra' la figura di merito
%la popolazione viene considerata distribuita in modo uniforme
if isempty(get(handles.editPopolazione, 'String')) 
    for s = 1:nScenari
        scenario=allScenari{s};
        for r = 1:rig
            for c = 1:col
                FOM(r,c) = FOM(r,c) + scenario(r,c) * freqAccad(s) ;
            end
        end
    end
else %tengo in considerazione anche la distribuzione della popolazione
    for s = 1:nScenari
        scenario=allScenari{s};
        FOM = FOM + popolazione .* scenario .* freqAccad(s);
    end
end

%regolarizzo la FOM per evitare le piccole fluttuazioni
[smoothFOM] = smoothing(rig,col,FOM);
[smoothFOM] = smoothing(rig,col,smoothFOM);
[smoothFOM] = smoothing(rig,col,smoothFOM);
FOM = smoothFOM;

picchi = [];
picchi = ricercaPicchi(rig,col,FOM,limiteStazioni);
picchi = sortrows(picchi,-3); %ordina i picchi dal maggiore al minore
valli=[];
valli = ricercaValli(rig,col,FOM,limiteStazioni);

%ordina il vettore delle valli associandole al vettore dei picchi (associo
%ad ogni picco, la valle che vi si trova piï¿½ vicino)
tmp_valle=[];
[sp,waste]=size(picchi);
[sv,waste]=size(valli);
concat = [];
objSOI = {}; %per ogni x, contiene una matrice in cui si trovano
%le soi e il tipo di stazione

%inserisco il tipo di stazione (picco o valle)
min(sv,sp); %cioï¿½ ci sono almeno min(sv,sp) elementi sia in valli che in picchi
for x = 1 : min(sv,sp)    
    if mod(x,2)~=0 % l'indice di concat ï¿½ dispari -> la stazione ï¿½ un picco
        objSOI{x}{2} = 1;
    else % l'indice di concat ï¿½ dispari -> la stazione ï¿½ una valle
        objSOI{x}{2} = 0;
    end
end
if sp > sv %se ci sono piï¿½ picchi che valli
    for x = 1 : (sp-sv) 
        objSOI{x}{2} = 1; %metto le restanti stazioni come picchi
    end    
end
if sp < sv %se ci sono piï¿½ picchi che valli
    for x = 1 : (sp-sv) 
        objSOI{x}{2} = 0;
    end    
end

%associo ad ogni picco la corrispondente valle, in base alla vicinanza
%spaziale..picchi o valli in surplus vengono accodati in fondo 
for p = 1 : sp
   [sv,waste]=size(valli); 
    concat = [concat;picchi(1,1:2)]; %prendo il primo picco, e siccome ogni volta elimino 
       %il primo della lista, la volta dopo praticamente prendo quello che
       %sarebbe il successivo
   if sv ~= 0 %controllo se ci sono piï¿½ picchi che valli
       tmp_valle=valli(1,:);
       %inizializzo la distanza minima
       distMin = (picchi(1,1) - valli(1,1)).^2 + (picchi(1,2) - valli(1,2)).^2;
       [sv,waste]=size(valli);
       for v = 1 : sv
           if (distMin >= (picchi(1,1) - valli(v,1))^2 + (picchi(1,2) - valli(v,2))^2)
               distMin = (picchi(1,1) - valli(v,1))^2 + (picchi(1,2) - valli(v,2))^2;
               tmp_valle=valli(v,1:2);
           end
       end
       concat = [concat;tmp_valle];
       for u = 1 : sv
            if valli(u,1:2) == tmp_valle
                valli(u,:) = [];
                break;
            end    
       end     
   else %i picchi sono piï¿½ delle valli, concateno i restanti picchi
       concat = [concat;picchi(:,1:2)];
       break;
   end
   picchi(1,:) = [];
end
%alla fine picchi e valli dovrebbero essere vuoti, ma se le valli sono piï¿½
%dei picchi, devo inserirle in fondo a concat:
[sv,waste]=size(valli);
if sv ~= 0 %ci sono piï¿½ valli che picchi
    concat = [concat;valli(:,1:2)];
end

correlazioni = {}; %per ogni x, contiene una matrice in cui si trovano
%le correlazioni spiegate rispetto ad ogni y
len = length(concat);
for x = 1:len
    varianzaSpieg = [];
    listaX=[];
    sqmX = 0;
    sommaX = 0;
    somma2X = 0;
    for s = 1:nScenari
        listaX(end+1)=allScenari{s}(concat(x,1),concat(x,2));
    end
    sqmX = std(listaX);
    sommaX = sum(listaX);
    somma2X = sum(listaX.^2);
    
    Ar = nScenari * somma2X - sommaX^2;
    if Ar < 0
        sqmX = 0;
    else
        sqmX = sqrt(Ar);
    end
    correlazione = [];
    K = std(errOss)^2 / sqmX^2;
    for r = 1:rig %cicli annidati per selezionare la y per la stazione
        for c = 1:col
                listaY=[];
                sqmY = 0;
                sommaY = 0;
                somma2Y = 0;
                sommaXY = 0;
                %corrXY = 0;
                Arg2 = NaN;
                for s = 1:nScenari
                    listaY(end+1)=allScenari{s}(r,c);
                end
                
                sqmY = std(listaY);
                sommaY = sum(listaY);
                somma2Y = sum(listaY.^2);
                sommaXY=sum(listaX.*listaY);
                Arg = nScenari * somma2Y - sommaY^2;
                if (Arg > 0) && (sqmX ~= 0)
                    Arg2 = (nScenari * sommaXY - sommaX * sommaY)/(sqmX * sqrt(Arg));
                else
                    Arg2 = 0; 
                end
                if Arg2 > 1 %scarso numero o valori costanti 
                    Arg2 = 0.99999;
                end
                correlazione(r,c) = Arg2;
                corrXY = corrcoef(listaX,listaY);
                correlazione(r,c)=corrXY(1,2);
                %se y ï¿½ una stazione, la varianza spiegata sarï¿½ 1
                varianzaSpieg(r,c) = Arg2^2 / (1 + K);
        end
    end
    correlazioni{x} = correlazione;
end


%trovo le coordinate della SOI per ogni x
for x = 1:len 
    set(handles.textInProgress, 'String',strcat('Ricerca SOI stazione _',num2str(x),'/',num2str(len),'_ in corso ...'));
    refresh(monet2)
    soi=[];
    [soi,waste]=cercaSOI(concat(x,1),concat(x,2),soi, correlazioni{x},errOss,nScenari,minVarS,rig,col);
    objSOI{x}{1} = soi; %il vettore contiene le coordinate della SOI per quell'x, compresa la stazione
    if mod(x,2)~=0 % l'indice di concat ï¿½ dispari -> la stazione ï¿½ un picco
        objSOI{x}{2} = 1;
    else % l'indice di concat ï¿½ dispari -> la stazione ï¿½ una valle
        objSOI{x}{2} = 0;
    end
end

set(handles.textInProgress, 'String','Selezione delle stazioni in corso ...');

cont = 0;
stazioniSelezionate = {}; %1: cooedinate stazione; 2: coordinate copertura;
%3: tipo di stazione (picco o valle)
percentAreaTotCoperta = 0; %copertuta totale 
%minimo di celle che non devono essere sovrapposte ad altre
coperturaTot = [];
[len,waste]=size(concat);
[len2,waste]=size(concat);
totSOI = []; %coordinate di tutte le soi
matrSOI = []; %matrice che contiene un 1 ogni volta che un punto appartiene ad una soi
matrSOI = zeros(rig,col);
%calcolo della SOI totale per iniziare la selezione delle stazioni
for w = 1 : len2 
    [vas,waste]=size(objSOI{w}{1});
    for i = 1 : vas
        matrSOI(objSOI{w}{1}(i,1),objSOI{w}{1}(i,2))=matrSOI(objSOI{w}{1}(i,1),objSOI{w}{1}(i,2))+1;
        if ~(ismember([objSOI{w}{1}(i,1),objSOI{w}{1}(i,2)],totSOI, 'rows'))
            totSOI = [totSOI;objSOI{w}{1}(i,1:2)];
        end
    end
end

%seleziono le stazioni
while len2 >= 1 %scorro le stazioni dall'ultima alla prima
    percentCoperturaLibera = 0;
    [a,waste]=size(totSOI);
    totSOIdiff = 0;
    matrSOItemp = matrSOI;
    [vas,waste]=size(objSOI{len2}{1});
    diffCelle = 0;
    
    for i = 1 : vas %se la cella era occupara solo dalla soi della stazione che sto eliminando 
        matrSOItemp(objSOI{len2}{1}(i,1),objSOI{len2}{1}(i,2)) = matrSOItemp(objSOI{len2}{1}(i,1),objSOI{len2}{1}(i,2))-1;
        if matrSOItemp(objSOI{len2}{1}(i,1),objSOI{len2}{1}(i,2))==0;
        	diffCelle = diffCelle + 1;
        end    
    end
    percentCoperturaLibera = diffCelle / (rig*col) * 100; %percentuale coperta libera dalla stazione presa in considerazione
    if percentCoperturaLibera > areaAddiz
        cont = cont + 1;
        stazioniSelezionate{cont}{1}=objSOI{len2}{1}(1,:); %coordinate della stazione selezionata
        stazioniSelezionate{cont}{2}=objSOI{len2}{1}; %coordinate della copertura (compresa la stazione)
        stazioniSelezionate{cont}{3}=objSOI{len2}{2}; %tipo di stazione
    else %tolgo dalla soi totale le celle appartenenti alla stazione che ho
        %eliminato, ma solo quelle in surplus
        [vas,waste]=size(objSOI{len2}{1});
        for i = 1 : vas
            matrSOI(objSOI{len2}{1}(i,1),objSOI{len2}{1}(i,2))=matrSOI(objSOI{len2}{1}(i,1),objSOI{len2}{1}(i,2))-1;
        end
        for i = 1 : vas %se la cella era occupara solo dalla soi della stazione che sto eliminando..
            if matrSOI(objSOI{len2}{1}(i,1),objSOI{len2}{1}(i,2))==0;
                [vat,waste]=size(totSOI);
                row2Delete = 0;
                for w = 1 : vat %..cerco quelle coordinate in tot soi e le eliminiamo
                    %[objSOI{len2}{1}(i,1),objSOI{len2}{1}(i,2)]
                    %totSOI
                   if totSOI(w,1) == objSOI{len2}{1}(i,1) && totSOI(w,2) == objSOI{len2}{1}(i,2)
                      row2Delete = w;
                   end
                end
            totSOI(row2Delete,:) = [];
            end    
        end
    end
    len2=len2-1;
end

%inverto le stazioni selezionate, perchè sono partito dal fondo a
%memorizzarle quindi sono al contrario
stazioniSelezionate = fliplr(stazioniSelezionate);

%se le stazioni selezionate superano il limite imposto, produco risultati
%solo fino al limite, ponendo cont = limiteStazioni
if length(stazioniSelezionate) >= limiteStazioni
    cont = limiteStazioni;
end    

for x = 1 : cont %ciclo al contrario perchï¿½ le ho memorizzate dall'ultima alla prima
    [c,waste]=size(stazioniSelezionate{x}{2});
    for i = 1 : c
        if ~(ismember([stazioniSelezionate{x}{2}(i,1),stazioniSelezionate{x}{2}(i,2)],coperturaTot, 'rows'))
        	coperturaTot = [coperturaTot;stazioniSelezionate{x}{2}(i,:)];
        end
    end
end

dati = [];
tipo = {}; %usato quando scrivo su file
[t,waste]=size(coperturaTot);
percentCoperturaTot = t / (rig*col) * 100;
for x = 1 : cont %ciclo al contrario perchï¿½ le ho memorizzate dall'ultima alla prima
    [c,waste]=size(stazioniSelezionate{x}{2});
    percentCopertura = c/t*100; %la perc coperta da una stazione 
    stazioniSelezionate{x}{4}=percentCopertura; %percentuale cumulata della copertura totale
    if x ~= 1
        dati = [dati;stazioniSelezionate{x}{1}(1,1),stazioniSelezionate{x}{1}(1,2),stazioniSelezionate{x}{3},...
           FOM(stazioniSelezionate{x}{1}(1,1),stazioniSelezionate{x}{1}(1,2)),percentCopertura,{''}];
    else
        dati = [dati;stazioniSelezionate{x}{1}(1,1),stazioniSelezionate{x}{1}(1,2),stazioniSelezionate{x}{3},...
           FOM(stazioniSelezionate{x}{1}(1,1),stazioniSelezionate{x}{1}(1,2)),percentCopertura,{percentCoperturaTot}];
    end

    set(handles.tableOutput, 'Data',dati); %aggiungo nella table i dati
    refresh(monet2);
    %disegno la singola stazione con la propria soi
    figure(x)
    for r = 1:rig %disegno la griglia
        for c = 1:col
            rectangle('Position',[c,r,1,1],'FaceColor','w');
            hold on;
        end
    end
    %disegno la SOI
    [ss,waste]=size(stazioniSelezionate{x}{2});
    for m = 1 : ss
        rectangle('Position',[stazioniSelezionate{x}{2}(m,2),stazioniSelezionate{x}{2}(m,1),1,1],'FaceColor','b');
        hold on;
    end
    %disegno la stazione candidata
    rectangle('Position',[stazioniSelezionate{x}{1}(2),stazioniSelezionate{x}{1}(1),1,1],'FaceColor','r');
    hold on;
    set(gca,'YDir','reverse','DataAspectRatio',[1 1 1],'DataAspectRatioMode',...
        'manual','XAxisLocation','top','XTick',[1:col]','YTick',[1:rig]');
    axis([1,col+1,1,rig+1]);
    if stazioniSelezionate{x}{3}==1
        set(gcf,'Name',strcat('Copertura areale del picco numero',num2str(x)));
        title(strcat('Copertura areale del picco numero',num2str(x)));
        tipo{x} = 'picco';
    else
        set(gcf,'Name',strcat('Copertura areale della valle numero',num2str(x)));
        title(strcat('Copertura areale della valle numero',num2str(x)));
        tipo{x} = 'Valle';
    end
    %scrivo su file i dati della stazione selezionata
    if get(handles.checkBoxOutput, 'Value') == 1   
        fprintf(fid1,strcat('-Stazione numero',num2str(x),':',tipo{x},'\n'));
        [ss,waste]=size(stazioniSelezionate{x}{2});
        for m = 1 : ss
            
            fprintf(fid1,strcat('(',num2str(stazioniSelezionate{x}{2}(m,1)),',',num2str(stazioniSelezionate{x}{2}(m,2)),')'));
        end
        fprintf(fid1,'\n\n');
        for r = 1:rig
            fprintf(fid1,'|');
            for c = 1:col
                if r == stazioniSelezionate{x}{2}(1,1) && c == stazioniSelezionate{x}{2}(1,2)
                    fprintf(fid1,'O');
                elseif (ismember([r,c],stazioniSelezionate{x}{2}, 'rows'))
                    fprintf(fid1,'#');
                else
                    fprintf(fid1,'-');            
                end
            end   
            fprintf(fid1,'|\n');  
        end
        fprintf(fid1,'\n\n');
        
        %salvo l'immagine nell'output
        saveas(gcf,strcat('output/',name,'/',name,'_copertura',num2str(x),'.jpg'));
    end
    
end

%disegno tutte le stazioni e la copertura totale
figure(cont+1)
%disegno la griglia
for r = 1:rig 
    for c = 1:col
        rectangle('Position',[c,r,1,1],'FaceColor','w');
        hold on;
    end
end
%disegno le coperture totali
for d = 1:length(coperturaTot) 
    rectangle('Position',[coperturaTot(d,2),coperturaTot(d,1),1,1],'FaceColor','b');
    hold on;
end
%disegno le stazioni selezionate
for r = 1:cont 
    rectangle('Position',[stazioniSelezionate{r}{1}(1,2),stazioniSelezionate{r}{1}(1,1),1,1],'FaceColor','r');
    hold on;
end
set(gca,'YDir','reverse','DataAspectRatio',[1 1 1],'DataAspectRatioMode',...
    'manual','XAxisLocation','top','XTick',[1:col]','YTick',[1:rig]');
set(gcf,'Name','Copertura areale delle stazioni che soddisfano il vincolo');
axis([1,col+1,1,rig+1]);
title('Copertura areale delle stazioni che soddisfano il vincolo');

%produco il file di output in formato txt se il checkbox ï¿½ selezionato
if get(handles.checkBoxOutput, 'Value') == 1   
    fprintf(fid1,'-Mappa complessiva delle stazioni selezionate e delle relative SOI\n');
    [w,waste]=size(coperturaTot);
    for u = 1:w
        fprintf(fid1,strcat('(',num2str(coperturaTot(u,1)),',',num2str(coperturaTot(u,2)),')'));
    end
    fprintf(fid1,'\n\nX,Y,Tipo,FOM,Copertura stazione %%:\n\n');    
    fprintf(fid2,'X,Y,Tipo,FOM,Copertura stazione %%:'); 
    stazioni = [];
    for rrr = 1 : cont
        fprintf(fid1,strcat(num2str(stazioniSelezionate{rrr}{1}(1,1)),',', num2str(stazioniSelezionate{rrr}{1}(1,2)),...
        ',',tipo{rrr},',',num2str(FOM(stazioniSelezionate{rrr}{1}(1,1),stazioniSelezionate{rrr}{1}(1,2))),...
        ',',num2str(stazioniSelezionate{rrr}{4}),'\n'));
        fprintf(fid2,strcat('\n',num2str(stazioniSelezionate{rrr}{1}(1,1)),',', num2str(stazioniSelezionate{rrr}{1}(1,2)),...
        ',',tipo{rrr},',',num2str(FOM(stazioniSelezionate{rrr}{1}(1,1),stazioniSelezionate{rrr}{1}(1,2))),...
        ',',num2str(stazioniSelezionate{rrr}{4})));
        stazioni = [stazioni;stazioniSelezionate{rrr}{1}];
    end
    fprintf(fid1,strcat('\nCopertura totale della rete %%:',num2str(percentCoperturaTot),'\n\n'));
    fprintf(fid2,strcat('\nCopertura totale della rete %%:',num2str(percentCoperturaTot)));
    for r = 1:rig
        fprintf(fid1,'|');
        for c = 1:col
            if (ismember([r,c],stazioni, 'rows'))
               fprintf(fid1,'O');
           elseif (ismember([r,c],coperturaTot, 'rows'))
                fprintf(fid1,'#');
            else
                fprintf(fid1,'-');            
            end
        end   
        fprintf(fid1,'|\n');  
    end
    saveas(gcf,strcat('output/',name,'/',name,'_StazTot.jpg')); %salvo l'immagine nell'output
    set(handles.textInProgress, 'String',strcat('Dati salvati nella cartella /output/',name));
    t = toc;
    fprintf(fid1,strcat('\n\n\nElaborazione effettuata in _',num2str(t),'_ secondi'));
    fclose(fid1); %chiudo lo streaming associato al file    
    fclose(fid2);
    set(handles.textInProgress, 'String',strcat('Dati salvati nella cartella /output/',name));
end

end
