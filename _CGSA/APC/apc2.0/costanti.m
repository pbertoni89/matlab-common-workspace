%% In questo file sono contenute tutte le costanti

classdef costanti
    properties(Constant)
        map_dim_def=20000;
        map_dim_min=1000;
        wind_speed_def=1;
        wind_speed_min=1;
        wind_dir_def=0;
        temp_def=293;
        temp_min=100;
        temp_min_fumi=303;
        stability_def=1;
        terrain_def=1;
        camino_temp_min=100;
        rescale=100;
        cache_x_min=1;
        cache_x_max=15000;
        cache_y_min=-5000;
        cache_y_max=5000;
        model='gauss';
        particle_dim=[1 2.5 10];
        dim_fin=200;    %dimensione finestra gfx
        alt_fin=0.2;    %altezza finestra gfx
    end
end