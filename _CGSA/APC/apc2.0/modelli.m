classdef modelli
    methods(Static)
		%simulazione del camino sul piano orizzontale
        function mtx=surface(camino)
            z=1;
            mtx=modelli.gaussiano(z, camino);
        end
		%simulazione del camino sul piano verticale
        function vect=vertical(x, y, camino)
            row=0;
            vect=zeros(1, 50);
            for z=1:10:500
                row=row+1;
                if x<costanti.cache_x_min || x>costanti.cache_x_max || ...
				   y<costanti.cache_y_min || y>costanti.cache_y_max
                    vect(row)=0;
                else
                    tmp=modelli.gaussiano(z, camino);
                    vect(row)=tmp(x, y);
                end
            end            
            %vect=modelli.gaussiano_vertical(x*costanti.rescale, y*costanti.rescale, [1:10:500], camino);
        end
		%legge e trasforma tutti i parametri necessari alla simulazione
        function [model,camino_h,camino_r,camino_dim,fumi_t,fumi_v,camino_emiss,amb_wind_speed,amb_terrain,amb_stability,amb_temp]=get_values(camino)
            model=camino.amb.model;
            camino_h=camino.params(3);
            camino_r=camino.params(4);
            if(camino.params(5)==1)
                camino_dim='p';
            else
                camino_dim='g';
            end
            fumi_t=camino.params(6);
            fumi_v=camino.params(7);
            camino_emiss=camino.params(8);
            
            amb_wind_speed=camino.amb.wind_speed;
            if(camino.amb.terrain==1)
                amb_terrain='o';
            else
                amb_terrain='u';
            end

            if(camino.amb.stability==1)
                amb_stability='a';
            elseif(camino.amb.stability==2)
                amb_stability='b';
            elseif(camino.amb.stability==3)
                amb_stability='c';
            elseif(camino.amb.stability==4)
                amb_stability='d';
            elseif(camino.amb.stability==5)
                amb_stability='e';
            elseif(camino.amb.stability==6)
                amb_stability='f';
            end
            amb_temp=camino.amb.temp;
        end
		%appoggiandosi ad alcune classi dell'APCv1 genera i vettori dei parametri necessari alla simulazione
        function [sy,sz,H]=get_params(camino, x_vals)
            [model,camino_h,camino_r,camino_dim,fumi_t,fumi_v,camino_emiss,amb_wind_speed,amb_terrain,amb_stability,amb_temp]=modelli.get_values(camino);
            sy=zeros(1, size(x_vals, 2));
            sz=zeros(1, size(x_vals, 2));
            H=zeros(1, size(x_vals, 2));
            iloop=0;
            for x=x_vals
                iloop=iloop+1;
                sigma=coeff_disp(amb_terrain, amb_stability, x);
                sy(iloop)=sigma(1);
                sz(iloop)=sigma(2);
                H(iloop)=altezza_eff(camino_dim, amb_wind_speed, amb_temp, amb_stability, camino_h, fumi_v, fumi_t, camino_r, x);
            end
        end
		%simulazione del gaussiano
        function conc=gaussiano(z, camino)
            y_vals=costanti.cache_y_min:costanti.rescale:costanti.cache_y_max;
            x_vals=costanti.cache_x_min:costanti.rescale:costanti.cache_x_max;
            
            [model, camino_h,camino_r,camino_dim,fumi_t,fumi_v,camino_emiss,amb_wind_speed,amb_terrain,amb_stability,amb_temp]=modelli.get_values(camino);
            [sy,sz,H]=modelli.get_params(camino, x_vals);

            size_x=size(x_vals, 2);
            size_y=size(y_vals, 2);
            
            ones_x=ones(size_x,1);
            ones_y=ones(1,size_y);
            
            conc=sparse(size_x, size_y);
            precalc = (1./(2*pi*amb_wind_speed*(sy.*sz))) .* ( exp(-0.5*(z-H).^2./sz.^2) + exp(-0.5*(z+H).^2./sz.^2) );

            y_pre=exp((-0.5.*ones_x*y_vals.^2)./((sy.^2)'*ones_y));
            conc=(y_pre.*(precalc'*ones_y));
            emiss_mtx=modelli.calc_emiss(camino, x_vals, y_vals);
            conc=conc.*emiss_mtx;
        end
		%calcolo delle emissioni: banale senza particolato, un po' più complesso con particolato
        function emiss=calc_emiss(camino, x_vals, y_vals)
            [model, camino_h,camino_r,camino_dim,fumi_t,fumi_v,camino_emiss,amb_wind_speed,amb_terrain,amb_stability,amb_temp]=modelli.get_values(camino);
            [sy,sz,H]=modelli.get_params(camino, x_vals);
            size_x=size(x_vals, 2);
            size_y=size(y_vals, 2);
            
			%qui è dove si realizza la selezione del modello che si vuole usare (con o senza particolato)
            if strcmp(model,'gauss')
                emiss=ones(size_x,1)*ones(1,size_y);
			%questa parte non è mai stata testata!
            elseif strcmp(model,'gauss_particle')
                sum=zeros(size_x, size_x);
                for x=1:size_x
                    for y=1:x
                        sum(x,y)=1;
                    end
                end
                
                vg_k=modelli.vg_k();
                vd_k=[1 1 1];
                part=vd_k.*(-sqrt(2/pi)/amb_wind_speed)
                H
                vg_k
                H_particle=ones(3,1)*H-(vg_k'*[1:1:size_x])
                
                sz_3=ones(3,1)*sz;
                (H_particle.^2)
                (2.*(sz_3.^2))
                
                int_data=1./(sz*exp(0.5*(H/sz)^2));
                
                tmp=int_data*sum';
                
                tot=exp(part.*(int_data*sum'));
                emiss=tot'*ones(1, 101);
            end
            emiss=emiss.*camino_emiss;
        end
		%calcolo del Vg per il particolato (NB: incompleta e mai testata)
        function vg=vg_k()
            p_dim=costanti.particle_dim*1e-3;
            p_dens=1.78e3;
            g=9.8;
            visc_aria=1.8e-5;
            vg=(p_dim.^2*g.*p_dens)/(18*visc_aria)
        end
%         function conc=gaussiano_vertical(x, y, zn, camino)
% %             y_vals=-5000:costanti.rescale:5000;
% %             x_vals=1:costanti.rescale:15000;
%             
%             [camino_h,camino_r,camino_dim,fumi_t,fumi_v,camino_emiss,amb_wind_speed,amb_terrain,amb_stability,amb_temp]=modelli.get_values(camino);
%             [sy,sz,H]=modelli.get_params(camino, x);
% 
%             conc=zeros(1,size(zn, 2));
%             iloop=0;
%             for z=zn
%                 iloop=iloop+1;
%                 z;
%                 %if z==1
% %                 z
% %                 H
% %                 z-H
% %                 tmp1=(z-H)^2
% %                 tmp2=sz^2
% %                 tmp3=tmp1/tmp2
% %                 tmp3*(-0.5)
%                           
%                 p1=camino_emiss/(2*pi*amb_wind_speed*sy*sz);
%                 p2a=exp(-0.5*(z-H)^2/sz^2);
%                 p2b=exp(-0.5*(z+H)^2/sz^2);
%                 p3=exp(-0.5*y^2/sy^2);
%                 %end
%                 conc(iloop)=p1*(p2a+p2b)*p3;
%             end
%         end
    end
end
