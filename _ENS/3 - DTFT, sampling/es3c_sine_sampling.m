% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 3c: DTFT

clear; clc; close all;

t_start = cputime;

%% SAMPLING ALGORITHM

 %time
step = 1e-6;
t = 0 : step : ( 1e-2 ) ;  % da 0 a 10 ms con passo 0.1 ms. 
t_elapsed = t(length(t)) - t(1);

 %frequency
f =  -1.1 : .01 : 1.1; 
f0 = 2300:500:5800 ;  % Hertz.
fs = 8000 ;           % Hertz.
band= [-.5,.5]; % aiuta a identificare spettro base

 %samples
nc = t_elapsed * fs; % numero di campioni
n = 0 : 1 : nc ; % campioni del segnale.
n_sc = n/fs;     % n scaled, è una normalizzazione che associa i campioni al loro istante effettivo.


 %cycle
for i = 1:length(f0)

    figure(i);
        x  = sin ( 2 * pi * f0(i) * t);           % segnale analogico
        xc = sin ( 2 * pi * f0(i) * (n/fs) );     % segnale campionato = sequenza
        Xc = dtft( xc, n, f );                    % spettro del segnale
        Xr = Xc .* my_rect(f);                 % spettro base del segnale
        xr = antidtft( Xr, n, f);                 % sequenza ricostruita
  
        subplot( 1, 3, 1 ); plot(t,x,'b--'); hold on; stem( n/fs ,xc,'r'); title( f0(i) ,'FontSize',18);
        subplot( 1, 3, 2 ); plot(f,Xc,'g');  hold on; plot(f,Xr,'k'); axis('tight'); title( 'specter' ,'FontSize',18);
        subplot( 1, 3, 3 ); stem( n/fs ,xc,'r'); hold on; stem( n/fs ,xr,'g'); title( 'antidtft' ,'FontSize',18);
        
end       

fprintf ( 'Elapsed CPU time = %f\n', cputime - t_start );
return;