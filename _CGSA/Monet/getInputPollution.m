%acquisice in ingresso il file relativo alle concentrazioni di inquinante
function [] = getInputPollution(handles)

global allScenari;
global freqAccad;

[FileName,PathName] = uigetfile('input/*.*','Seleziona il file degli inquinanti');
set(handles.textErroreInput, 'Visible', 'off') %nascondo l'eventuale mex d'errore rimasto
%evita che venga cliccato più volte il bottone della simulazione quando
%carico l'input
set(handles.buttonSimulazione, 'Visible', 'off') 
set(handles.textInProgress, 'String', 'Caricamento file di input degli scenari in corso ...')
set(handles.textInProgress, 'Visible', 'on') %mostro il feedback utente
refresh(monet2)

if (FileName) %se ho recuperato il file:
    %la prima riga del file .sm contiene il numero degli scenari, il numero
    %di ordinate ed il numero di ascisse
    fid = fopen(strcat(PathName,FileName),'rt'); %apro il file in lettura
    position=0;
    while (strmatch('#', fgetl(fid))) %finchè le prime righe del file iniziano con #
        position = ftell(fid); %le ignoro e salvo la posizione (riga successiva)
    end
    fseek(fid,position,'bof'); %riposiziono il file appena dopo l'ultima riga che comincia con #
    firstLine = fgetl(fid);
    remain = firstLine;
    [nScenari, remain] = strtok(remain);
    nScenari = eval(nScenari);
    [nOrdinate, remain] = strtok(remain);
    nOrdinate = eval(nOrdinate);
    nAscisse = strtok(remain);
    nAscisse = eval(nAscisse);
    freqAccad = [];

    allScenari={}; %contiene tutti gli scenari (matrice Y-X) indicizzandoli
    %da 1 al numero di scenari complessivo
    for s = 1 : nScenari %scorro tutti gli scenari
        scenario=[]; %matrice che rappresenta uno scenario
        for c = 1 : nOrdinate %scorro le righe (y) dello scenario
              riga=[];
              remain = '';
              remain = fgetl(fid); %estraiamo la riga
              for r = 1 : nAscisse %estraggo la colonna (x) dello scenario
                [token, remain] = strtok(remain);
                token=eval(token);
                riga=[riga,token];
              end
              scenario=[scenario;riga]; %aggiungo una riga alla metrice scenario
        end
        freqAccad(end+1) = eval(fgetl(fid)); %eliminiamo la riga che separa gli scenari
        allScenari{s}=scenario;
    end
    fclose(fid); %chiudo lo streaming associato al file
    
    set(handles.editFileInput, 'String', FileName);
end

set(handles.textInProgress, 'Visible', 'off'); %nascondo il feedback utente
set(handles.buttonSimulazione, 'Visible', 'on') 
%refresh(monet2)
