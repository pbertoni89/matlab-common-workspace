clear all; close all;

realiz= 10000;
istanti= [ -4.2 0 3];
dt= .01;
t= -10:dt:10;

Phase = rand(realiz, 1 );
%Phase = Phase * 0;
%Phase = sè stessa
Phase = Phase * 2;

A = 2;
Amp = rand(realiz, 1) * 2*A - A;  % uniforme da [-A,A]

colors = {'b' 'g' 'c' 'm' 'k' }; %6 realizzazioni a caso

myHist1D(Amp); title('pdf dell ampiezza casuale');

X= zeros( length(istanti), realiz); 

Processo = zeros( realiz, length(t) );

for i=1:realiz
    for k=-5:4
        Processo(i,:)= Processo(i,:) + (rand(1)*2*A-A) * rect( t - 2*k - Phase(i) );
    end
end

for j=1:length(istanti)
    X(j,:) = Processo( :, t==istanti(j) );
    str = sprintf('PDF del processo PAM RETURN ZERO in t=%fs',istanti(j));
    myHist1D( X(j,:) ); title(str);
    fprintf('La media del PAM all istante %f è %f \n', istanti(j), mean( X(j,:) ) );
end

figure(5); hold on;
for k=1:length(colors)
    plot(t, Processo(k,:), colors{k} );
end
hold off;

% Autocorrelazione Rx ( t, t') con t fissato su t1,t2,t3 e t' libero
Rx= zeros( length(istanti), length(t));
figure(6); hold on;
for i=1:length(istanti)
    Rx(i,:) = mean(repmat(Processo(:,t==istanti(i)),[1 length(t)]).*Processo);
    str = sprintf('Autocorrelazione del processo PAM RETURN ZERO (funzione di t'') centrato in t=%fs',istanti(i));
    plot(t-istanti(i),Rx(i,:), colors{i}); title(str); axis([-10 10 -.1 .8]);
end  
    % dal fatto che l'autocorrelazione TRASLA SOLAMENTE DI UN FATTORE t'
    % deduco che il PAM è STAZIONARIO RISPETTO ALL'AUTOCORRELAZIONE.
    
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

phi_x= phi_x / 12 ;  % normalizzo la cross-correlazione rispetto al periodo (supporto totale, ovvero il dominio [-10,10]

% cerco di applicare Wiener Kinkin

plot(t, phi_x, 'r' ); title('autocorrelazione del processo');   axis([-10 10 -.1 .8])
hold off;
    
% Il rumore digitale è ergodico anche rispetto all'autocorrelazione    
    
    
return;