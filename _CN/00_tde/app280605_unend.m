%% 1
clc, close all, clear all

t0 = 0; T = 40; tspan = [t0 T];
dy = @protone;
playmovie = 0; % set 1 to play movie

x0 = [0 0 0]'; v0 = [1.e7 0 0]'; y0 = [ x0 ; v0];
h = [ .001]; Nh = ceil((T-t0)./h);

tic, [ trk4 yrk4 ] =  rk4(dy, tspan, y0, Nh); toc
tic, [ tee yee ] =  eul_expl(dy, tspan, y0, Nh); toc
% warning performances
%tic, [ tabam yabam ] = ab2am3(dy, tspan, y0, Nh); toc
tabam = tabam'; yabam = yabam';

figure('name','Runge Kutta / AB2AM3 / EE con H = .01'); 
plot3(yee(1,1),yee(2,1),yee(3,1),'^r'), hold on
xlabel('x1'), ylabel('x2'), zlabel('x3')
%axis([ -4e10 1e10 -17e9 1.5e9 -1 1])
if playmovie == 1
	nframes = length(trk4); Mv = moviein(nframes); speed = 1;
	for n = 1:speed:nframes
		plot3(yrk4(1,n),yrk4(2,n),yrk4(3,n),'b')
		plot3(yee(1,n),yee(2,n),yee(3,n),'g')
		plot3(yabam(1,n),yabam(2,n),yabam(3,n),'r')
		title(['t=',num2str(trk4(n))])
		Mv(:,n) = getframe;
	end
else
	plot3(yrk4(1,:),yrk4(2,:),yrk4(3,:),'b')
	plot3(yee(1,:),yee(2,:),yee(3,:),'g');
	plot3(yabam(1,:),yabam(2,:),yabam(3,:),'r');
end	
legend('x_0','x_{RK4}','x_{EE}') %, axis tight

% EE esplode via. Vediamo il problema come un sistema dx = Ax + b
% con 6 variabili..
c = 1.6e-19/1.67e-27;  b = 1.3e-7;
A = zeros(6); A(1,4) = 1; A(2,5) = 1; A(3,6) = 1;
A(4,2) = c*b; A(5,1) = -c*b;
A, aval = eigs(A), figure, zplane(aval), hold on
H0 = 2*abs(real(aval(1)))/(abs(aval(1)))^2
Z0 = H0*aval(1) %, zplane(Z0)
if abs(1+Z0)<= 1, disp('EE abs stabile')
else disp('EE non abs stabile')
end
% dobbiamo aver sbagliato ad impostare il sistema.
%% 2
clc, close all, clear all

%% 3
clc, close all, clear all