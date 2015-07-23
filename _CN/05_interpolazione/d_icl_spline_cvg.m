clear all; close all; clc;

f = @(x) 1./(x.^2+1); fs = sym(f); f2s = diff(diff(fs))

xa = -5; xb = 5;

% Vogliamo ora stimare l'errore che si ha per interpolazione 
 %		composita lineare
 %		spline
% Secondo la teoria, se i nodi sono equispaziati,
 %		errmax ~ C*H^2 per la ICL
 %		errmax ~ C*H^4 per la spline
% e l'errore va in ragione 2 o 4 della distanza tra i nodi.

errmax_icl = []; errmax_s = [];
H = []; % vettore delle distanze tra i nodi

x1 = linspace(xa,xb,1000);
y1_f = f(x1);

for n = 20:10:10000
	x = linspace(xa,xb,n+1);
	y = f(x);
	H = [ H (xb-xa)/n];

	y1_icl = interp1(x,y,x1);
	y1_s   = spline(x,y,x1);

	%figure(1); clf;             % scommentare per tanti plot
	%plot(x,y,'ko'); hold on;
	%plot(x1,y1_f,'r');
	%plot(x1,y1_icl,'b');
	%plot(x1,y1_s,'g');
	%legend('x_i y_i','f(x)','icl','spline'); hold off;
	
	errmax_icl = [ errmax_icl max(abs(y1_f-y1_icl)) ];
	errmax_s   = [ errmax_s   max(abs(y1_f-y1_s  )) ];

	%pause;
end

figure('name','Storie!'); clf;
loglog(H, H.^2,'r'); grid on; hold on;
loglog(H, errmax_icl,'b'); 
loglog(H, errmax_s,'g');
legend('H','max |  y_f - y_{ICL}  |','max |  y_f - y_{S}  |');
% con H piccoli l'errore giustamente tende a zero.
% n= 4:2:20 è un po' basso, proviamo n = 20:10:1000

% per quanto riguarda ICL:
	% H = 10^(-1) => errmax ~ 2.5 10^(-3)
	% H = 10^(-2) => errmax ~ 2.5 10^(-5)
	% => errmax ~ H^2
	% come capire ora che errmax ~ C*H^2 ? 
	costante = errmax_icl./(H.^2);
	figure(3); clf;
	plot(H,costante); legend('E^{max}_{ICL}/H^2');
	% si ottiene una specie di retta con pendenza 1/5,
	% facciam finta che sia quasi costante.... Gervy dice sì
	%WRN: questa 'costante' NON è C! si guardi la formula
	
% tutto questo è falso: dividevo solo per H. ora divido per H.^2
% si vede qualcosa di non bellissimo: dove forse tendeva a una costante,
% inizia un'instabilità numerica sui dati...
