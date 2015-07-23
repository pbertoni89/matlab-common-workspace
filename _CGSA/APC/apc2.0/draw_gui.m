function draw_gui()      
    global fin_handles;      
    
    pan_amb(gcbo, [], fin_handles);
    pan_cam(gcbo, [], fin_handles);
    pan_sta_ril(gcbo, [], fin_handles);
    pan_sim(gcbo, [], fin_handles);
    pan_plot(gcbo, [], fin_handles, -1, -1);

end