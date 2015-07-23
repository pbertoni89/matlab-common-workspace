clear all; close all; clc;

realiz= 10000;
istanti= [ -4.2 0 3];

dt = .01;
t= -10:dt:10;
f0 = .25;
Amp = 2;

Processo = zeros( realiz, length(t) );
X= zeros( length(istanti), realiz); 

Phase = rand( 1, realiz );
Phase = Phase * 2*pi;

colors = {'b' 'g' 'c' 'm' 'y' 'k' }; %6 realizzazioni a caso

%myHist1D(Phase);

for k=1:realiz
     Processo(k,:)= Amp * sin( 2*pi*.25*t + Phase(k) );
end

figure(1); hold on;
for k=1:length(colors)
    plot(t, Processo(k,:), colors{k} );
end
hold off;

for k=1:length(istanti)
     X(k,:) = Processo(:,t==istanti(k)); 
    str = sprintf('PDF del processo RUMORE DIGITALE in t=%fs',istanti(k));
    myHist1D( X(k,:) ); title(str);
    fprintf('La media del rumore all istante %f è %f \n', istanti(k), mean( X(k,:) ) );
end


% Autocorrelazione Rx ( t, t') con t fissato su t1,t2,t3 e t' libero
Rx= zeros( length(istanti), length(t));

figure(5); hold on;
for i=1:length(istanti)
    Rx(i,:) = mean(repmat(Processo(:,t==istanti(i)),[1 length(t)]).*Processo);
    str = sprintf('Autocorrelazione del processo RUMORE DIGITALE (funzione di t'') centrato in t=%fs',istanti(i));
    plot(t-istanti(i),Rx(i,:), colors{i}); title(str);
    %plot(t,Rx(i,:), colors{i}); title(str);
end  
    % dal fatto che l'autocorrelazione TRASLA SOLAMENTE DI UN FATTORE t'
    % deduco che il PAM è STAZIONARIO RISPETTO ALL'AUTOCORRELAZIONE.
    
 fprintf('Ergodicità:\n');
%% rispetto alla media ( prim'ordine)
for i=1:realiz * .01
   fprintf('La media della realizzazione %d è %f \n',i, mean( Processo(i,:) ) ); 
end
%% il processo è ergodico rispetto alla media
   
%% rispetto all'autocorrelazione ( second'ordine)
phi_circ_x = zeros(1,length(t));
caso = floor(rand(1)*realiz);

for k=1:length(t)
    phi_circ_x(k) = ( 1/(max(t)-min(t)) ) * integrale( conj(Processo(caso,:)) .* mycircshift( Processo(caso,:) , -t(k)/dt), dt);
end

% cerco di applicare Wiener Kinkin

plot(t, phi_circ_x, 'r' ); title('autocorrelazione del processo');  % axis([-10 10 -.1 1.5])
hold off;
    
%% la sinusoide a fase casuale è ergodico anche rispetto all'autocorrelazione

  
return;