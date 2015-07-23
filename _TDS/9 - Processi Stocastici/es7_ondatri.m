clear all; close all; clc;

realiz= 10000;
istanti= [ -4.2 0 3];
dt= .01;
t= -10:dt:10;

Phase = rand(realiz, 1 );
%Phase = Phase * 0;
%Phase = sè stessa
Phase = Phase * 4;

A = 2;
Amp = rand(realiz, 1) * 2*A - A;  % uniforme da [-A,A]

colors = {'b' 'g' 'c' 'm' 'k' }; %6 realizzazioni a caso

% myHist1D(Amp); title('pdf dell ampiezza casuale');

X= zeros( length(istanti), realiz); 

Processo = zeros( realiz, length(t) );

for i=1:realiz
    for k=-5:4
         Processo(i,:)= Processo(i,:) + (rand(1)*2*A-A)* tri( t - 2*k - Phase(i) );
       % Processo(i,:)= Processo(i,:) +                  tri( t - 2*k - Phase(i) );
    end
end

fprintf('\n******************************************\nStazionarietà in senso lato del primo ordine\n');
for j=1:length(istanti)
    X(j,:) = Processo( :, t==istanti(j) );
    str = sprintf('PDF del processo in t=%fs',istanti(j)); % le variabili casuali
    % agli istanti decisi sono indipendenti e identicamente distribuite; quindi hanno la stessa pdf,
    % => il processo è stazionario in SENSO STRETTO
    myHist1D( X(j,:) ); title(str);
    fprintf('La media del processo onda triangolare all istante %f è %f \n', istanti(j), mean( X(j,:) ) );
    % sapevo già che senso stretto => dimostro comunque il senso LATO (qua del prim'ordine)
end

figure(5); title('Alcune realizzazioni del processo'); hold on;
for k=1:length(colors)
    plot(t, Processo(k,:), colors{k} );
end
hold off;

% Autocorrelazione Rx ( t, t') con t fissato su t1,t2,t3 e t' libero
Rx= zeros( length(istanti), length(t));
figure(6); title('Autocorrelazione del processo ONDA TRIANGOLARE (funzione di t'') centrato negli istanti [-4.2 0 3]'); hold on;

for i=1:length(istanti)
    Rx(i,:) = mean(repmat(Processo(:,t==istanti(i)),[1 length(t)]).*Processo);    
    plot(t-istanti(i),Rx(i,:), colors{i}); axis([-10 10 -.1 .8]);
end  
    % dal fatto che l'autocorrelazione TRASLA SOLAMENTE DI UN FATTORE t'
    % deduco che l'onda tri è STAZIONARIA RISPETTO ALL'AUTOCORRELAZIONE.
    
    
fprintf('\n******************************************\nErgodicità in senso lato del primo ordine\n');
%% rispetto alla media ( prim'ordine)
for i=1:realiz * .01
   fprintf('La media della realizzazione %d è %f \n',i, mean( Processo(i,:) ) ); 
end
% il processo è ergodico rispetto alla media perchè la media è la stessa,
% per ogni realizzazione.
   
%% rispetto all'autocorrelazione ( second'ordine)
phi_x = zeros(1,length(t));
caso = floor(rand(1)*realiz);

for k=1:length(t)
    phi_x(k) = integrale( conj(Processo(caso,:)) .* myshift( Processo(caso,:) , t(k)/dt), dt);
end

phi_x= phi_x / 20 ;  % normalizzo la cross-correlazione rispetto al periodo (supporto totale, ovvero il dominio [-10,10]

% cerco di applicare Wiener Kinkin

plot(t, phi_x, 'r' ); title('autocorrelazione del processo per confronto ergodicità');   axis([-10 10 -.1 .8])
hold off;
    
% l'onda tri a fase casuale è ergodica anche rispetto all'autocorrelazione    
% se anche l'ampiezza diventa casuale uniforme su [-A,A] con A reale,
% questa proprietà viene persa

%  Attenzione: in alcune esecuzioni del programma si ha un'ottima
%  approssimazione visiva, in altre molto meno! provare a lanciare più
%  volte
%   
%

return;