clear all; close all; clc;
%  crescita       interazione     nutrizione
c1 = 2; c2 = 1; d1 = 1; d2 = 2; b1 = 0; b2 = 0; y0 = [2 2]; 
t0 = 0; 
dy = @(t,y) [ +c1*y(1)*(1 - b1*y(1) -d2*y(2)) ;
			  -c2*y(2)*(1 - b2*y(2) -d1*y(1)) ];
		  
h_rk4 = 1.e-2; % sembra bassa, ma il metodo si comporta come h^4 ...

%% T = 80
T = 80; % provare anche con 10
N_rk4 = ceil((T-t0)./h_rk4);

[ t_4 y_4 ] =  rk4(dy, [t0 T], y0, N_rk4);
[ t_23 y_23 ] =  ode23(dy, [t0 T], y0);
[ t_45 y_45 ] =  ode45(dy, [t0 T], y0);

figure('name','Andamenti per T = 80');
plot(t_4,y_4(1,:),'r'); hold on;
plot(t_23,y_23(:,1),'b');
plot(t_45,y_45(:,1),'g');

legend('y_1^{RK4}(t)','y_1^{O23}(t)','y_1^{O45}(t)');

figure('name','Traiettoia ODE23 per T = 80')
plot(y_23(:,1),y_23(:,2),'b');
   
% tol default è 1.e-3; non avendone date ai due ode, viene presa quella.
% con questo h, i risultati migliori si hanno con RK4. 
% Infatti h = 1e-2 che elevato alla quarta è 1.e-8 << 1.e-3

% simulando con T maggiori si nota che si perde corrispondenza tra le
% soluzioni. Vogliamo provare a migliorare un metodo adattivo!
% si noti lo sfasamento tra i diversi metodi:
%	ode45 anticipa le soluzioni; ode23 le ritarda.

% un'idea dell'imprecisione dei metodi odexy ci viene anche dalla
% "grossolanità" delle traiettorie (piano delle fasi per Gervasio).
% Ora plottiamo le traiettorie per ode23 adattata.

%% modifica della tolleranza per l'adattività:
tol_des = 1.e-6;
options = odeset('RelTol',tol_des);
[t_des y_des] = ode23(dy, [t0 T], y0, options);

figure('name','Traiettoia ODE23 per T = 80, tol = 1.e-6')
plot(y_des(:,1),y_des(:,2),'b');

% le immagini parlano da sè...

%figure(3);