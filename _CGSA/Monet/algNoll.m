%implementazione dell'algoritmo di Noll
function [ ] = algNoll( valoreSoglia,limiteStazioni,minEffStaz,handles )
global allScenari;
global freqAccad;

tic %ancora da cui parto a misurare il tempo di esecuzion (vedi toc dopo)
if get(handles.checkBoxOutput, 'Value') == 1   
    name = datestr(now,'Noll_dd-mm-yy_HH.MM.ss'); %nome della simulazione
    mkdir(datestr(now,strcat('output/',name))); %cartella che contiene la simulazione
    fid1 = fopen(strcat('output/',name,'/',name,'.txt'),'wt'); %apro il file di output per tutte le stazioni
    fid2 = fopen(strcat('output/',name,'/',name,'_result.txt'),'wt'); %apro il file di output che contiene i dati riassuntivi
    fprintf(fid1,strcat('File di input inquinamento:',get(handles.editFileInput,'String'),'\nValore di soglia dell''inquinante:',num2str(valoreSoglia),...
        '\nNumero massimo di stazioni:',num2str(limiteStazioni),'\n\nLegenda: O = stazione; # = cluster; vuoto = -\n\n'));
end    

[rig,col] = size(allScenari{1});
[waste,nScenari] = size(allScenari);
set(handles.textInProgress, 'Visible','on');
set(handles.textInProgress, 'String','Calcolo dei cluster in corso ...');
refresh(monet2);

efficienze=[];
effRete = 0;
allClusterScenari = {};
dosaggioTotale = 0;
set(handles.tableOutput, 'ColumnName',{'X','Y','efficienza stazione [%]','efficienza rete [%]'},'Data',[]);
refresh(monet2);

for s = 1:nScenari
    allCluster = {}; %contiene tutti i cluster dello scenario
    scenario=allScenari{s};
    for r = 1:rig
        for c = 1:col
            if (scenario(r,c) >= valoreSoglia)
                cluster = []; %matrice che contiene le coordinate del cluster
                clusterSoglia = []; %vettore che contiene i valori di inquinanti per quella stazione
                [cluster,scenario,clusterSoglia] = cercaCluster(scenario,r,c,cluster,valoreSoglia,clusterSoglia);
                [dimCluster,c]=size(cluster);
                dosaggioAreale = 0;
                
                for k=1:dimCluster
                    dosaggioAreale = dosaggioAreale + clusterSoglia(k,1)*freqAccad(s); 
                end
                
                allCluster{end+1} = {cluster,clusterSoglia,dimCluster,dosaggioAreale};
                %calcolo del dosaggio areale totale ! rimane sempre quello
                %per il calcolo di tutte le stazioni
                dosaggioTotale = dosaggioTotale + dosaggioAreale;
            end
        end
    end
    allClusterScenari{end+1} = allCluster;
end

matriTot=[]; %matrice nx2 che contiene le coordinate dell'unione dei cluster
             %di tutte le stazioni selezionate
massimi=[];  %contiene le coordinate di tutte le stazioni selezionate           
for stazioneAttuale=1:limiteStazioni
    %feedback utente
    txt = strcat('Calcolo stazione di monitoraggio numero _',int2str(stazioneAttuale),'_ in corso ...');
    set(handles.textInProgress, 'String',txt);
    refresh(monet2);
    %calcolo il dosaggio di stazione
    dosaggioStaz=[]; %matrice che contiene il dosaggio di stazione
    matriStaz=[];%matrice nx2 che contiene le coordinate dell'unione dei cluster
    matEffic=[];
    for r = 1:rig
        for c = 1:col
            dosaggioStaz(r,c) = 0;
            for s = 1:nScenari
                [waste,nclustperscen] = size(allClusterScenari{s});
                for k = 1:nclustperscen
                    if (ismember([r,c],allClusterScenari{s}{k}{1}, 'rows'))
                        dosaggioStaz(r,c) = dosaggioStaz(r,c) + allClusterScenari{s}{k}{4};

                    end
                end
            end
        end
    end
    matEffic = dosaggioStaz/dosaggioTotale;
    %trovo le coordinate della stazione con efficienza maggiore
    [a b] = find(matEffic==max(matEffic(:)));
    massimo = [a b];
    
    %se l'efficienza � < della minima efficienza di stazione interrompo l'algoritmo
    if (matEffic(massimo(1),massimo(2))*100 >=minEffStaz)
        massimi=[massimi;massimo]; %vettore che contiene le coordinate di tutte le stazioni selezionate
        effRete = effRete + matEffic(massimo(1),massimo(2))*100; %efficienza delle stazioni che si accumula
        efficienze = [efficienze;massimo,matEffic(massimo(1),massimo(2))*100,effRete];
        %inserisco i risultati nel tab di output
        set(handles.tableOutput, 'Data',efficienze);
        refresh(monet2);
        %eliminiamo i cluster appartenenti alla stazione trovata, e salviamo l'UNIONE 
        %tutti i cluster che possiedono la stazione selezionata
        mergeCluster={};
        for s = 1:nScenari
                    [waste,nclustperscen] = size(allClusterScenari{s});
                    for k = 1:nclustperscen
                        if (ismember(massimo,allClusterScenari{s}{k}{1}, 'rows'))
                            mergeCluster{end+1}=allClusterScenari{s}{k}{1};
                            allClusterScenari{s}{k}{1} = [];

                        end
                    end
        end
        
        %salviamo le coordinate di tutte le celle che, in ogni scenario,
        %appartengono al cluster della cella con efficienza massima
        [waste,y]=size(mergeCluster);
        for m=1:y
            [u,waste]=size(mergeCluster{m});
            for p=1:u
                if ~(ismember(mergeCluster{m}(p,:),matriStaz, 'rows'))
                    matriStaz=[matriStaz;mergeCluster{m}(p,:)];
                    matriTot=[matriTot;mergeCluster{m}(p,:)];
                end
            end

        end
        
        %disegno l'unione di tutti i cluster della stazione selezionata    
        figure(stazioneAttuale)
        for r = 1:rig
            for c = 1:col
                if (ismember([r,c],matriStaz, 'rows'))
                    rectangle('Position',[c,r,1,1],'FaceColor','b');
                    hold on;
                else
                    rectangle('Position',[c,r,1,1],'FaceColor','w');
                    hold on;
                end
            end
        end
        rectangle('Position',[massimo(2),massimo(1),1,1],'FaceColor','r'); %stazione selezionata
        set(gca,'YDir','reverse','DataAspectRatio',[1 1 1],'DataAspectRatioMode','manual','XAxisLocation','top','XTick',[1:col]','YTick',[1:rig]');
        axis([1,col+1,1,rig+1]);
        str = strcat('Clusters stazione di monitoraggio numero ',int2str(stazioneAttuale));
        title(str)
        set(gcf,'Name',str);
        
        %scrivo su file i dati della stazione selezionata
        if get(handles.checkBoxOutput, 'Value') == 1   
            fprintf(fid1,strcat('-Stazione numero:',num2str(stazioneAttuale),'\n'));
            [w,waste]=size(matriStaz);
            for u = 1:w
                fprintf(fid1,strcat('(',num2str(matriStaz(u,1)),',',num2str(matriStaz(u,2)),')'));
            end
            fprintf(fid1,'\n\n');
            for r = 1:rig
                fprintf(fid1,'|');
                for c = 1:col
                    if r == massimo(1) && c == massimo(2)
                        fprintf(fid1,'O');
                    elseif (ismember([r,c],matriStaz, 'rows'))
                        fprintf(fid1,'#');
                    else
                        fprintf(fid1,'-');            
                    end
                end   
                fprintf(fid1,'|\n');  
            end
            fprintf(fid1,'\n\n');
            %salvo l'immagine nell'output
            saveas(gcf,strcat('output/',name,'/',name,'_stazione',int2str(stazioneAttuale),'.jpg'));
        end
    else
        stazioneAttuale = stazioneAttuale - 1; 
        break; 
    end
    
end

    %disegno tutti i cluster di tutte le stazioni
    set(handles.textInProgress, 'String','Calcolo del disegno di tutti i clusters di tutte le stazioni');
    refresh(monet2);
    figure(stazioneAttuale+1)
    for r = 1:rig
        for c = 1:col
            if (ismember([r,c],massimi, 'rows'))
                rectangle('Position',[c,r,1,1],'FaceColor','r'); %staz selezionate
                hold on;
                
            else if (ismember([r,c],matriTot, 'rows'))
                    rectangle('Position',[c,r,1,1],'FaceColor','b'); %unione dei cluster
                    hold on;
                else
                    rectangle('Position',[c,r,1,1],'FaceColor','w');
                    hold on;
                end
            end
        end             
    end
    set(gca,'YDir','reverse','DataAspectRatio',[1 1 1],'DataAspectRatioMode','manual','XAxisLocation','top','XTick',[1:col]','YTick',[1:rig]');
    set(gcf,'Name','Clusters totali delle stazioni di monitoraggio');
    axis([1,col+1,1,rig+1]);
    title('Clusters totali delle stazioni di monitoraggio') 

%produco il file di output in formato txt se il checkbox � selezionato
if get(handles.checkBoxOutput, 'Value') == 1   
    fprintf(fid1,'-Mappa complessiva delle stazioni e dei relativi cluster\n');
    [w,waste]=size(matriTot);
    for u = 1:w
        fprintf(fid1,strcat('(',num2str(matriTot(u,1)),',',num2str(matriTot(u,2)),')'));
    end
    fprintf(fid1,'\n\nX,Y,Efficienza stazione %%,Efficienza rete %%:'); 
    fprintf(fid2,'X,Y,Efficienza stazione %%,Efficienza rete %%:');        
    [rr,waste]=size(efficienze);
    for rrr = 1:rr
        fprintf(fid1,strcat('\n',num2str(efficienze(rrr,1)),',', num2str(efficienze(rrr,2)),',',num2str(efficienze(rrr,3)),',',num2str(efficienze(rrr,4))));
        fprintf(fid2,strcat('\n',num2str(efficienze(rrr,1)),',', num2str(efficienze(rrr,2)),',',num2str(efficienze(rrr,3)),',',num2str(efficienze(rrr,4))));
    end
    fprintf(fid1,'\n');
    for r = 1:rig
        fprintf(fid1,'|');
        for c = 1:col
            if (ismember([r,c],massimi, 'rows'))
                fprintf(fid1,'O');
            elseif (ismember([r,c],matriTot, 'rows'))
                fprintf(fid1,'#');
            else
                fprintf(fid1,'-');            
            end
        end   
        fprintf(fid1,'|\n');  
    end
    saveas(gcf,strcat('output/',name,'/',name,'_ClusTot.jpg'));
    
    t = toc; %finisco di misurare il tempo di esecuzione
    fprintf(fid1,strcat('\n\n\nElaborazione effettuata in _',num2str(t),'_ secondi')); 
    fclose(fid1); %chiudo lo streaming associato al file   
    fclose(fid2);
    set(handles.textInProgress, 'String',strcat('Dati salvati nella cartella /output/',name));
end

end
