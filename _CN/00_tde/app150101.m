%% 1
clear all; close all; clc

y0 = [1 0];
t0 = 0; T = 25;

%1
mu = 0; om2 = 4; E = 0;
dy = @(t,y) [y(2); E*pi*cos(120*pi*t)-om2*y(1)-mu*y(2)];
fex = @(t,y) cos(2*t);
H = [1.7 1.3 .5 .05 .01 .001]; conv = zeros(1,length(H));

for i = 1:length(H), tic
	n = ceil((T-t0)/H(i));
	[t y] = lawson(dy,[t0 T],y0,n); yex = fex(t);
	conv(i) = max(abs(yex-y(:,1)));
	
	subplot(3,2,i);
	plot(t,y(:,1),'r',t,yex,'g'), ylabel('y')
	title(['h=',num2str(H(i))])
	if i==1, legend('y','y_{ex}'), end, toc
end

figure, loglog(H,H,'b',H,H.^2,'r',H,H.^3,'g',H,H.^4,'y',H,H.^5,'c')
hold on, loglog(H,conv,'k'), legend('h','h^2','h^3','h^4','h^5','Er')

% il metodo converge con ordine 5. Per H eccessivamente piccoli,
% si ha una propagazione degli errori d'arrotondamento..

%% 2 
% gli autovalori del sistema A=[0 1; -4 0] sono +- 2j.
% a prima vista allora h*L deve stare tra -1j e 1j 
% (regione simmetrica sempre) oppure tra 2j e 3j.
% le soglie quindi sono 
% { h*2j < 1j => 0 < h < .5
% { h*2j > 2j => h > 1
% { h*2j < 3j => h < 1.5

%% 3
mu = 101; om2 = 100; E = 0; C1 = 100/99; C2 = -1/99; T = 5;
dy = @(t,y) [y(2); E*pi*cos(120*pi*t)-om2*y(1)-mu*y(2)];
fex = @(t,y) C1*exp(-t)+C2*exp(-100*t); tol = 1.e-5;
H = [1.7 1.3 .5 .05 .01 .001]; conv = zeros(1,length(H));
A = [0 1; -om2 -mu]; eig(A) % come ci aspettavamo da fex()
% non ho gli strumenti per affrontare questo problema.