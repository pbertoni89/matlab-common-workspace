clear all; close all; clc;

L = -2; % autovalore lambda
dy = @(t,y)  L*y;

t0 = 0;
T  = 10; % tn
y0 = 1;

y_ex = @(t) y0*exp(L*t);

H = [.01 .1 1 2]; N = ceil( (T-t0)./H );
%% studio di stabilità assoluta
% autovalore reale, pertanto 0 < h < -2/L = 1
% => i primi due H andranno bene, l'ultimo no, il terzo sempl. stabile
% (tutto questo soltanto per EulExpl

%% risoluzioni
i = 0;
for h = H, i=i+1;
	
	[ t  y_expl ] =  eul_expl(dy, [t0 T], y0, N(i));
	[ ~, y_impl ] =  eul_impl(dy, [t0 T], y0, N(i));
	[ ~, y_crni ] = crnk_nich(dy, [t0 T], y0, N(i));
	
	figure(1);
	subplot(2,2,i); 
	plot(t, y_expl,'b'); hold on;
	plot(t, y_impl,'g');  
	plot(t, y_crni,'r');
	title(['h=',num2str(h)]);
	if i==1,legend('EE','EI','CN'),end;
	
	figure(2);
	subplot(2,2,i); 
	title(['|1+h*L|, h=',num2str(h)]);
	zplane(1+h*L);
end
% si dimostra che EI,CN sono assolutamente stabili
% PER OGNI H > 0
% si dimostra che EE è assolutamente stabile solo se
% |1+HL| < 1