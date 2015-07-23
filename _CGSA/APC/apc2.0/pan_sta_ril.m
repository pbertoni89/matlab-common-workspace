%%% Inizializzo il pannello delle stazioni di rilevamento    
function h = pan_sta_ril(hObject, eventdata, k)
    global amb;


    %%% Pannello per le stazioni di rilevamento
    h.pan_sta_ril = uipanel('BorderType','etchedin',...
            'Title','STAZIONI DI RILEVAMENTO',...
            'Units','pixels',...
            'Parent',k.fin_princ,... 
            'Position',[3.15*costanti.dim_fin 1.1*costanti.dim_fin 1.5*costanti.dim_fin costanti.dim_fin]);

        %%% Bottone per aggiungere una stazione di rilevamento
        h.but_agg_sta_ril = uicontrol('style','pushbutton','Parent',h.pan_sta_ril,...
            'position', [10 costanti.dim_fin-0.3*costanti.dim_fin 0.4*costanti.dim_fin 0.175*costanti.dim_fin],...
            'string','Aggiungi');

        %%% Bottone per rimuovere una stazione di rilevamento
        h.but_rim_sta_ril = uicontrol('style','pushbutton','Parent',h.pan_sta_ril,...
            'position', [1.1*costanti.dim_fin-10 costanti.dim_fin-0.3*costanti.dim_fin 0.4*costanti.dim_fin 0.175*costanti.dim_fin],...
            'string','Rimuovi');
%         if isempty(stazioni)
%             set(h.but_rim_sta_ril,'enable','off');
%         end

        %%% Bottone per modificare un camino
        h.but_mod_sta_ril = uicontrol('style','pushbutton','Parent',h.pan_sta_ril,...
            'position', [0.5*costanti.dim_fin+10 costanti.dim_fin-0.3*costanti.dim_fin 0.4*costanti.dim_fin 0.175*costanti.dim_fin],...
            'string','Modifica');
%         if isempty(stazioni)
%             set(h.but_mod_sta_ril,'enable','off');
%         end

        %%% Lista di visualizzazione delle stazioni di rilevamento
        h.list_sta_ril = uicontrol('style','listbox','Parent',h.pan_sta_ril,...
            'position', [0.3*costanti.dim_fin 0.3*costanti.dim_fin 0.9*costanti.dim_fin 0.3*costanti.dim_fin],'max',1);

        %%% Coordinata X della stazione di rilevamento selezionata nella listbox
        h.text_sta_ril_X = uicontrol('style','text','Parent',h.pan_sta_ril,...
            'Units','pixels',...
            'Position', [10 0.075*costanti.dim_fin 0.2*costanti.dim_fin 0.4*costanti.alt_fin*costanti.dim_fin],...
            'string','X =');

        h.edit_sta_ril_X = uicontrol('style','edit','Parent',h.pan_sta_ril,...
            'Units','pixels',...
            'enable','inactive',...
            'Position', [0.25*costanti.dim_fin 10 0.4*costanti.dim_fin 0.65*costanti.alt_fin*costanti.dim_fin]); 

        %%% Coordinata Y del camino selezionato nella listbox
        h.text_sta_ril_Y = uicontrol('style','text','Parent',h.pan_sta_ril,...
            'Units','pixels',...
            'Position', [0.7*costanti.dim_fin 0.075*costanti.dim_fin 0.2*costanti.dim_fin 0.4*costanti.alt_fin*costanti.dim_fin],...
            'string','Y =');

        h.edit_sta_ril_Y = uicontrol('style','edit','Parent',h.pan_sta_ril,...
            'Units','pixels',...
            'enable','inactive',...
            'Position', [0.9*costanti.dim_fin 10 0.4*costanti.dim_fin 0.65*costanti.alt_fin*costanti.dim_fin]); 

%         %%% Toggle button per abilitare il camino selezionato
%         h.but_sta_ril_enable = uicontrol('style','togglebutton','Parent',h.pan_sta_ril,...
%             'Units','pixels',...
%             'enable','off',...
%             'Position', [1.1*costanti.dim_fin-10 0.45*costanti.dim_fin 0.4*costanti.dim_fin 0.15*costanti.dim_fin],...
%             'string','Abilita');
% 
%         %%% Toggle button per abilitare il camino selezionato
%         h.but_sta_ril_disable = uicontrol('style','togglebutton','Parent',h.pan_sta_ril,...
%             'Units','pixels',...
%             'enable','off',...
%             'Position', [1.1*costanti.dim_fin-10 0.3*costanti.dim_fin 0.4*costanti.dim_fin 0.15*costanti.dim_fin],...
%             'string','Disabilita');

        set(h.but_agg_sta_ril, 'callback', {@pannello_aggmod_stazione, h, 1});
        set(h.but_mod_sta_ril, 'callback', {@pannello_aggmod_stazione, h, 0});
        set(h.but_rim_sta_ril, 'callback', {@rimuovi_stazione, h});    
%         set(h.but_sta_ril_enable, 'callback', {@enable_sta, h});
%         set(h.but_sta_ril_disable, 'callback', {@disable_sta, h});    
        set(h.list_sta_ril, 'callback', {@aggiorna_visualizzazione_mappa, h});    

%             %%% Abilito la stazione di rilevamento
%             function enable_sta(hObject,eventdata,k)
%                 i=get(h.list_sta_ril,'value');
%                 list=amb.list_city();
%                 amb=amb.set_city_op(list(i), 1);               
%                 aggiorna_visualizzazione_mappa(hObject, eventdata, h);
%             end
% 
%             %%% Disabilito la stazione di rilevamento
%             function disable_sta(hObject,eventdata,k)
%                 i=get(h.list_sta_ril,'value');
%                 list=amb.list_city();
%                 amb=amb.set_city_op(list(i), 0);               
%                 aggiorna_visualizzazione_mappa(hObject, eventdata, h);
%             end

            %%% Rimuovo la stazione di rilevamento
            function rimuovi_stazione(hObject, eventdata, k)
                i=get(h.list_sta_ril,'value');
                list=amb.list_city();
                amb=amb.del_city(list(i));
                aggiorna_pannello_stazione(hObject, eventdata, h);
            end
        
        aggiorna_pannello_stazione(hObject, eventdata, h);
end


%%% Gestione finestra per l'inserimento di una stazione di rilevamento
function h = pannello_aggmod_stazione(hObject, eventdata, k, operation)
global amb;

stazione_temp=[];
check_array = ones(1,2);
list = amb.list_city();
id = 0;

if operation==1
    %%% stazione_temp=[x, y]
    stazione_temp=[amb.get_map_dim_x/2, amb.get_map_dim_x/2];
else
    index = get(k.list_sta_ril,'value');
    id = list(index);
    stazione_temp = amb.get_city(id);
end

h.fin_sta = figure('Name','Aggiungi stazione','Units','pixels','position',...
    [3.3*costanti.dim_fin 2.5*costanti.dim_fin 1.5*costanti.dim_fin 0.8*costanti.dim_fin],'MenuBar','none');

%%% Pannello per la gestione dei dati della stazione di rilevamento
h.pan_dati_sta = uipanel('BorderType','etchedin',...
        'Title','DATI STAZIONE RILEVAMENTO',...
		'Units','pixels',...
		'Parent',h.fin_sta,... 
        'Position',[0 0 1.5*costanti.dim_fin 0.8*costanti.dim_fin]);
    
    %%% Coordinata X della stazione di rilevamento selezionata nella listbox
    h.text_sta_ril_X = uicontrol('style','text','Parent',h.pan_dati_sta,...
        'Units','pixels',...
        'Position', [10 0.45*costanti.dim_fin 0.2*costanti.dim_fin 0.4*costanti.alt_fin*costanti.dim_fin],...
        'string','X =');
    
    h.edit_sta_ril_X = uicontrol('style','edit','Parent',h.pan_dati_sta,...
        'Units','pixels',...
        'string',stazione_temp(1),...
        'Position', [0.25*costanti.dim_fin 0.5*costanti.dim_fin-0.3*costanti.alt_fin*costanti.dim_fin 0.4*costanti.dim_fin 0.65*costanti.alt_fin*costanti.dim_fin]);    
    
    %%% Coordinata Y della stazione di rilevamento selezionata nella
    %%% listbox
    h.text_sta_ril_Y = uicontrol('style','text','Parent',h.pan_dati_sta,...
        'Units','pixels',...
        'Position', [0.7*costanti.dim_fin 0.45*costanti.dim_fin 0.2*costanti.dim_fin 0.4*costanti.alt_fin*costanti.dim_fin],...
        'string','Y =');
    
    h.edit_sta_ril_Y = uicontrol('style','edit','Parent',h.pan_dati_sta,...
        'Units','pixels',...
        'string',stazione_temp(2),...
        'Position', [0.9*costanti.dim_fin 0.5*costanti.dim_fin-0.3*costanti.alt_fin*costanti.dim_fin 0.4*costanti.dim_fin 0.65*costanti.alt_fin*costanti.dim_fin]);    
    
    %%% Gestione bottone OK
    h.but_ok_sta = uicontrol('style','pushbutton','Parent',h.pan_dati_sta,...
        'Units','pixels',...
        'string','OK',...
        'Position',  [0.35*costanti.dim_fin 2*costanti.dim_fin-9.5*costanti.alt_fin*costanti.dim_fin 0.8*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin]);   
    
    set(h.edit_sta_ril_X, 'callback', {@set_sta_X});
    set(h.edit_sta_ril_Y, 'callback', {@set_sta_Y});
    set(h.but_ok_sta, 'callback', {@aggiungi_stazione, k});
    
        %%% Controllo e set della coordinata x della stazione di rilevamento    
        function set_sta_X(hObject, eventdata)
            coord_x=str2num(get(h.edit_sta_ril_X,'string'));

            if (coord_x >= 0) & (coord_x <= amb.get_map_dim_x())
                stazione_temp(1)=coord_x;
                set(h.edit_sta_ril_X,'ForegroundColor','black');
                check_array(1)=1;
            else
                set(h.edit_sta_ril_X,'ForegroundColor','red');
                check_array(1)=0;
            end
            
            abilita_button_ok();
        end
    
        %%% Controllo e set della coordinata y della stazione di rilevamento
        function set_sta_Y(hObject, eventdata)
            coord_y=str2num(get(h.edit_sta_ril_Y,'string'));

            if (coord_y >= 0) & (coord_y <= amb.get_map_dim_y())
                stazione_temp(2)=coord_y;
                set(h.edit_sta_ril_Y,'ForegroundColor','black');
                check_array(2)=1;
            else
                set(h.edit_sta_ril_Y,'ForegroundColor','red');
                check_array(2)=0;
            end   
            
            abilita_button_ok();
        end  
    
        %%% abilito/disabilito il bottone OK nel pannello di inserimento dei
        %%% dati della stazione di rilevamento, controllo che tutti i valori sia consistenti
        function abilita_button_ok()
            if all(check_array)
                set(h.but_ok_sta,'enable','on');
            else
                set(h.but_ok_sta,'enable','off');
            end
        end
    
    
        %%% Controlla che tutti i dati inseriti nel pannello "aggiungi stazione"
        %%% siano corretti e set del camino
        function aggiungi_stazione(hObject, eventdata, k) 
            if operation==1
                amb=amb.new_city(stazione_temp);
                close;
                aggiorna_pannello_stazione(hObject, eventdata, k);
            else
                amb=amb.set_city(id, stazione_temp);
                close;
                aggiorna_visualizzazione_mappa(hObject, eventdata, k);
            end                              
        end      

end %%% end function pannello_aggmod_stazione
 

%%% Aggiorna la visualizzazione dei dati della stazione nel pannello     
%%% della finestra principale
function aggiorna_pannello_stazione(hObject, eventdata, k)
    global amb;
    
    stazioni = amb.list_city();    

    if isempty(stazioni)                
        set(k.but_rim_sta_ril,'enable','off');
        set(k.but_mod_sta_ril,'enable','off');
%         set(k.but_sta_ril_enable,'backgroundcolor','default','value',0,'enable','off');
%         set(k.but_sta_ril_disable,'backgroundcolor','default','value',0,'enable','off');
        set(k.edit_sta_ril_X,'string','');
        set(k.edit_sta_ril_Y,'string','');
        set(k.list_sta_ril,'string','');
    else
        set(k.but_rim_sta_ril,'enable','on');
        set(k.but_mod_sta_ril,'enable','on');        
%         set(k.but_sta_ril_enable,'enable','on');
%         set(k.but_sta_ril_disable,'enable','on');                  
        
        tot_stringa='';
    
        for i=1:length(stazioni)
            stringa=horzcat('stazione    ',int2str(stazioni(i)));        
            tot_stringa=strvcat(tot_stringa,stringa);          
        end
        set(k.list_sta_ril,'string',cellstr(tot_stringa));
        set(k.list_sta_ril,'value',length(stazioni));
        
        aggiorna_visualizzazione_mappa(hObject, eventdata, k);
    end       
end    
    
 
%%% Aggiorna la visualizzazione dei dati della stazione nel pannello della
%%% finestra principale
function aggiorna_visualizzazione_mappa(hObject, eventdata, k)
global amb;
    
    stazioni = amb.list_city();  
    
    if ~isempty(stazioni)
        index = get(k.list_sta_ril,'value');
        id = stazioni(index);
        
%         if amb.get_city_op(id) == 1
%             set(k.but_sta_ril_enable,'backgroundcolor','green','value',1);
%             set(k.but_sta_ril_disable,'backgroundcolor','default','value',0);
%         else
%             set(k.but_sta_ril_enable,'backgroundcolor','default','value',0);
%             set(k.but_sta_ril_disable,'backgroundcolor','red','value',1);
%         end

        sta_t = amb.get_city(id);
        set(k.edit_sta_ril_X,'string',sta_t(1));
        set(k.edit_sta_ril_Y,'string',sta_t(2));
    
        pan_plot(hObject, eventdata, k, -1, index);
    end
        
end