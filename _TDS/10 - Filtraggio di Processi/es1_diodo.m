clear all; close all;

realiz= 10000;
istanti= [ -4.2 0 3];
dt= .01;
t= -10:dt:10;

t0 = rand(realiz, 1 ) - 1/2;

A = 2;

colors = {'b' 'g' 'k' 'c' 'm' 'r' }; %6 realizzazioni a caso

X= zeros( length(istanti), realiz); 

Processo = zeros( realiz, length(t) );

for i=1:realiz
    for k=-6:6
        Processo(i,:)= Processo(i,:) + (rand(1)*2*A-A) * my_rect( t - 1/2 - k - t0(i) );
    end
end

%% FILTRAGGIO CON DIODO
for i=1:realiz
    for j=1:length(t)
        if Processo(i,j)<0
            Processo(i,j) = 0;
        end
    end
end

for j=1:length(istanti)
    X(j,:) = Processo( :, t==istanti(j) );
    str = sprintf('PDF del processo PAM DIODE FILTERED in t=%fs',istanti(j));
    % dalla somiglianza pseudocasuale delle PDF, deduco la STAZIONARIETA' IN SENSO STRETTO
    % le delta di dirac in zero nascono dal "condensamento" in 0 di tutti i
    % valori negativi. il resto dei valori possibili è spalmato su [0,2]
    myHist1D( X(j,:) ); title(str);
    fprintf('La media del PAM diode filtered all istante %f è %f \n', istanti(j), mean( X(j,:) ) );
end  % dalla vicinanza tra i valori delle medie campionarie, deduco la STAZIONARIETA' IN SENSO LATO (RISPETTO ALLA MEDIA)

% disegno alcune realizzazioni del processo
figure(5); hold on;
for k=1:length(colors)
    plot(t, Processo(k,:), colors{k} );
end
hold off;

%% Stazionarietà rispetto all'autocorrelazione Rx ( t, t') con t fissato su t1,t2,t3 e t' libero
Rx= zeros( length(istanti), length(t));

figure(6); hold on;
for i=1:length(istanti)
    Rx(i,:) = mean(repmat(Processo(:,t==istanti(i)),[1 length(t)]).*Processo);
    str = sprintf('Autocorrelazione del processo PAM DIODE FILTERED (funzione di t'') centrato in t=%fs',istanti(i));
    plot(t-istanti(i), Rx(i,:), colors{i}); title(str); axis([-15 15 -.1 1]);
end  
    % dal fatto che l'autocorrelazione TRASLA SOLAMENTE DI UN FATTORE t'
    % deduco che il Processo è STAZIONARIO RISPETTO ALL'AUTOCORRELAZIONE.
    
       
   fprintf('Ergodicità:\n');
%% rispetto alla media ( prim'ordine)
for i=1:realiz * .01
   fprintf('La media della realizzazione %d è %f \n',i, mean( Processo(i,:) ) ); 
end
% ho perso ergodicità del prim'ordine!!
   
%% rispetto all'autocorrelazione
phi_x = zeros(1,length(t));
caso = floor(rand(1)*realiz);

for k=1:length(t)
    phi_x(k) = integrale( conj(Processo(caso,:)) .* myshift( Processo(caso,:) , -t(k)/dt), dt);  % non faccio fliplr E coniugo x(t)
end

phi_x= phi_x / 20;  % normalizzo la cross-correlazione rispetto al periodo (supporto totale del frammento di processo PAM)
% il numero che razionalizza è esattamente il numero di rettangoli
% disegnati dal PAM!!!!! MENO UNO

% cerco di applicare Wiener Kinkin

plot(t, phi_x, 'r' ); title('autocorrelazione del processo');  axis([-10 10 -.5 1.5])
hold off;

return;