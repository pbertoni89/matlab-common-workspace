clear all; close all; clc;

xa = 0; xb = 5;

f = @(x) 1./(1+(x-pi).^2);
g = @(x) sqrt(x);

% d2f = ...
% d2g = 1./(2*sqrt(x)); attenzione in 0...

Iex_f = 2.33976628367;
Iex_g = (2/3)*5^(3/2);

Mvet = 10:10:1000;

%% PM COMPOSITI
histErr_f = []; histErr_g = [];
for M = Mvet
	Iap_f =  i_c_pm(f,xa,xb,M);
	Iap_g =  i_c_pm(g,xa,xb,M);
	
	histErr_f   = [ histErr_f abs(Iex_f-Iap_f) ];
	histErr_g   = [ histErr_g abs(Iex_g-Iap_g) ];
end

H = (xb-xa)./Mvet; % è la stessa computata dentro i_c_pm
figure(1);
loglog(H,histErr_f,'r',H,histErr_g,'g',H,H.^2,'b'); 
grid on; title('Punto Medio Compositi');
legend('Err_f','Err_g', 'H^2');

% IMP INF
% si ha un break even tra le due storie in H~ 0.00365
% ma ha rilevanza??? cioè, oltre tale punto
% "la stima di g è relativamente migliore di quella di f"???

% Gervasio: NO, non ci interessa il valore assoluto dell'errore:
% è più importante conoscerne l'ordine di grandezza.

% la ragione vera di questo behaviour è:
% sqrt(x) non è derivabile in 0 
%	=> NON appartiene a C2([0,5])
%		=> non vale più la stima dell'errore di i_c_pm.

%% TRAP COMPOSITI
histErr_f = []; histErr_g = [];
for M = Mvet
	Iap_f =  i_c_trap(f,xa,xb,M);
	Iap_g =  i_c_trap(g,xa,xb,M);
	
	histErr_f   = [ histErr_f abs(Iex_f-Iap_f) ];
	histErr_g   = [ histErr_g abs(Iex_g-Iap_g) ];
end

H = (xb-xa)./Mvet; % è la stessa computata dentro i_c_pm
figure(2);
loglog(H,histErr_f,'r',H,histErr_g,'g',H,H.^2,'b'); 
grid on; title('Trapezi Compositi');
legend('Err_f','Err_g', 'H^2');

% si ha un comportamento assolutamente simile.

%% SIMPSON COMPOSITO

histErr_f = []; histErr_g = [];
for M = Mvet
	Iap_f =  simpsonc(xa,xb,M,f);
	Iap_g =  simpsonc(xa,xb,M,g);
	
	histErr_f   = [ histErr_f abs(Iex_f-Iap_f) ];
	histErr_g   = [ histErr_g abs(Iex_g-Iap_g) ];
end

H = (xb-xa)./Mvet; % è la stessa computata dentro i_c_pm
figure(3);
loglog(H,histErr_f,'r',H,histErr_g,'g',H,H.^2,'b'); 
grid on; title('Simpson Composito');
legend('Err_f','Err_g', 'H^2');

% g come sempre è fuori dalle regole (qui son derivate quarte..)
% l'errore su f dopo un po' inizia a cadere meno fortemente del Log.
% la derivata quarta di f è una funzione continua: f è C4
% sembra che l'errore si stabilizzarsi asintoticamente.

% Gervasio: l'asintoto è dovuto alla propagazione degli errori di
% arrotondamento, e non è vero che si si stabilizza: 
% con M sempre più grandi, tornerebbe a risalire!