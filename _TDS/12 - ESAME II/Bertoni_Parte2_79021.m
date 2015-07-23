
% Patrizio Bertoni 79021 INFLT2

% inizializzazioni

clear all;
close all;

% Assi del tempo e frequenza
dt= .01; df=dt;
t= -10:dt:10;
f= -15:df:15;

    
%% %% %% ESERCIZIO 1

%% i)  .....

% analiticamente ho trovato:  
% 
%     a(1) = 0  b(1) = -2
%     a(-1)= 0  b(-1)=  2 
%     
%     a(3) = -3/2 = a(-3)
%     a(-3) = 0 = b(-3)
    
% inserirli con ciclo e verificare


 % nb  % è INUTILE calcolare il segnale errore. il segnale x2 è combinazione
    % lineare di armoniche, con periodo in rapporto razionale.

    
%% ii)

% è più conveniente la forma con gli Ak/Bk: sfruttiamo la disparità del
% segnale base

T=4;
x2= zeros(1,length(t)); 
x2Serie= x2; 
errore= x2;

 for k=-10:9
         x2= x2 + 1* tri( t - 2*k -1 ) -  1* tri( t + 2*k  );   
 end
 
n_arm= 30;

Ak = zeros(n_arm,1); Bk = Ak;

x2base= tri(t-1) - tri(t+1);
 
for k = 1:n_arm
    
    %Ak(k) = (1/T) * integrale( x2base .* cos(2*pi*(k/T)*t),dt);
    % i prodotti scalari sono teoricamente nulli
    Bk(k) = (1/T) * integrale( x2base .* sin(2*pi*(k/T)*t),dt);
    
    %X0=0;
    %x2Serie = x2Serie + 2*Ak(k)*cos(2*pi*(k/T)*t) + 2*Bk(k)*sin(2*pi*(k/T)*t);
    x2Serie = x2Serie                              + 2*Bk(k)*sin(2*pi*(k/T)*t);
end

errore = x2 - x2Serie;
    
str= sprintf('Segnale x2 con %d armoniche', n_arm);
figure('name', str);
subplot(1,3,1); plot(t, x2, 'b'); title('$$x2$$','Interpreter','latex','FontSize',20); axis( [-6.5 6.5 -5 5] )
subplot(1,3,2); plot(t, x2, 'b'); hold on;  plot(t, x2Serie, 'r'); title('$$SdF$$','Interpreter','latex','FontSize',20); axis( [-6.5 6.5 -5 5] ); hold off;
subplot(1,3,3); plot(t, errore, 'g'); title('$$segnale\ errore$$','Interpreter','latex','FontSize',20); axis( [-6.5 6.5 -5 5] )


pause; close all;
%% %% %% ESERCIZIO 2
% i ) processo 1

realiz= 10000;
istanti= [ -2.3 0 3.2];

f0 = .25;

U= rand(1,realiz);
Amp= zeros(1,realiz);

for k=1:realiz
   if ( U(k) < .5 )
       Amp(k) = 1;
   else
       Amp(k) = rand(1,1) *2 ;  % unif [0,2] con metà dei valori di U
   end
end


Processo = zeros( realiz, length(t) );
X= zeros( length(istanti), realiz); 

colors = {'b' 'g' 'c' 'm' 'y' 'k' }; %6 realizzazioni a caso

myHist1D(Amp);

for k=1:realiz
     Processo(k,:)= Amp(k) * sin( 2*pi*f0*t);
end

figure(1); title('Alcune realizzazioni del processo'); hold on;
for k=1:length(colors)
    plot(t, Processo(k,:), colors{k} );
end
hold off;

for k=1:length(istanti)
     X(k,:) = Processo(:,t==istanti(k)); 
    str = sprintf('PDF del processo P1 in t=%fs',istanti(k));
    % il processo non è stazionario in senso stretto. Le pdf associate alle
    % variabili causali negli istanti (...) non sono le stesse
    myHist1D( X(k,:) ); title(str);
    fprintf('La media del processo P1 all istante %f è %f \n', istanti(k), mean( X(k,:) ) );
    % le medie dipendono dal tempo, non si ha nemmeno stazionarietà in
    % senso lato del primo ordine.
end


% Autocorrelazione Rx ( t, t') con t fissato su t1,t2,t3 e t' libero
Rx= zeros( length(istanti), length(t));

figure(5); hold on;
for i=1:length(istanti)
    Rx(i,:) = mean(repmat(Processo(:,t==istanti(i)),[1 length(t)]).*Processo);
    str = sprintf('Autocorrelazione del processo P1 (funzione di t'')');
    plot(t-istanti(i),Rx(i,:), colors{i}); title(str);
end  
    % l'autocorrelazione dipende dal tempo e non solo dalla differenza di
    % tempo; => NO STAZIONARIETA' DEL SECOND ORDINE
    
    
 fprintf('Ergodicità del prim ordine:\n');
 
for i=1:realiz * .1
   fprintf('La media della realizzazione %d è %f \n',i, mean( Processo(i,:) ) ); 
end
% il processo sembra ergodico rispetto alla media
   
pause; close all; clc;

%% ii) processo 2

% sono avvantaggiato perchè la fase casuale spazia proprio sul periodo 4

Amp2 = 2;

Processo = zeros( realiz, length(t) );
X= zeros( length(istanti), realiz); 

Phase = rand( 1, realiz );
Phase = Phase * (1/f0) *pi;

colors = {'b' 'g' 'c' 'm' 'y' 'k' }; %6 realizzazioni a caso

%myHist1D(Phase); è uniforme

for k=1:realiz
     Processo(k,:)= Amp2 * sin( 2*pi*.25*t + Phase(k) ); title('Alcune realizzazioni del processo P2');
end

figure(1); hold on;
for k=1:length(colors)
    plot(t, Processo(k,:), colors{k} );
end
hold off;

for k=1:length(istanti)
     X(k,:) = Processo(:,t==istanti(k)); 
    str = sprintf('PDF del processo P2 in t=%fs',istanti(k));
    % ho stazionarietà in senso stretto, le VC associate agli istanti(...)
    % sono IDENTICAMENTE DISTRIBUITE.
    % questo implica anche il senso lato, ma vediamolo comunque
    myHist1D( X(k,:) ); title(str);
    fprintf('La media dell processo P2 all istante %f è %f \n', istanti(k), mean( X(k,:) ) );
    % stazionarietà senso lato prim ordine. I valori sono buoni a meno dei
    % centesimi.
end


% Autocorrelazione Rx ( t, t') con t fissato su t1,t2,t3 e t' libero
Rx= zeros( length(istanti), length(t));

figure(5); hold on;
for i=1:length(istanti)
    Rx(i,:) = mean(repmat(Processo(:,t==istanti(i)),[1 length(t)]).*Processo);
    str = sprintf('Autocorrelazione del processo P2 (funzione di t'')');
    plot(t-istanti(i),Rx(i,:), colors{i}); title(str);
end  
    % dal fatto che l'autocorrelazione TRASLA SOLAMENTE DI UN FATTORE t'
    % deduco che il processo P2 è STAZIONARIO RISPETTO ALL'AUTOCORRELAZIONE.
    
 fprintf('Ergodicità del prim ordine:\n');
for i=1:realiz * .01
   fprintf('La media della realizzazione %d è %f \n',i, mean( Processo(i,:) ) ); 
end
% il processo è ergodico rispetto alla media



%% QUIT
return;
