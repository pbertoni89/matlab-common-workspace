classdef ambiente
    properties
        map_dim_x
        map_dim_y
        wind_speed
        wind_dir
        temp
        stability
        terrain
        camino
        camino_status
        camino_cache
        city
        city_status
        model
    end
    methods
        %costruttore
        function obj=ambiente()
            obj.map_dim_x=costanti.map_dim_def;
            obj.map_dim_y=costanti.map_dim_def;
            obj.wind_speed=costanti.wind_speed_def;
            obj.wind_dir=costanti.wind_dir_def;
            obj.temp=costanti.temp_def;
            obj.stability=costanti.stability_def;
            obj.terrain=costanti.terrain_def;
            obj.model=costanti.model;
        end
        function obj=set_model(obj, value)
            if value==1
                obj.model='gauss';
            elseif value==2
                obj.model='gauss_particle';
            end
            obj=obj.chparam();
        end          
        %cache handler
        function obj=chparam(obj)
            clear obj.camino_cache;
            camino_num=size(obj.camino_status, 1);
            for i=1:camino_num
                obj.camino_status(i, 3)=0;
            end
        end
        %lista set
        function obj=set_map_dim_x(obj, value)
            %obj=obj.chparam();
            obj.map_dim_x=value;
        end
        function obj=set_map_dim_y(obj, value)
            %obj=obj.chparam();
            obj.map_dim_y=value;
        end
        function obj=set_wind_speed(obj, value)
            obj=obj.chparam();
            obj.wind_speed=value;
        end
        function obj=set_wind_dir(obj, value)
            %obj=obj.chparam();
            obj.wind_dir=value;
        end
        function obj=set_temp(obj, value)
            obj=obj.chparam();
            obj.temp=value;
        end
        function obj=set_stability(obj, value)
            obj=obj.chparam();
            obj.stability=value;
        end
        function obj=set_terrain(obj, value)
            obj=obj.chparam();
            obj.terrain=value;
        end
        %new e set camini/city
        function obj=new_camino(obj, params)
            id=size(obj.camino_status, 1);
            id=id+1;
            obj=obj.set_camino(id, params);
        end
        function obj=set_camino(obj, id, params)
            obj.camino(id,:)=params;
            obj.camino_status(id,:)=[1 1 0];
        end
        function obj=del_camino(obj, id)
            obj.camino_status(id,:)=[0 0 0];
        end
        function obj=new_city(obj, params)
            id=size(obj.city_status, 1);
            id=id+1;
            obj=obj.set_city(id, params);
        end
        function obj=set_city(obj, id, params)
            obj.city(id,:)=params;
            obj.city_status(id,:)=[1 1];
        end
        function obj=del_city(obj, id)
            obj.city_status(id,:)=[0 0];
        end
        %lista get
        function out=get_model(obj)
            if obj.model=='gauss';
                out=1;
            elseif obj.model=='gauss_particle'
                out=2;
            end
        end
        function out=get_map_dim_x(obj)
            out=obj.map_dim_x;
        end
        function out=get_map_dim_y(obj)
            out=obj.map_dim_y;
        end
        function out=get_wind_speed(obj)
            out=obj.wind_speed;
        end
        function out=get_wind_dir(obj)
            out=obj.wind_dir;
        end
        function out=get_temp(obj)
            out=obj.temp;
        end
        function out=get_stability(obj)
            out=obj.stability;
        end
        function out=get_terrain(obj)
            out=obj.terrain;
        end
        function out=get_camino(obj, id)
            out=obj.camino(id, :);
        end
        function out=get_city(obj, id)
            out=obj.city(id, :);
        end
        %lista activation
        function out=get_camino_op(obj, id)
            out=obj.camino_status(id, 2);
        end
        function out=get_city_op(obj, id)
            out=obj.city_status(id, 2);
        end
        function obj=set_camino_op(obj, id, enabled)
            if enabled==0
                obj.camino_status(id, 2)=0;
            else
                obj.camino_status(id, 2)=1;
            end
        end
        function obj=set_city_op(obj, id, enabled)
            if enabled==0
                obj.city_status(id, 2)=0;
            else
                obj.city_status(id, 2)=1;
            end
        end
        %lista list
        function out=list_camino(obj)
            list=[];
            list_num=0;
            camino_num=size(obj.camino_status, 1);
            for i=1:camino_num
                if(obj.camino_status(i, 1)==1)
                    list_num=list_num+1;
                    list(list_num)=i;
                end
            end
            out=list;
        end
        function out=list_city(obj)
            list=[];
            list_num=0;
            city_num=size(obj.city_status, 1);
            for i=1:city_num
                if(obj.city_status(i, 1)==1)
                    list_num=list_num+1;
                    list(list_num)=i;
                end
            end
            out=list;
        end
        function vect=profile(obj, x, y)
            camini_status=obj.camino_status;
            camini_num=size(camini_status, 1);
            camini_data=obj.camino;
            vect=zeros(1,50);
            R=obj.calc_sdr(obj.wind_dir);
            in_size=size(obj.camino_cache{1});
            in_pos=[0 in_size(2)/2];
            for cid=1:camini_num
                if camini_status(cid, 1:2)==[1 1]
                    out_x_pos=obj.camino(cid, 1)/costanti.rescale;
                    out_y_pos=obj.camino(cid, 2)/costanti.rescale;
                    camino_cur=camino(camini_data(cid, :), obj);
                    newc=round(R*[x-out_x_pos; y-out_y_pos]+in_pos');
                    vect=vect+camino_cur.simu_vertical(newc(1), newc(2));
                end
            end
        end
        function [obj]=cache_rebuild(obj)
            camini_status=obj.camino_status;
            camini_num=size(camini_status, 1);
            camini_data=obj.camino;
            cache_def=zeros(1, camini_num);
            parfor cid=1:camini_num
                if camini_status(cid, :)==[1 1 0]
                    camino_cur=camino(camini_data(cid, :), obj);
                    cache_data{cid}=camino_cur.simu_surface();
                    cache_def(cid)=1;
                end
            end
            for cid=1:camini_num
                if cache_def(cid)==1
                    obj.camino_cache{cid}=cache_data{cid};
                    obj.camino_status(cid, 3)=1;
                end
            end
        end
        function R=calc_sdr(obj, angolo)
            alph = (90+angolo)*pi/180;
            cosa = cos(alph);
            sina = sin(alph);
            R=[cosa, -sina; sina, cosa];
        end
        function [out,obj]=dump(obj)
            camino_num=size(obj.camino_status, 1);
            
            obj=obj.cache_rebuild();
            
            %lettura dati
            out_x_dim=obj.map_dim_x/costanti.rescale;
            out_y_dim=obj.map_dim_y/costanti.rescale;
            out_angolo=obj.wind_dir;
            %calcoli di rotazione
            R=obj.calc_sdr(out_angolo);
            
            in_size=size(obj.camino_cache{1});
            in_pos=[0 in_size(2)/2];

            out=sparse(out_x_dim, out_y_dim);
            
            for cid=1:camino_num
                if obj.camino_status(cid, :)==[1 1 1]
                    out_tmp=sparse(out_x_dim, out_y_dim);
                    %mappa ricevuta
                    in=obj.camino_cache{cid};
                    out_x_pos=obj.camino(cid, 1)/costanti.rescale;
                    out_y_pos=obj.camino(cid, 2)/costanti.rescale;
                    for x=1:out_x_dim
                        for y=1:out_y_dim
                            newc=round(R*[x-out_x_pos; y-out_y_pos]+in_pos');
                            if newc(1)>0 & newc(1)<=in_size(1) & newc(2)>0 & newc(2)<=in_size(2)
                                out_tmp(x, y)=in(newc(1), newc(2));
                            end
                        end
                    end
                    out=out+out_tmp;
                end
            end
            
            out=(out')*10^6;
        end
    end
end