clear all; close all; clc; format shorte;

t0 = 0; T = 10; tspan = [t0 T];
dy = @fun_ptosfera;
playmovie = 0; % set 1 to play movie

x0 = [0 1 0]';
v0 = [.8 0 1.2]';
y0 = [ x0 ; v0]; % concatenazione semplice delle condizioni iniziali.

%% Runge_Kutta4
h_rk4 = [.005 .0005];
N = ceil((T-t0)./h_rk4);

tic, [ t1_rk4 y1_rk4 ] =  rk4(dy, tspan, y0, N(1)); toc
tic, [ t2_rk4 y2_rk4 ] =  rk4(dy, tspan, y0, N(2)); toc

figure('name','Runge Kutta con H = .005'); 
[xsf,ysf,zsf] = mysphere(0,1); %[x y z] = sphere(150);

plot3(xsf,ysf,zsf,'y'); hold on; %mesh(x+3,y-2,z-1);
daspect([1 1 1]);
plot3(y1_rk4(1,1),y1_rk4(2,1),y1_rk4(3,1),'xr');
xlabel('x1'); ylabel('x2'); zlabel('x3');

if playmovie == 1
	nframes = length(t1_rk4);
	Mv = moviein(nframes);
	speed = 1;
	for n = 1:speed:nframes
		plot3(y1_rk4(1,n),y1_rk4(2,n),y1_rk4(3,n),'k');
		Mv(:,n) = getframe;
	end
	%movie(Mv,1);
else
	plot3(y1_rk4(1,:),y1_rk4(2,:),y1_rk4(3,:),'k');
end	

r_rk4(1) = max(abs(y1_rk4(1,:).^2 + ...
			 y1_rk4(2,:).^2 + ...
			 y1_rk4(3,:).^2 - 1));
r_rk4(2) = max(abs(y2_rk4(1,:).^2 + ...
			 y2_rk4(2,:).^2 + ...
			 y2_rk4(3,:).^2 - 1));
fprintf('RK4 con h = %d dà residuo %d\n',h_rk4(1),r_rk4(1));
fprintf('RK4 con h = %d dà residuo %d\n',h_rk4(2),r_rk4(2));
% la convergenza di RK4 è del quart'ordine 
% (in scala logaritmica la differenza tra il residuo e h^4
% è costante rispetto ad h;
%		costanza_rk4 = log10(r_rk4) - log10(h_rk4.^4)
% alternativamente si può fare questo discorso:
% supponiamo che h=1.e-2 dà res ~ 1.e-5
%	allora   se  h=1.e-3 dà res ~ 1.e-9   => p = 4
% cioè sono sceso di quattro ordini per ordine di h.
fprintf('ordine = (r1/r2) = 4 = %i\n',log10(r_rk4(1)/r_rk4(2)));

%% Eul_Expl
h_ee = [ .0025 .00025 ];
N = ceil((T-t0)./h_ee);

tic, [ t1_ee y1_ee ] =  eul_expl(dy, tspan, y0, N(1)); toc
tic, [ t2_ee y2_ee ] =  eul_expl(dy, tspan, y0, N(2)); toc

r_ee(1) = max(abs(y1_ee(1,:).^2 + ...
			 y1_ee(2,:).^2 + ...
			 y1_ee(3,:).^2 - 1));
r_ee(2) = max(abs(y2_ee(1,:).^2 + ...
			 y2_ee(2,:).^2 + ...
			 y2_ee(3,:).^2 - 1));
fprintf('EE con h = %d dà residuo %d\n',h_ee(1),r_ee(1));
fprintf('EE con h = %d dà residuo %d\n',h_ee(2),r_ee(2));
% la convergenza di EE è del prim'ordine 
% (in scala logaritmica la differenza tra il residuo e h^1
% è costante rispetto ad h;
%		costanza_ee = log10(r_ee) - log10(h_ee)
fprintf('ordine = (r1/r2) = 1 = %i\n',log10(r_ee(1)/r_ee(2)));

%% ODE 23 45 113, tolleranza default
disp('Default tolleranza per le ODE');
tic, [ t_ode23 y_ode23 ]   = ode23(dy, tspan, y0);  toc
tic, [ t_ode45 y_ode45 ]   = ode45(dy, tspan, y0);  toc
tic, [ t_ode113 y_ode113 ] = ode113(dy, tspan, y0); toc

r_ode23 = max(abs(y_ode23(:,1).^2 + ...
			 y_ode23(:,2).^2 + ...
			 y_ode23(:,3).^2 - 1))
r_ode45 = max(abs(y_ode45(:,1).^2 + ...
			 y_ode45(:,2).^2 + ...
			 y_ode45(:,3).^2 - 1)) 
r_ode113 = max(abs(y_ode113(:,1).^2 + ...
			 y_ode113(:,2).^2 + ...
			 y_ode113(:,3).^2 - 1)) 
% la 113 è consigliata per sistemi STIFF (dove step non minuscoli 
% causano grande casino e divergenza. Attenzione!)

% Metodi di ordine maggiore NON necessariamente riducono il residuo,
% ANZI ode45 peggiora.  >>orbite3d_gerv(t_ode45,y_ode45)
% testimonia che ode45 con tol=1.e-3 si allontana dalla sfera.
% Si noti dal residuo di ordine -1!!!

%% ODE 23 45 113, tolleranza più stretta
opt = odeset('RelTol',1.e-6);
disp('Miglioro la tolleranza per le ODE');
tic, [ t_ode23 y_ode23 ] =  ode23(dy, tspan, y0, opt); toc
tic, [ t_ode45 y_ode45 ] =  ode45(dy, tspan, y0, opt); toc
tic, [ t_ode113 y_ode113 ] =  ode113(dy, tspan, y0, opt); toc

r_ode23 = max(abs(y_ode23(:,1).^2 + ...
			 y_ode23(:,2).^2 + ...
			 y_ode23(:,3).^2 - 1))
r_ode45 = max(abs(y_ode45(:,1).^2 + ...
			 y_ode45(:,2).^2 + ...
			 y_ode45(:,3).^2 - 1)) 
r_ode113 = max(abs(y_ode113(:,1).^2 + ...
			 y_ode113(:,2).^2 + ...
			 y_ode113(:,3).^2 - 1)) 
% I rapporti di qualità si mantengono invariati: metodi di
% ordine maggiore non necessariamente riducono residuo,
% (aggiunta) nè necessariamente terminano più tardi.

format;