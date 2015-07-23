clear all; close all; clc;

dy = @(t,y) t-y;
y_ex = @(t) t - 1 + 3*exp(-t-1);

t0 = -1;
T  =  5;
y0 =  1;

h = 1.e-3; 
Nh = ceil( (T-t0)/h );

[ t_euler y_euler ] = eul_expl(dy, [t0 T], y0, Nh);

y_exact = y_ex(t_euler);

errore = max(abs( y_euler - y_exact ))

figure(1); clf;
plot(t_euler, y_euler,'r'); hold on;
plot(t_euler, y_exact,'b');
legend('eulero','esatta')

%% Confronto ordine errori (autonomo)

H = [1.e-2,1.e-3,1.e-4,1.e-5]; 
Nh_vet = ceil((T-t0)./H); errore = [];

for Nh = Nh_vet
	tic
	[ t_euler y_euler ] = eul_expl(dy, [t0 T], y0, Nh);
	y_exact = y_ex(t_euler);
	errore = [ errore max(abs( y_euler - y_exact ))];
	toc
end

figure();
plot(H,errore);
% l'errore di EE cresce COME H