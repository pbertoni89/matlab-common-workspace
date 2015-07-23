%gestisce le chiamate al controllo di errori nell'input e agli algoritmi
function [ ] = gestoreSimulazione( handles )

[check,valoreSoglia,limiteStazioni,minVarS,errOss,areaAddiz,minEffStaz] = inputControl(handles);

if (check)
    set(handles.editSoglia, 'String',valoreSoglia);
    set(handles.editStazioni, 'String',limiteStazioni);
    set(handles.editVarianza, 'String',minVarS);
    set(handles.editOsservazione, 'String',errOss);
    set(handles.editAddizionale, 'String',areaAddiz);
    set(handles.editMinEffStaz, 'String',minEffStaz);
    set(handles.textErroreInput, 'Visible','off');
    set(handles.buttonSimulazione, 'Visible','off');
    %elimino le eventuali precedenti figure rimaste aperte
    get(0,'CurrentFigure');
    fh = findobj(0,'type','figure');
    [a,b]=size(fh);
    for b = 1 : a
        if fh(b) ~= handles.figureMonet2
            close(fh(b))
        end
    end    
    refresh(monet2); %apporta subito i cambiamenti grafici, per evitare che
    %l'implementazione pesante dell'algoritmo li rimandi
    switch get(handles.listboxAlgoritmi, 'Value');
        case 1 %richiamo l'algoritmo di Noll-Mitzumi
            algNoll(valoreSoglia,limiteStazioni,minEffStaz,handles);
        
        case 2 %richiamo l'algoritmo di Langstaff
            algLangstaff(limiteStazioni,minVarS,errOss,areaAddiz,handles);
        
        otherwise
            disp('errore interno nella selezione dell''algoritmo');
    end
    set(handles.buttonSimulazione, 'Visible','on');
    if get(handles.checkBoxOutput, 'Value') == 0
        set(handles.textInProgress, 'Visible','off');
    end
else
    set(handles.textErroreInput, 'Visible','on');
end
