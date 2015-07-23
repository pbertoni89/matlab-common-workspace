%acquisice il file relativo alla concentrazione della popolazione
function [] = getInputPopulation(handles)

global popolazione;
[FileName,PathName] = uigetfile('input/*.*','Seleziona il file delle popolazioni');
set(handles.textErroreInput, 'Visible', 'off') %nascondo l'eventuale mex d'errore rimasto
%evita che venga cliccato più volte il bottone della simulazione quando
%carico l'input
set(handles.buttonSimulazione, 'Visible', 'off') 
set(handles.textInProgress, 'String', 'Caricamento file di input delle popolazioni in corso ...')
set(handles.textInProgress, 'Visible', 'on') %mostro il feedback utente
refresh(monet2)

if (FileName) %se ho recuperato il file:
    fid = fopen(strcat(PathName,FileName),'rt'); %apro il file in lettura
    position=0;
    while (strmatch('#', fgetl(fid))) %finchè le prime righe del file iniziano con #
        position = ftell(fid); %le ignoro e salvo la posizione (riga successiva)
    end
    fseek(fid,position,'bof'); %riposiziono il file appena dopo l'ultima riga che comincia con #
    popolazione=[]; %contiene tutti gli scenari (matrice Y-X) indicizzandoli
    %da 1 al numero di scenari complessivo
    while(~feof(fid)) %scorro le righe (y) dello scenario
          riga=[];
          remain = '';
          remain = fgetl(fid); %estraiamo la riga
          while(length(remain) ~= 0) %estraggo la colonna (x) della popolazione
            [token, remain] = strtok(remain);
            token=eval(token);
            riga=[riga,token];
          end
          popolazione=[popolazione;riga]; %aggiungo una riga alla metrice scenario
    end

    fclose(fid); %chiudo lo streaming associato al file
    
    set(handles.editPopolazione, 'String', FileName);
end
set(handles.textInProgress, 'Visible', 'off'); %nascondo il feedback utente
set(handles.buttonSimulazione, 'Visible', 'on') 
