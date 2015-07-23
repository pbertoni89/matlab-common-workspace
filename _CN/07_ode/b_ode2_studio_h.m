clear all; close all; clc;

dy = @(t,y) t-y;
y_ex = @(t) t - 1 + 3*exp(-t-1);

t0 = -1;
T  =  5;
y0 =  1;

H = [1 .8 .5 .05 .01 .005 .001];
colors = {'b' 'g' 'r' 'c' 'm' 'y' 'k'};
err = [];
i = 1; % solo per colorare

for h = H
	
	Nh = ceil( (T-t0)/h );
	[ t_euler y_euler ] = eul_expl(dy, [t0 T], y0, Nh);
	y_exact = y_ex(t_euler);
	err = [ err max(abs(y_euler-y_exact)) ];
	
	plot(t_euler, y_euler,colors{i}); hold on; i = i+1;
end

% più dettagliata perchè ultima eseguita
plot(t_euler, y_exact,'k--','Linewidth',0.01);
legend('1','.8','.5','.05','.01','.005','.001','esatta');

figure(2); clf;
loglog(H, H,'g'); hold on; 
loglog(H, err);
legend('H','err');
	