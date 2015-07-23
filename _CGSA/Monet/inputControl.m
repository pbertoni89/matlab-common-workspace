%effettua i controlli sui dati in ingresso e restituisce un booleano (true
%se i controlli sono andati a buon fine). Inoltre restituisce i dati di
%ingresso eventualmente 'puliti dagli errori dell'utente'
function [ check,valoreSoglia,limiteStazioni,minVarS,errOss,areaAddiz,minEffStaz] = inputControl( handles )

check = false;
valoreSoglia = '';
limiteStazioni = '';
minVarS = '';
errOss = '';
areaAddiz = '';
minEffStaz = '';
tmpStazioni = get(handles.editStazioni,'String');
tmpStazioni = regexp(tmpStazioni,'[0-9][0-9]*','match'); %estraggo solo interi
if length(tmpStazioni) ~= 0
    %concateno i valori risultanti dall'espressione regolare
    for i=1:length(tmpStazioni)
        limiteStazioni=strcat(limiteStazioni,tmpStazioni{i});
    end
    limiteStazioni = eval(limiteStazioni);
    if (limiteStazioni == 0) %il limite delle stazioni non può essere 0
        return
    end
    %se non ho acquisito il file degli scenari non posso procedere
    if (length(get(handles.editFileInput, 'String')) == 0)
        return
    end
else
    return
end

value = get(handles.listboxAlgoritmi,'Value'); %tipo di algoritmo

if value == 1 %Noll
    tmpSoglia = get(handles.editSoglia,'String'); %ricavo il valore dalla casella
    tmpSoglia = regexp(tmpSoglia,'[0-9]?[\.[0-9][0-9]*]|[0-9]?[\,[0-9][0-9]*]','match'); %estraggo solo i
    %numeri, eventualmente con la virgola
    tmpSoglia = strrep(tmpSoglia, ',', '.'); %sostituiamo l'eventuale "," con "."
    if length(tmpSoglia) ~= 0
        %concateno i valori risultanti dall'espressione regolare
        for i=1:length(tmpSoglia) 
            valoreSoglia=strcat(valoreSoglia,tmpSoglia{i});
        end
        valoreSoglia = eval(valoreSoglia); %trasformo in valore numerico
        check = true;
    else
        return
    end
   
    tmpminEffStaz = get(handles.editMinEffStaz,'String');
    tmpminEffStaz = regexp(tmpminEffStaz,'[0-9]?[\.[0-9][0-9]*]|[0-9]?[\,[0-9][0-9]*]','match'); %estraggo solo i
    %numeri, eventualmente con la virgola
    tmpminEffStaz = strrep(tmpminEffStaz, ',', '.'); %sostituiamo l'eventuale "," con "."
    if length(tmpminEffStaz) ~= 0
        %concateno i valori risultanti dall'espressione regolare
        for i=1:length(tmpminEffStaz) 
            minEffStaz=strcat(minEffStaz,tmpminEffStaz{i});
        end
        minEffStaz = eval(minEffStaz); %trasformo in valore numerico
        check = true;
    else
        check = false;
        return
    end
    
end

if value == 2 %Langstaff
    
    %la distribuzione della popolazione è opzionale
    tmpMinVarS = get(handles.editVarianza,'String');
    tmpMinVarS = regexp(tmpMinVarS,'[0-9]?[\.[0-9][0-9]*]|[0-9]?[\,[0-9][0-9]*]','match'); %estraggo solo i
    %numeri, eventualmente con la virgola
    tmpMinVarS = strrep(tmpMinVarS, ',', '.'); %sostituiamo l'eventuale "," con "."
    if length(tmpMinVarS) ~= 0
        %concateno i valori risultanti dall'espressione regolare
        for i=1:length(tmpMinVarS) 
            minVarS=strcat(minVarS,tmpMinVarS{i});
        end
        minVarS = eval(minVarS); %trasformo in valore numerico
        check = true;
    else
        check = false;
        return
    end
    
    tmpErrOss = get(handles.editOsservazione,'String');
    tmpErrOss = regexp(tmpErrOss,'[0-9]?[\.[0-9][0-9]*]|[0-9]?[\,[0-9][0-9]*]','match'); %estraggo solo i
    %numeri, eventualmente con la virgola
    tmpErrOss = strrep(tmpErrOss, ',', '.'); %sostituiamo l'eventuale "," con "."
    if length(tmpErrOss) ~= 0
        %concateno i valori risultanti dall'espressione regolare
        for i=1:length(tmpErrOss) 
            errOss=strcat(errOss,tmpErrOss{i});
        end
        errOss = eval(errOss); %trasformo in valore numerico
        check = true;
    else
        check = false;
        return
    end
    
	tmpAreaAddiz = get(handles.editAddizionale,'String');
    tmpAreaAddiz = regexp(tmpAreaAddiz,'[0-9]?[\.[0-9][0-9]*]|[0-9]?[\,[0-9][0-9]*]','match'); %estraggo solo i
    %numeri, eventualmente con la virgola
    tmpAreaAddiz = strrep(tmpAreaAddiz, ',', '.'); %sostituiamo l'eventuale "," con "."
    if length(tmpAreaAddiz) ~= 0
        %concateno i valori risultanti dall'espressione regolare
        for i=1:length(tmpAreaAddiz) 
            areaAddiz=strcat(areaAddiz,tmpAreaAddiz{i});
        end
        areaAddiz = eval(areaAddiz); %trasformo in valore numerico
        check = true;
    else
        check = false;
        return
    end
   
   
end
    
end

