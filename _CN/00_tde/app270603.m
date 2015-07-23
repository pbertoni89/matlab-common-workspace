%% 1
clc, close all, clear all

t0 = 0; T = 50; tspan = [t0 T];
a = 10; b = 28; c = 8/3;
dy = @(t,y) [ a*(y(2)-y(1)); 
			  y(1)*(b-y(3)-y(2)); 
			  y(1)*y(2)-c*y(3)];

y0 = [-7 8 29]';
H = [ .06 .05 .01 .005 ]; NH = ceil((T-t0)./H);
colors = {'c','b','g','y'};

figure('name','EE'); 
for i=1:length(H)
	tic, [ tee yee ] =  eul_expl(dy, tspan, y0, NH(i)); toc
	
	if i==1, plot3(yee(1,1),yee(2,1),yee(3,1),'^r'), hold on, end
	plot3(yee(1,:),yee(2,:),yee(3,:),colors{i}) 
end
xlabel('x1'), ylabel('x2'), zlabel('x3'), grid on
legend('x_0','h=.06','h=.07','h=.01','h=.005'), axis tight

H = [ .005 ]; NH = ceil((T-t0)./H);
figure('name','AB2AM3'); 
for i=1:length(H)
	tic, [ taa yaa ] =  ab2am3(dy, tspan, y0, NH(i)); toc
	
	if i==1, plot3(yaa(1,1),yaa(2,1),yaa(3,1),'^r'), hold on, end
	plot3(yaa(1,:),yaa(2,:),yaa(3,:),colors{i}) 
end
xlabel('x1'), ylabel('x2'), zlabel('x3'), grid on
legend('x_0','h=.06','h=.07','h=.01','h=.005'), axis tight

yeq0 = [ 0 0 0];
% ora l'equilibrio di fuoco è pari a
yeq1 = [ 7.4099 7.4099 20.5901 ]; % i calcoli confermano
% per l'assoluta stabilità, linearizziamo... anche nell'intorno di 0.
JF = @(y) [ -a, a, 0; b-y(3)-y(2), -y(1), y(1); y(2), y(1), -c];

aval0 = eig(JF(yeq0)), aval1 = eig(JF(yeq1))


% con 6 variabili..
% c = 1.6e-19/1.67e-27;  b = 1.3e-7;
% A = zeros(6); A(1,4) = 1; A(2,5) = 1; A(3,6) = 1;
% A(4,2) = c*b; A(5,1) = -c*b;
% A, aval = eigs(A), figure, zplane(aval), hold on
% H0 = 2*abs(real(aval(1)))/(abs(aval(1)))^2
% Z0 = H0*aval(1) %, zplane(Z0)
% if abs(1+Z0)<= 1, disp('EE abs stabile')
% else disp('EE non abs stabile')
% end