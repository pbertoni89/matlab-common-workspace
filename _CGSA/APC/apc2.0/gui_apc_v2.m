%% Questa è la funzione da chiamare per lanciare l'interfaccia grafica del 
%% programma APC_V2


%%% Gestione della finestra principale dei menù
function gui_apc_v2
    clear all;
    clc;
    
    %%% per poter usufruire della parallelizzazione usare questo comando:
    %%% matlabpool open (N° di processori)
    
    %%% si considerano 2 processori
    %%% matlabpool open 2;
    
    global amb;
    global fin_handles;
       
    amb=ambiente();
    
    h.fin_princ = figure('Name','APC V2.0','Units','pixels','position',...
        [1.3*costanti.dim_fin 1.3*costanti.dim_fin 4.6*costanti.dim_fin+20 2.15*costanti.dim_fin],'MenuBar','none');
    fin_handles=h;
    
    draw_gui;
end









