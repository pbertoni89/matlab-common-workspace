clear all; close all;

realiz= 10000;
istanti= [ -4.2 0 3];

dt= .01;
t= -10:dt:10;
f0 = .25;
Amp = 2;

Processo = randn( realiz, length(t) );

colors = {'b' 'g' 'r' 'c' 'm' 'y' 'k' }; %6 realizzazioni a caso

X= zeros( length(istanti), realiz); 

for k=1:length(istanti)
     X(k,:) = Processo(:,t==istanti(k)); 
    str = sprintf('PDF del processo RUMORE DIGITALE in t=%fs',istanti(k));
    myHist1D( X(k,:) ); title(str);
    fprintf('La media del rumore all istante %f è %f \n', istanti(k), mean( X(k,:) ) );
end

figure(4); hold on;
for k=1:1
    plot(t, Processo(k,:), colors{k} );
end
hold off;

pause;
close all;

% Autocorrelazione Rx ( t, t') con t fissato su t1,t2,t3 e t' libero
Rx= zeros( length(istanti), length(t));

for i=1:length(istanti)
    Rx(i,:) = mean(repmat(Processo(:,t==istanti(i)),[1 length(t)]).*Processo);
    str = sprintf('Autocorrelazione del processo RUMORE DIGITALE (funzione di t'') centrato in t=%fs',istanti(i));
    figure(i+1); plot(t-istanti(i),Rx(i,:)); title(str); axis([-15 15 -.1 1.5]);
end  
    % dal fatto che l'autocorrelazione TRASLA SOLAMENTE DI UN FATTORE t'
    % deduco che il rumore digitale è STAZIONARIO RISPETTO ALL'AUTOCORRELAZIONE.
    
    
 fprintf('Ergodicità:\n');
%% rispetto alla media ( prim'ordine)
for i=1:realiz * .01
   fprintf('La media della realizzazione %d è %f \n',i, mean( Processo(i,:) ) ); 
end
% il processo è ergodico rispetto alla media
   
%% rispetto all'autocorrelazione ( second'ordine)
phi_x = zeros(1,length(t));
caso = floor(rand(1)*realiz);

for k=1:length(t)
    phi_x(k) = integrale( conj(Processo(caso,:)) .* myshift( Processo(caso,:) , t(k)/dt), dt);  % non faccio fliplr E coniugo x(t)
end

phi_x= phi_x / 20 ;  % normalizzo la cross-correlazione rispetto al periodo (supporto totale, ovvero il dominio [-10,10]

% cerco di applicare Wiener Kinkin

figure(5); plot(t, phi_x, 'r' ); title('autocorrelazione del processo');   axis([-10 10 -.1 1.5])
hold off;
    
% Il rumore digitale è ergodico anche rispetto all'autocorrelazione

return;