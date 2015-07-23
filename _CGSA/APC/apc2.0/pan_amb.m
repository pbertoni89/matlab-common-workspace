%%% Inizializzo il pannello ambiente    
function h = pan_amb(hObject, eventdata, k)

global amb;


%%% Pannello per la configurazione dell'ambiente
h.pan_amb = uipanel('BorderType','etchedin',...
        'Title','AMBIENTE',...
		'Units','pixels',...
		'Parent',k.fin_princ,... 
        'Position',[0.05*costanti.dim_fin 0.05*costanti.dim_fin 1.5*costanti.dim_fin 2*costanti.dim_fin+10]);
    
    %%% Gestione della dimensione dell'ambiente
    h.txt_dim_amb = uicontrol('style','text','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.01*costanti.dim_fin 2*costanti.dim_fin-2.5*costanti.alt_fin*costanti.dim_fin 0.75*costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Dimensione (X,Y)');
    
    h.edit_dim_amb_x = uicontrol('style','edit','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.8*costanti.dim_fin 2*costanti.dim_fin-2*costanti.alt_fin*costanti.dim_fin 0.3*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin],...
        'string',amb.get_map_dim_x());

    h.edit_dim_amb_y = uicontrol('style','edit','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [1.1*costanti.dim_fin 2*costanti.dim_fin-2*costanti.alt_fin*costanti.dim_fin 0.3*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin],...
        'string',amb.get_map_dim_y());

    %%% Gestione della velocità del vento
    h.txt_vel_vento = uicontrol('style','text','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.01*costanti.dim_fin 2*costanti.dim_fin-3.5*costanti.alt_fin*costanti.dim_fin 0.75*costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Velocità vento (m/s)');
    
    h.edit_vel_vento = uicontrol('style','edit','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.8*costanti.dim_fin 2*costanti.dim_fin-3*costanti.alt_fin*costanti.dim_fin 0.6*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin],...
        'string',amb.get_wind_speed());

    %%% Gestione della direzione del vento
    h.txt_dir_vento = uicontrol('style','text','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.01*costanti.dim_fin 2*costanti.dim_fin-4.5*costanti.alt_fin*costanti.dim_fin 0.75*costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Direzione vento (gradi)');
    
    h.edit_dir_vento = uicontrol('style','edit','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.8*costanti.dim_fin 2*costanti.dim_fin-4*costanti.alt_fin*costanti.dim_fin 0.6*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin],...
        'string',amb.get_wind_dir());    

    %%% Gestione della temperatura dell'aria
    h.txt_temp_aria = uicontrol('style','text','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.01*costanti.dim_fin 2*costanti.dim_fin-5.5*costanti.alt_fin*costanti.dim_fin 0.75*costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Temperatura aria (K)');
    
    h.edit_temp_aria = uicontrol('style','edit','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.8*costanti.dim_fin 2*costanti.dim_fin-5*costanti.alt_fin*costanti.dim_fin 0.6*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin],...
        'string',amb.get_temp());    

    %%% Gestione della classe di stabilità
    h.txt_classe_stab = uicontrol('style','text','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.01*costanti.dim_fin 2*costanti.dim_fin-6.5*costanti.alt_fin*costanti.dim_fin 0.75*costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Classe di stabilit�');
    
    h.edit_classe_stab = uicontrol('style','popupmenu','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.8*costanti.dim_fin 2*costanti.dim_fin-6.15*costanti.alt_fin*costanti.dim_fin 0.6*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin],...
        'string',{'A','B','C','D','E','F'});    
    set(h.edit_classe_stab, 'value', amb.get_stability());
    
    %%% Gestione della tipologia di terreno
    h.txt_tip_ter = uicontrol('style','text','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.01*costanti.dim_fin 2*costanti.dim_fin-7.5*costanti.alt_fin*costanti.dim_fin 0.75*costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Tipologia terreno');
    
    h.edit_tip_ter = uicontrol('style','popupmenu','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.8*costanti.dim_fin 2*costanti.dim_fin-7.15*costanti.alt_fin*costanti.dim_fin 0.6*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin],...
        'string',{'O','U'});
    set(h.edit_tip_ter, 'value', amb.get_terrain());
    
    %%% Gestione della tipologia di terreno
    h.txt_model = uicontrol('style','text','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.01*costanti.dim_fin 2*costanti.dim_fin-9.5*costanti.alt_fin*costanti.dim_fin 0.55*costanti.dim_fin costanti.alt_fin*costanti.dim_fin],...
        'string','Modello');
    
    h.edit_model = uicontrol('style','popupmenu','Parent',h.pan_amb,...
        'Units','pixels',...
        'Position', [0.6*costanti.dim_fin 2*costanti.dim_fin-9.15*costanti.alt_fin*costanti.dim_fin 0.8*costanti.dim_fin 0.8*costanti.alt_fin*costanti.dim_fin],...
        'string',{'Gaussiano'});
    set(h.edit_model, 'value', amb.get_model());
    
    
    %%% Set dei callback del pannello ambiente
    set(h.edit_dim_amb_x, 'callback', {@set_amb_X, h});
    set(h.edit_dim_amb_y, 'callback', {@set_amb_Y, h});
    set(h.edit_vel_vento, 'callback', {@set_vel_vento, h});
    set(h.edit_dir_vento, 'callback', {@set_dir_vento, h});
    set(h.edit_temp_aria, 'callback', {@set_temp_aria, h});
    set(h.edit_classe_stab, 'callback', {@set_classe_stab, h});    
    set(h.edit_tip_ter, 'callback', {@set_tip_ter, h});
    set(h.edit_model, 'callback', {@set_model, h});    
    
    
%%%     FUNZIONI PER LA GESTIONE DELL'AMBIENTE  %%%

%%% Controllo e set della ordinata X dell'ambiente
function h = set_amb_X(hObject, eventdata, k)
global amb;

x = str2num(get(k.edit_dim_amb_x,'string'));

if x>=costanti.map_dim_min
    amb=amb.set_map_dim_x(x);
    set(k.edit_dim_amb_x,'ForegroundColor','black');
else
    set(k.edit_dim_amb_x,'ForegroundColor','red');
end   
pan_plot(hObject, eventdata, k, -1, -1);


%%% Controllo e set della ordinata Y dell'ambiente
function h = set_amb_Y(hObject, eventdata, k)
global amb;

y = str2num(get(k.edit_dim_amb_y,'string'));

if y>=costanti.map_dim_min
    amb=amb.set_map_dim_y(y);
    set(k.edit_dim_amb_y,'ForegroundColor','black');
else
    set(k.edit_dim_amb_y,'ForegroundColor','red');
end  
pan_plot(hObject, eventdata, k, -1, -1);

%%% Controllo e set della velocità del vento
function h = set_vel_vento(hObject, eventdata, k)
global amb;

vel_vento = str2num(get(k.edit_vel_vento,'string'));

if vel_vento>=costanti.wind_speed_min 
    amb=amb.set_wind_speed(vel_vento);
    set(k.edit_vel_vento,'ForegroundColor','black');
else
    set(k.edit_vel_vento,'ForegroundColor','red');
end  

%%% Controllo e set della direzione del vento
function h = set_dir_vento(hObject, eventdata, k)
global amb;

dir_vento = str2num(get(k.edit_dir_vento,'string'));

if rem(dir_vento,1)==0
    amb=amb.set_wind_dir(dir_vento);
    set(k.edit_dir_vento,'ForegroundColor','black');
    pan_plot(hObject, eventdata, k, -1, -1);
else
    set(k.edit_dir_vento,'ForegroundColor','red');
end  

%%% Controllo e set della temperatura dell'aria
function h = set_temp_aria(hObject, eventdata, k)
global amb;

temp_aria = str2num(get(k.edit_temp_aria,'string'));

if temp_aria>=costanti.temp_min
    amb=amb.set_temp(temp_aria);
    set(k.edit_temp_aria,'ForegroundColor','black');
else
    set(k.edit_temp_aria,'ForegroundColor','red');
end   

%%% Set della classe di stabilità
function h = set_classe_stab(hObject, eventdata, k)
global amb;

classe_stab = get(k.edit_classe_stab,'value');
amb=amb.set_stability(classe_stab);

%%% Set della tipologia di terreno
function h = set_tip_ter(hObject, eventdata, k)
global amb;

tip_ter = get(k.edit_tip_ter,'value');
amb=amb.set_terrain(tip_ter);

%%% Set del modello
function h = set_model(hObject, eventdata, k)
global amb;

model = get(k.edit_model,'value');
amb=amb.set_model(model);

