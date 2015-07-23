clear all; close all; clc;
% analisi up/down wind in base a h SPAZIALE

for test = 1:6

	switch test
		case 0,
			%% in laboratorio
% 			g = @(x,y,t) sin(pi*x.*y);
% 			f = @(x,y,t) (mu*pi^2)*(x.^2+y.^2).*sin(pi*x.*y) + ...
% 			   pi  *(x.^2-y.^2).*cos(pi*x.*y);
% 			b1 = @(x,y) 1 + 0*x; b2 = @(x,y) 1 + 0*x;
% 			nrm = norm([1 1]);
% 			u0 = @(x,y)10*(abs((x+0.2).^2+(y+0.2).^2)<0.01);     
% 			ht = 1.e-2; tspan = [0 1];
% 			mu = 0.1; space = [0 1 0 1]; nx = 100;
		case 1,
			%% src nulla; trasp 1,1; u0 circolare
			g = @(x,y,t) 0*t;
			f = @(x,y,t) 0*t;
			b1 = @(x,y) 1 + 0*x; b2 = @(x,y) 1 + 0*x;
			nrm = norm([1 1]);
			u0 = @(x,y)10*(abs((x+0.2).^2+(y+0.2).^2)<0.002);     
			ht = 5.e-3; tspan = [0 2];
			mu = 1.e-1; space = [-1 10 -1 10]; nx = 200; % upwind
			% difatti la direzione del vento � positiva e il rapporto
			% incrementale usato per la parte evolutiva segue tale dir
			
		case 2,
			%% src nulla; trasp -1,-1; ; u0 circolare; warning
			% NON upwind a priori; osserviamo la direzione del vento.
			% perch� non si generino oscillazioni spurie si deve
			% avere un h < 2*mu/norm(b)
			% Qualora b sia variabile � buona cosa che questa condiz
			% sia sempre verificata...
			g = @(x,y,t) 0*t;
			f = @(x,y,t) 0*t;
			b1 = @(x,y) -1 + 0*x; b2 = @(x,y) -1 + 0*x;
			nrm = norm([-1 -1]);
			u0 = @(x,y)10*(abs((x+0.2).^2+(y+0.2).^2)<0.01);     
			ht = 5.e-3; tspan = [0 1];
			mu = 1.e-2; space = [-1 1 -1 1];
			nx = 100; % oscillazioni spurie
			% difatti (1-(-1))/100 > 2*mu/norm(b)    0.02 > 0.014
			nx = 150; % no oscillazioni
		case 3,
			%% src nulla; trasp -y,x; ; u0 circolare
			g = @(x,y,t) 0*t;
			f = @(x,y,t) 0*t;
			b1 = @(x,y) -1*y; b2 = @(x,y) 1*x;
			u0 = @(x,y)10*(abs((x+0.5).^2+(y+0.5).^2)<0.01);     
			ht = 5.e-2; tspan = [0 10];
			mu = 1.e-2; space = [-1 1 -1 1]; nx = 100;
		case 4,
			%% src sin; trasp -y,x; u0 circolare
			g = @(x,y,t) 0*t;
			f = @(x,y,t) 10*(sin(t)+2).* ...
						 (abs((x+0.5).^2+(y+0.5).^2)<0.01);     
			b1 = @(x,y) -1*y; b2 = @(x,y) 1*x;
			u0 = @(x,y) 0*x + 0*y;
			ht = 5.e-2; tspan = [0 10];
			mu = 1.e-1;  space = [-1 1 -1 1]; nx = 100;
			% provare con mu = 1.e-1
		case 5,
			%% due src; trasp -y,x; u0 nulla
			g = @(x,y,t) 0*t;
			f = @(x,y,t) 20*(sin(t)+2).* ...
						 (abs((x+0.5).^2+(y+0.5).^2)<0.01) + ...
						 20*(sin(t)+2).* ...
						 (abs((x-0.6).^2+(y-0.6).^2)<0.01);
			b1 = @(x,y) -1*y; b2 = @(x,y) 1*x;
			u0 = @(x,y) 0*x + 0*y;
			ht = 5.e-2; tspan = [0 30];
			mu = 1.e-2;  space = [-1 1 -1 1]; nx = 100;
		case 6,
			%% due src; trasp nullo; u0 nulla
			g = @(x,y,t) 0*t;
			f = @(x,y,t) 20*(sin(t)+2).* ...
						 (abs((x+0.5).^2+(y+0.5).^2)<0.01) + ...
						 20*(sin(t)+2).* ...
						 (abs((x-0.6).^2+(y-0.6).^2)<0.01);
			b1 = @(x,y) 0*y; b2 = @(x,y) 0*x;
			u0 = @(x,y) 0*x + 0*y;
			ht = 5.e-2; tspan = [0 30];
			mu = 1.e-2;  space = [-1 1 -1 1]; nx = 150;
	end
	fprintf('lancio test: %i\n', test); pause;
	%fprintf(' mu = %d, |b| = %d', mu, norm(b))
	figure(test);
	dte(f, g, b1, b2, u0, ht, tspan, mu, space, nx)
end