%%% Inizializzo il pannello delle stazioni di rilevamento    
function h = pan_sim(hObject, eventdata, k)

%%% Pannello per le stazioni di rilevamento
h.pan_sta_ril = uipanel('BorderType','etchedin',...
        'Title','SIMULAZIONE',...
		'Units','pixels',...
		'Parent',k.fin_princ,... 
        'Position',[3.15*costanti.dim_fin 0.05*costanti.dim_fin 1.5*costanti.dim_fin costanti.dim_fin]);
    
    %%% Bottone per avviare la simulazione
    h.but_avvia_sim = uicontrol('style','pushbutton','Parent',h.pan_sta_ril,...
        'position', [0.35*costanti.dim_fin 0.15*costanti.dim_fin 0.8*costanti.dim_fin 0.3*costanti.dim_fin],...
        'string','Avvia');
    
    h.but_carica_sim = uicontrol('style','pushbutton','Parent',h.pan_sta_ril,...
        'position', [0.2*costanti.dim_fin 0.6*costanti.dim_fin 0.5*costanti.dim_fin 0.2*costanti.dim_fin],...
        'string','Carica');
    
     h.but_salva_sim = uicontrol('style','pushbutton','Parent',h.pan_sta_ril,...
        'position', [0.8*costanti.dim_fin 0.6*costanti.dim_fin 0.5*costanti.dim_fin 0.2*costanti.dim_fin],...
        'string','Salva');
    
    set(h.but_carica_sim, 'callback', {@carica_file});
    set(h.but_salva_sim, 'callback', {@salva_file});
    set(h.but_avvia_sim, 'callback', {@avvia_simulazione});
end

function carica_file(hObject, eventdata)
    uiload;    
    draw_gui;
end

function salva_file(hObject, eventdata)
    global amb;
    uisave('amb','simulazione');
end

function avvia_simulazione(hObject, eventdata)
    global amb;
    
    stazioni = amb.list_city();
    camini = amb.list_camino();
    check_array = ones(1,2);
    xy_vis = [0, 0];
    conc=0;        
    
    if ~isempty(camini)
        [mtx, amb] = amb.dump();
        %mtx=full(mtx)
        %mtx=peaks(200);
        
        h.fin_plot = figure('Name','Risultato simulazione','Units','pixels','position',...
            [1*costanti.dim_fin 1*costanti.dim_fin 5*costanti.dim_fin 3*costanti.dim_fin]);   

        pan_plot_figure(hObject, eventdata);
        pan_plot_control(hObject, eventdata);    
    end
    
    function pan_plot_figure(hObject, eventdata)
        %%% Pannello per il plot della simulazione
        h.pan_plot_figure = uipanel('BorderType','etchedin',...               
                'Units','pixels',...
                'Parent',h.fin_plot,... 
                'Position',[0 0 4*costanti.dim_fin 3*costanti.dim_fin]);                            
        
        h.ax = axes;
        set(h.ax,'parent', h.pan_plot_figure,'units', 'pixels', 'OuterPosition',[-0.2*costanti.dim_fin -0.1*costanti.dim_fin 4.4*costanti.dim_fin 3*costanti.dim_fin],...
                'XLim',[0 amb.get_map_dim_x/costanti.rescale], 'YLim', [0 amb.get_map_dim_y/costanti.rescale]);
        whitebg(h.fin_plot,[0.9 0.9 0.9]);

        num_level = 9;
        mm = floor(max(max(mtx)));
        mm = mm(1,1);
        step = floor(mm/num_level);
        levels = [step:step:(mm-step)];
        exp = [.125:.125:1];
        log_levels = levels.*(exp.^2);
        log_levels = round(log_levels);
        %log_levels=levels;
        [c,d]=contourf(mtx, log_levels); 
        clabel(c,d,'color','red','fontsize',12);
        colormap('jet');
        hc = colorbar;

        hold on;                      
        
        for j=1:length(stazioni)
            sta_t=amb.get_city(stazioni(j));
                if amb.get_city_op(stazioni(j))==1
                    plot(h.ax,sta_t(1)/costanti.rescale,sta_t(2)/costanti.rescale,'^g','MarkerSize',8,'LineWidth',2);
                else
                    plot(h.ax2,sta_t(1)/costanti.rescale,sta_t(2)/costanti.rescale,'^','MarkerSize',8,'LineWidth',1,'Color',[0.5,0.5,0.5]);
                end
        end
        
        for j=1:length(camini)
            cam_t=amb.get_camino(camini(j));
                if amb.get_camino_op(camini(j))==1
                    plot(h.ax,cam_t(1)/costanti.rescale,cam_t(2)/costanti.rescale,'or','MarkerSize',8,'LineWidth',2);
                else
                    plot(h.ax,cam_t(1)/costanti.rescale,cam_t(2)/costanti.rescale,'o','MarkerSize',8,'LineWidth',1,'Color',[0.5,0.5,0.5]);
                end  
        end
            
        hold off;
    end    

    function pan_plot_control(hObject, eventdata)
        %%% Pannello per il plot della simulazione
        h.pan_plot_control = uipanel('BorderType','etchedin',...               
                'Units','pixels',...
                'Parent',h.fin_plot,... 
                'Position',[4*costanti.dim_fin 0 1*costanti.dim_fin 3*costanti.dim_fin]);   
            
            %%% Lista di visualizzazione delle stazioni di rilevamento
            h.list_sta_ril = uicontrol('style','listbox','Parent',h.pan_plot_control,...
                'position', [10 2.3*costanti.dim_fin 0.9*costanti.dim_fin 0.5*costanti.dim_fin],'max',1);
            
            %%% Coordinata X della stazione di rilevamento selezionata nella listbox
            h.text_sta_ril_X = uicontrol('style','text','Parent',h.pan_plot_control,...
                'Units','pixels',...
                'Position', [0.1*costanti.dim_fin 2.1*costanti.dim_fin 0.2*costanti.dim_fin 0.4*costanti.alt_fin*costanti.dim_fin],...
                'string','X =');

            h.edit_sta_ril_X = uicontrol('style','edit','Parent',h.pan_plot_control,...
                'Units','pixels',...
                'Position', [0.3*costanti.dim_fin 2.08*costanti.dim_fin 0.5*costanti.dim_fin 0.65*costanti.alt_fin*costanti.dim_fin]); 

            %%% Coordinata Y della stazione selezionata nella listbox
            h.text_sta_ril_Y = uicontrol('style','text','Parent',h.pan_plot_control,...
                'Units','pixels',...
                'Position', [0.1*costanti.dim_fin 1.95*costanti.dim_fin 0.2*costanti.dim_fin 0.4*costanti.alt_fin*costanti.dim_fin],...
                'string','Y =');

            h.edit_sta_ril_Y = uicontrol('style','edit','Parent',h.pan_plot_control,...
                'Units','pixels',...
                'Position', [0.3*costanti.dim_fin 1.93*costanti.dim_fin 0.5*costanti.dim_fin 0.65*costanti.alt_fin*costanti.dim_fin]);
            
            %%% Concentrazione nel punto X,Y
            h.text_conc = uicontrol('style','text','Parent',h.pan_plot_control,...
                'Units','pixels',...
                'Position', [0.02*costanti.dim_fin 1.70*costanti.dim_fin 0.25*costanti.dim_fin 0.4*costanti.alt_fin*costanti.dim_fin],...
                'string','Conc =');

            h.edit_conc = uicontrol('style','edit','Parent',h.pan_plot_control,...
                'Units','pixels',...
                'enable','inactive',...
                'Position', [0.3*costanti.dim_fin 1.68*costanti.dim_fin 0.5*costanti.dim_fin 0.65*costanti.alt_fin*costanti.dim_fin]);
            
            %%% Prendo le coordinate X e Y con il mouse
            h.but_get_xy = uicontrol('style','pushbutton','Parent',h.pan_plot_control,...
                'Units','pixels',...
                'string','Seleziona punto',...
                'Position',  [0.2*costanti.dim_fin 1*costanti.dim_fin 0.6*costanti.dim_fin 0.2*costanti.dim_fin]);
            
            %%% Genero il profilo verticale nel punto XY
            h.but_get_prof_vert = uicontrol('style','pushbutton','Parent',h.pan_plot_control,...
                'Units','pixels',...
                'string','Profilo verticale',...
                'Position',  [0.2*costanti.dim_fin 0.7*costanti.dim_fin 0.6*costanti.dim_fin 0.2*costanti.dim_fin]);
              
            
            if ~isempty(stazioni)
                tot_stringa='';

                for i=1:length(stazioni)
                    stringa=horzcat('stazione    ',int2str(stazioni(i)));        
                    tot_stringa=strvcat(tot_stringa,stringa);         
                end
                set(h.list_sta_ril,'string',cellstr(tot_stringa));
                set(h.list_sta_ril,'value',1);
                aggiorna_visualizzazione_lista(hObject, eventdata);
            end
            
            set(h.list_sta_ril,'callback',{@aggiorna_visualizzazione_lista});
            set(h.edit_sta_ril_X, 'callback', {@set_sta_X});
            set(h.edit_sta_ril_Y, 'callback', {@set_sta_Y});
            set(h.but_get_xy, 'callback', {@get_xy});
            set(h.but_get_prof_vert, 'callback', {@get_prof_vert});
            
            %%% Genero il profilo verticale
            function get_prof_vert(hObject, eventdata)
                data=amb.profile(xy_vis(1),xy_vis(2));
                data=data.*10^6;
                figure;
                plot(data, 1:length(data));
            end    
            
            %%% Prendo le coordinate xy da mouse
            function get_xy(hObject, eventdata)
                [a, b] = ginput(1);
                
                if ((a >0) & (a <= amb.get_map_dim_x()/costanti.rescale)) & ((b > 0) & ( b <= amb.get_map_dim_y()/costanti.rescale))
                    xy_vis(1) = round(a);
                    xy_vis(2) = round(b);
                    aggiorna_visualizzazione(hObject, eventdata);
                end    
            end
            
            %%% Controllo e set della coordinata x della stazione di rilevamento    
            function set_sta_X(hObject, eventdata)
                coord_x=str2num(get(h.edit_sta_ril_X,'string'));

                if (coord_x >= 0) & (coord_x <= amb.get_map_dim_x())
                    xy_vis(1)=round(coord_x/costanti.rescale);
                    set(h.edit_sta_ril_X,'ForegroundColor','black');
                    check_array(1)=1;
                    aggiorna_visualizzazione(hObject, eventdata);
                else
                    set(h.edit_sta_ril_X,'ForegroundColor','red');
                    check_array(1)=0;
                    aggiorna_visualizzazione(hObject, eventdata);
                end
            end

            %%% Controllo e set della coordinata y della stazione di rilevamento
            function set_sta_Y(hObject, eventdata)
                coord_y=str2num(get(h.edit_sta_ril_Y,'string'));

                if (coord_y >= 0) & (coord_y <= amb.get_map_dim_y())
                    xy_vis(2)=round(coord_y/costanti.rescale);
                    set(h.edit_sta_ril_Y,'ForegroundColor','black');
                    check_array(2)=1;                    
                    aggiorna_visualizzazione(hObject, eventdata);
                else
                    set(h.edit_sta_ril_Y,'ForegroundColor','red');
                    check_array(2)=0;
                    aggiorna_visualizzazione(hObject, eventdata);
                end
            end  
            
            function aggiorna_visualizzazione_lista(hObject, eventdata)
                index = get(h.list_sta_ril,'value');
                sta_t = amb.get_city(index);
                xy_vis(1) = round(sta_t(1)/costanti.rescale);
                xy_vis(2) = round(sta_t(2)/costanti.rescale);
                aggiorna_visualizzazione(hObject, eventdata);
            end    

            function aggiorna_visualizzazione(hObject, eventdata)
                if all(check_array)
                    set(h.edit_sta_ril_X,'string',xy_vis(1)*costanti.rescale);
                    set(h.edit_sta_ril_Y,'string',xy_vis(2)*costanti.rescale);
                    conc=mtx(xy_vis(2), xy_vis(1));
                    set(h.edit_conc,'string',conc);
                else
                    set(h.edit_conc,'string','');
                end    
            end 
    end    
end  





