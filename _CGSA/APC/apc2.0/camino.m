classdef camino
    properties
        params
        amb
    end
    methods
		%costruttore
        function obj=camino(params, amb)
            obj.params=params;
            obj.amb=amb;
        end
		%simulazione sulla superficie
        function result=simu_surface(obj)
            result=modelli.surface(obj);
        end
		%simulazione del profilo verticale
        function result=simu_vertical(obj, x, y)
            result=modelli.vertical(x, y, obj);
        end
		%calcolo dell'altezza efficace
        function h=h_eff(obj)
            h_delta=1;
            h=h_delta+obj.params(3);
        end
    end
end
