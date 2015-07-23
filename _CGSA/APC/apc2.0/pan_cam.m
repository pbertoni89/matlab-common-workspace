%%% Inizializzo il pannello dei camini
function h = pan_cam(hObject, eventdata, k)
    global amb;


    %%% Pannello per la configurazione dei camini
    h.pan_cam = uipanel('BorderType','etchedin',...
            'Title','CAMINI',...
            'Units','pixels',...
            'Parent',k.fin_princ,... 
            'Position',[1.6*costanti.dim_fin 1.1*costanti.dim_fin 1.5*costanti.dim_fin 1*costanti.dim_fin]);

        %%% Bottone per aggiungere un camino
        h.but_agg_cam = uicontrol('style','pushbutton','Parent',h.pan_cam,...
            'position', [10 costanti.dim_fin-0.3*costanti.dim_fin 0.4*costanti.dim_fin 0.175*costanti.dim_fin],...
            'string','Aggiungi');

        %%% Bottone per rimuovere un camino
        h.but_rim_cam = uicontrol('style','pushbutton','Parent',h.pan_cam,...
            'position', [1.1*costanti.dim_fin-10 costanti.dim_fin-0.3*costanti.dim_fin 0.4*costanti.dim_fin 0.175*costanti.dim_fin],...
            'string','Rimuovi');      

        %%% Bottone per modificare un camino
        h.but_mod_cam = uicontrol('style','pushbutton','Parent',h.pan_cam,...
            'position', [0.5*costanti.dim_fin+10 costanti.dim_fin-0.3*costanti.dim_fin 0.4*costanti.dim_fin 0.175*costanti.dim_fin],...
            'string','Modifica');
       
        %%% Lista di visualizzazione dei camini
        h.list_cam = uicontrol('style','listbox','Parent',h.pan_cam,...
            'position', [10 0.3*costanti.dim_fin 0.9*costanti.dim_fin 0.3*costanti.dim_fin],'max',1);

        %%% Coordinata X del camino selezionato nella listbox
        h.text_cam_X = uicontrol('style','text','Parent',h.pan_cam,...
            'Units','pixels',...
            'Position', [10 0.075*costanti.dim_fin 0.2*costanti.dim_fin 0.4*costanti.alt_fin*costanti.dim_fin],...
            'string','X =');

        h.edit_cam_X = uicontrol('style','edit','Parent',h.pan_cam,...
            'Units','pixels',...
            'enable','inactive',...
            'Position', [0.25*costanti.dim_fin 10 0.4*costanti.dim_fin 0.65*costanti.alt_fin*costanti.dim_fin]); 

        %%% Coordinata Y del camino selezionato nella listbox
        h.text_cam_Y = uicontrol('style','text','Parent',h.pan_cam,...
            'Units','pixels',...
            'Position', [0.7*costanti.dim_fin 0.075*costanti.dim_fin 0.2*costanti.dim_fin 0.4*costanti.alt_fin*costanti.dim_fin],...
            'string','Y =');

        h.edit_cam_Y = uicontrol('style','edit','Parent',h.pan_cam,...
            'Units','pixels',...
            'enable','inactive',...
            'Position', [0.9*costanti.dim_fin 10 0.4*costanti.dim_fin 0.65*costanti.alt_fin*costanti.dim_fin]); 

        %%% Toggle button per abilitare il camino selezionato
        h.but_cam_enable = uicontrol('style','togglebutton','Parent',h.pan_cam,...
            'Units','pixels',...
            'enable','off',...
            'Position', [1.1*costanti.dim_fin-10 0.45*costanti.dim_fin 0.4*costanti.dim_fin 0.15*costanti.dim_fin],...
            'string','Abilita');

        %%% Toggle button per abilitare il camino selezionato
        h.but_cam_disable = uicontrol('style','togglebutton','Parent',h.pan_cam,...
            'Units','pixels',...
            'enable','off',...
            'Position', [1.1*costanti.dim_fin-10 0.3*costanti.dim_fin 0.4*costanti.dim_fin 0.15*costanti.dim_fin],...
            'string','Disabilita');

        %%% Set dei callback del pannello camini
        set(h.but_agg_cam, 'callback', {@pannello_aggmod_camino, h, 1});  %%% 1 aggiungi
        set(h.but_mod_cam, 'callback', {@pannello_aggmod_camino, h, 0});    %%% 0 modifica
        set(h.but_rim_cam, 'callback', {@rimuovi_camino, h});
        set(h.list_cam, 'callback', {@aggiorna_visualizzazione_mappa, h});
        set(h.but_cam_enable, 'callback', {@enable_cam});
        set(h.but_cam_disable, 'callback', {@disable_cam});
        
            %%% Abilito il camino
            function enable_cam(hObject,eventdata)
                i=get(h.list_cam,'value');
                list=amb.list_camino();
                amb=amb.set_camino_op(list(i), 1);               
                aggiorna_visualizzazione_mappa(hObject, eventdata, h);
            end

            %%% Disabilito il camino
            function disable_cam(hObject,eventdata)
                i=get(h.list_cam,'value');
                list=amb.list_camino();
                amb=amb.set_camino_op(list(i), 0);
                aggiorna_visualizzazione_mappa(hObject, eventdata, h);
            end    


            %%% Gestione rimozione camino
            function rimuovi_camino(hObject, eventdata, k)
                i=get(h.list_cam,'value');
                list=amb.list_camino();
                amb=amb.del_camino(list(i));
                aggiorna_pannello_camino(hObject, eventdata, h);
            end
        
        aggiorna_pannello_camino(hObject, eventdata, h);
end


%%% Gestione della finestra per aggiungere un camino
function pannello_aggmod_camino(hObject, eventdata, k, operation)
    global amb;

    camino_temp = [];
    check_array = ones(1,8);
    list = amb.list_camino();
    id = 0;
    
    %%% camino_temp=[x, y, altezza, raggio, dim_imp, temp_fumi, vel_fumi, rateo_em]
    if operation==1    %%% aggiungo camino
%         for kk=1:500
%             camino_temp = [kk*10, kk*10, 100, 1, 1, 380, 5, 100];
%             amb=amb.new_camino(camino_temp);
%         end
        camino_temp = [amb.get_map_dim_x/2, amb.get_map_dim_x/2, 1, 1, 1, costanti.temp_min_fumi, 1, 1];
    else       %%% modifico camino
        index = get(k.list_cam,'value');
        id = list(index);
        camino_temp = amb.get_camino(id);
    end    

    h.fin_cam = figure('Name','Aggiungi camino','Units','pixels','position',...
        [1.3*costanti.dim_fin 1.3*costanti.dim_fin 2*costanti.dim_fin 2*costanti.dim_fin],'MenuBar','none');

    %%% Pannello per la gestione dei dati del camino
    h.pan_dati_cam = uipanel('BorderType','etchedin',...
            'Title','DATI CAMINO',...
            'Units','pixels',...
            'Parent',h.fin_cam,... 
            'Position',[0 0 2*costanti.dim_fin 2*costanti.dim_fin]);

    %%% Gestione coordinate   
    h.txt_coord_cam = uicontrol('style','text','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'Position', [0 2*costanti.dim_fin-2.5*costanti.alt_fin*costanti.dim_fin costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Coordinate (X,Y)');

    h.edit_coord_cam_x = uicontrol('style','edit','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'string',camino_temp(1),...
        'Position', [costanti.dim_fin 2*costanti.dim_fin-2*costanti.alt_fin*costanti.dim_fin 0.4*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin]);

    h.edit_coord_cam_y = uicontrol('style','edit','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'string',camino_temp(2),...
        'Position', [1.4*costanti.dim_fin 2*costanti.dim_fin-2*costanti.alt_fin*costanti.dim_fin 0.4*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin]);

    %%% Gestione altezza
    h.txt_altezza_cam = uicontrol('style','text','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'position', [0 2*costanti.dim_fin-3.5*costanti.alt_fin*costanti.dim_fin costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Altezza geometrica (m)');

    h.edit_altezza_cam = uicontrol('style','edit','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'string',camino_temp(3),...
        'Position', [costanti.dim_fin 2*costanti.dim_fin-3*costanti.alt_fin*costanti.dim_fin 0.8*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin]);

    %%% Gestione raggio
    h.txt_raggio_cam = uicontrol('style','text','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'position', [0 2*costanti.dim_fin-4.5*costanti.alt_fin*costanti.dim_fin costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Raggio camino (m)');

    h.edit_raggio_cam = uicontrol('style','edit','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'string',camino_temp(4),...
        'Position', [costanti.dim_fin 2*costanti.dim_fin-4*costanti.alt_fin*costanti.dim_fin 0.8*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin]);

    %%% Gestione dimensione impianto
    h.txt_dim_imp = uicontrol('style','text','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'position', [0 2*costanti.dim_fin-5.5*costanti.alt_fin*costanti.dim_fin costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Dimensione Impianto');

    h.edit_dim_imp = uicontrol('style','popupmenu','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'Position', [costanti.dim_fin 2*costanti.dim_fin-5.15*costanti.alt_fin*costanti.dim_fin 0.8*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin],...
        'string',{'P','G'},...
        'value',camino_temp(5));

    %%% Gestione temperatura fumi
    h.txt_temp_fumi = uicontrol('style','text','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'position', [0 2*costanti.dim_fin-6.5*costanti.alt_fin*costanti.dim_fin costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Temperatura uscita fumi (K)');

    h.edit_temp_fumi = uicontrol('style','edit','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'string',camino_temp(6),...
        'Position', [costanti.dim_fin 2*costanti.dim_fin-6*costanti.alt_fin*costanti.dim_fin 0.8*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin]);

    %%% Gestione velocità fumi
    h.txt_vel_fumi = uicontrol('style','text','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'position', [0 2*costanti.dim_fin-7.5*costanti.alt_fin*costanti.dim_fin costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Velocit� uscita fumi (m/s)');

    h.edit_vel_fumi = uicontrol('style','edit','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'string',camino_temp(7),...
        'Position', [costanti.dim_fin 2*costanti.dim_fin-7*costanti.alt_fin*costanti.dim_fin 0.8*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin]);

    %%% Gestione rateo emissioni
    h.txt_rateo_em = uicontrol('style','text','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'position', [0 2*costanti.dim_fin-8.5*costanti.alt_fin*costanti.dim_fin costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Rateo emissione fumi (g/s)');

    h.edit_rateo_em = uicontrol('style','edit','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'string',camino_temp(8),...
        'Position', [costanti.dim_fin 2*costanti.dim_fin-8*costanti.alt_fin*costanti.dim_fin 0.8*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin]);

    %%% Gestione bottone OK
    h.but_ok_cam = uicontrol('style','pushbutton','Parent',h.pan_dati_cam,...
        'Units','pixels',...
        'string','OK',...
        'Position',  [0.6*costanti.dim_fin 2*costanti.dim_fin-9.5*costanti.alt_fin*costanti.dim_fin 0.8*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin]);

    set(h.edit_coord_cam_x, 'callback', {@set_cam_X});
    set(h.edit_coord_cam_y, 'callback', {@set_cam_Y});
    set(h.edit_altezza_cam, 'callback', {@set_altezza_cam});
    set(h.edit_raggio_cam, 'callback', {@set_raggio_cam});
    set(h.edit_dim_imp, 'callback', {@set_dim_imp});
    set(h.edit_temp_fumi, 'callback', {@set_temp_fumi});
    set(h.edit_vel_fumi, 'callback', {@set_vel_fumi});
    set(h.edit_rateo_em, 'callback', {@set_rateo_em});
    set(h.but_ok_cam, 'callback', {@aggiungi_camino, k});


        %%%     FUNZIONI PER LA GESTIONE DEL CAMINO     %%%

        %%% Controllo e set della X del camino
        function set_cam_X(hObject, eventdata)
            coord_x=str2num(get(h.edit_coord_cam_x,'string'));

            if (coord_x >= 0) & (coord_x <= amb.get_map_dim_x())
                camino_temp(1)=coord_x;
                set(h.edit_coord_cam_x,'ForegroundColor','black');
                check_array(1)=1;
            else
                set(h.edit_coord_cam_x,'ForegroundColor','red');
                check_array(1)=0;
            end
            
            abilita_button_ok();
        end

        %%% Controllo e set della Y del camino
        function set_cam_Y(hObject, eventdata)         
            coord_y=str2num(get(h.edit_coord_cam_y,'string'));

            if (coord_y >= 0) & (coord_y <= amb.get_map_dim_y())
                camino_temp(2)=coord_y;
                set(h.edit_coord_cam_y,'ForegroundColor','black');
                check_array(2)=1;
            else
                set(h.edit_coord_cam_y,'ForegroundColor','red');
                check_array(2)=0;
            end
            
            abilita_button_ok();
        end

    
        %%% Controllo e set dell'altezza del camino
        function set_altezza_cam(hObject, eventdata)
            alt=str2num(get(h.edit_altezza_cam,'string'));

            if (alt >= 0)
                camino_temp(3)=alt;
                set(h.edit_altezza_cam,'ForegroundColor','black');
                check_array(3)=1;
            else
                set(h.edit_altezza_cam,'ForegroundColor','red');
                check_array(3)=0;
            end
            
            abilita_button_ok();
        end

    
        %%% Controllo e set del raggio del camino
        function set_raggio_cam(hObject, eventdata)
            raggio=str2num(get(h.edit_raggio_cam,'string'));

            if (raggio > 0)
                camino_temp(4)=raggio;
                set(h.edit_raggio_cam,'ForegroundColor','black');
                check_array(4)=1;
            else
                set(h.edit_raggio_cam,'ForegroundColor','red');
                check_array(4)=0;
            end
            
            abilita_button_ok();
        end


        %%% Set della dimensione dell'impianto
        function set_dim_imp(hObject, eventdata)
            dim_imp = get(h.edit_dim_imp,'value');
            camino_temp(5)=dim_imp;
            check_array(5)=1;
            abilita_button_ok();
        end    

        %%% Controllo e set della temperatura fumi
        function set_temp_fumi(hObject, eventdata)
            temp_fumi=str2num(get(h.edit_temp_fumi,'string'));

            if (temp_fumi >= costanti.temp_min_fumi)
                camino_temp(6)=temp_fumi;
                set(h.edit_temp_fumi,'ForegroundColor','black');
                check_array(6)=1;
            else
                set(h.edit_temp_fumi,'ForegroundColor','red');
                check_array(6)=0;
            end
            
            abilita_button_ok();
        end    

        %%% Controllo e set della velocità fumi
        function set_vel_fumi(hObject, eventdata)
            vel_fumi=str2num(get(h.edit_vel_fumi,'string'));

            if (vel_fumi > 0)
                camino_temp(7)=vel_fumi;
                set(h.edit_vel_fumi,'ForegroundColor','black');
                check_array(7)=1;
            else
                set(h.edit_vel_fumi,'ForegroundColor','red');
                check_array(7)=0;
            end
            
            abilita_button_ok();
        end

        %%% Controllo e set del rateo d'emissione fumi
        function set_rateo_em(hObject, eventdata)
            rateo_em=str2num(get(h.edit_rateo_em,'string'));
            
            if (rateo_em > 0)
                camino_temp(8)=rateo_em;
                set(h.edit_rateo_em,'ForegroundColor','black');
                check_array(8)=1;
            else
                set(h.edit_rateo_em,'ForegroundColor','red');
                check_array(8)=0;
            end
            
            abilita_button_ok();
        end

        %%% abilito/disabilito il bottone OK nel pannello di inserimento dei
        %%% dati del camino, controllo che tutti i valori sia consistenti
        function abilita_button_ok()
            if all(check_array)
                set(h.but_ok_cam,'enable','on');
            else
                set(h.but_ok_cam,'enable','off');
            end
        end
    
    
        %%% Controlla che tutti i dati inseriti nel pannello "aggiungi camino"
        %%% siano corretti e set del camino
        function aggiungi_camino(hObject, eventdata, k) 
            if operation==1
                amb=amb.new_camino(camino_temp);
                
                close;                       
                
                aggiorna_pannello_camino(hObject, eventdata, k);
            else
                amb=amb.set_camino(id, camino_temp);
                
                close;                       
                
                aggiorna_visualizzazione_mappa(hObject, eventdata, k);
            end           
            
        end

      
end %%% end funzione pannello_camino   

%%% Aggiorna la visualizzazione dei dati del camino nel pannello della
%%% finestra principale
function aggiorna_pannello_camino(hObject, eventdata, k)
    global amb;
    
    camini = amb.list_camino();    

    if isempty(camini)                
        set(k.but_rim_cam,'enable','off');
        set(k.but_mod_cam,'enable','off');
        set(k.but_cam_enable,'backgroundcolor','default','value',0,'enable','off');
        set(k.but_cam_disable,'backgroundcolor','default','value',0,'enable','off');
        set(k.edit_cam_X,'string','');
        set(k.edit_cam_Y,'string','');
        set(k.list_cam,'string','');
    else
        set(k.but_rim_cam,'enable','on');
        set(k.but_mod_cam,'enable','on');        
        set(k.but_cam_enable,'enable','on');
        set(k.but_cam_disable,'enable','on');        
        
        tot_stringa='';
    
        for i=1:length(camini)
            stringa=horzcat('camino    ',int2str(camini(i)));        
            tot_stringa=strvcat(tot_stringa,stringa);          
        end
        set(k.list_cam,'string',cellstr(tot_stringa));
        set(k.list_cam,'value',length(camini));
        
        aggiorna_visualizzazione_mappa(hObject, eventdata, k);
    end
        
    %pan_plot(hObject, eventdata, k, index, -1);
%     if isempty(camini)
%         
%         pan_plot(hObject, eventdata, k, -1, -1);
%     end
end   


function aggiorna_visualizzazione_mappa(hObject, eventdata, k)
    global amb;
    
    camini = amb.list_camino();    
    
    if ~isempty(camini)
        index=get(k.list_cam,'value');
        id = camini(index);
        
        if amb.get_camino_op(id) == 1
            set(k.but_cam_enable,'backgroundcolor','green','value',1);
            set(k.but_cam_disable,'backgroundcolor','default','value',0);
        else
            set(k.but_cam_enable,'backgroundcolor','default','value',0);
            set(k.but_cam_disable,'backgroundcolor','red','value',1);
        end

        cam_t = amb.get_camino(id);
        set(k.edit_cam_X,'string',cam_t(1));
        set(k.edit_cam_Y,'string',cam_t(2));
        
        pan_plot(hObject, eventdata, k, index, -1);
    end   

end