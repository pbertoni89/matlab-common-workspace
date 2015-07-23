clc, close all, clear all

m = 90; g = 9.81; t0 = 0; y0 = [ 1200 0];
K = @attrito220604;

%1
T = 150; tp = 15;
dy = @(t,y) [ y(2); (1/m)*(-m*g-K(t,tp)*y(2))];

h = .1; Nh = ceil((T-t0)/h);
[ t_ee y_ee ] =  eul_expl(dy, [t0 T], y0, Nh);

figure(1)
subplot(1,2,1), plot(t_ee,0*t_ee,'k',t_ee,y_ee(1,:),'r'), hold on
subplot(1,2,2), plot(t_ee,y_ee(2,:),'g'), hold on
	
fprintf('velocità all''atterraggio: %d\n', y_ee(2,end));

%2
T = 30; tp = 31; % oltre tempo 
dy = @(t,y) [ y(2); (1/m)*(-m*g-K(t,tp)*y(2))];

h = .1; Nh = ceil((T-t0)/h);
[ t_ee y_ee ] =  eul_expl(dy, [t0 T], y0, Nh);

subplot(1,2,1), plot(t_ee,0*t_ee,'k',t_ee,y_ee(1,:),'r--')
subplot(1,2,2), plot(t_ee,y_ee(2,:),'g--'), title('v')