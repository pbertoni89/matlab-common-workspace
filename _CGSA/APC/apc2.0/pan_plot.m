%%% Inizializzo il pannello delle stazioni di rilevamento    
function h = pan_plot(hObject, eventdata, k, index_cam, index_sta)
global amb;
global fin_handles;


%%% Pannello per le stazioni di rilevamento
h.pan_plot = uipanel('BorderType','etchedin',...
        'Title','MAPPA',...
		'Units','pixels',...
		'Parent',fin_handles.fin_princ,... 
        'Position',[1.6*costanti.dim_fin 0.05*costanti.dim_fin 1.5*costanti.dim_fin costanti.dim_fin]);
    
    %%% Bottone per aggiungere una stazione di rilevamento
    %subplot(1, 1, 1, 'parent', h.pan_plot);
    %subplot(1, 1, 1, 'parent', h.pan_plot);
    ax = axes;
    set(ax,'parent', h.pan_plot,'units', 'pixels', 'OuterPosition',[0 0 1.5*costanti.dim_fin 0.9*costanti.dim_fin],...
        'XLim',[0 amb.get_map_dim_x/1000], 'YLim', [0 amb.get_map_dim_y/1000], 'fontsize',8);

    hold on;
    
    plot_camini(index_cam);
    plot_stazioni(index_sta);
    plot_wind();
end       
    
    function plot_camini(index)
        global amb;
    
        camini=amb.list_camino();
    
        for i=1:length(camini)
            cam_t=amb.get_camino(camini(i));
            if i==index
                plot(cam_t(1)/1000,cam_t(2)/1000,'or','MarkerSize',10,'LineWidth',2);
            else
                if amb.get_camino_op(camini(i))==1
                    plot(cam_t(1)/1000,cam_t(2)/1000,'ob','MarkerSize',8,'LineWidth',2);
                else
                    plot(cam_t(1)/1000,cam_t(2)/1000,'o','MarkerSize',8,'LineWidth',1,'Color',[0.5,0.5,0.5]);
                end    
            end
        end
    end    
    
    function plot_stazioni(index)   
        global amb;         
        
        stazioni=amb.list_city();
        
        for j=1:length(stazioni)
            sta_t=amb.get_city(stazioni(j));
            if j==index
                plot(sta_t(1)/1000,sta_t(2)/1000,'^r','MarkerSize',10,'LineWidth',2);
            else
                if amb.get_city_op(stazioni(j))==1
                    plot(sta_t(1)/1000,sta_t(2)/1000,'^g','MarkerSize',8,'LineWidth',2);
                else
                    plot(sta_t(1)/1000,sta_t(2)/1000,'^','MarkerSize',8,'LineWidth',1,'Color',[0.5,0.5,0.5]);
                end
            end    
        end  
    end    
    
    function plot_wind()
        global amb;
        
        lungh=5;
        alt=5;

        x=[1:lungh];
        y=[1:alt];

        for i=1:lungh
            a=amb.get_map_dim_x()/(lungh*1000);
            x(i)=a*(i-0.5);
        end    
        for i=1:alt
            a=amb.get_map_dim_y()/(lungh*1000);
            y(i)=a*(i-0.5);
        end

        [X,Y]=meshgrid(x,y);

        u=zeros(alt,lungh);
        v=zeros(alt,lungh);


        for i=1:alt
            for j=1:lungh
                u(i,j)=sind(amb.get_wind_dir()-180);
                v(i,j)=cosd(amb.get_wind_dir()-180);         
            end    
        end   

        quiver(X,Y,u,v,.2,'--','Color',[0.6,0.6,0.6]); 
    end