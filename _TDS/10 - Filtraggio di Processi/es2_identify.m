
clear all; close all; clc;

realiz= 1000;
istanti= [ -4.2 0 3];

sigma = 3; % radice deviazione standard del rumore: perchè? sono decibel?

dt= .01; t= -10:dt:10;
tEsteso = min(t)*2:dt:max(t)*2;

Ingresso = randn( realiz, length(t) ); % Digital noise in ingresso: tutto stazionario ed ergodico
Uscita =   zeros( realiz, length(t) );

colors = {'b' 'g' 'r' 'c' 'm' 'y' 'k' }; %6 realizzazioni a caso

%% FILTRAGGIO IN UN SISTEMA LTI INCOGNITO    
    
%Rxy = zeros(length(t));  % è una matrice quadrata!
Rxy = zeros(realiz, length(t));  % è una matrice quadrata!
RxyStima = zeros(1,length(tEsteso));

for i=1:realiz  % passaggio nel sistema
    Uscita(i,:)= filtroMisterioso(Ingresso(i,:),t);
end
    
Y= zeros( length(istanti), realiz); 

fprintf('\n*****************\nStazionarietà dell''uscita\n');
for k=1:length(istanti)
     Y(k,:) = Uscita(:,t==istanti(k)); 
    fprintf('La media dell uscita all istante %f è %f \n', istanti(k), mean( Y(k,:) ) );
end

caso = floor(rand(1)*realiz);
figure(2);
subplot(1,2,1); plot(t, Ingresso(caso,:), 'b' ); title('Possibile ingresso');
subplot(1,2,2); plot(t, Uscita(caso,:) , 'r' ); title('Uscita associata');

fprintf('processing correlazioni...\n');

for i = 1:length(t)
    
    if mod(i,100) == 0
        fprintf('i=%d\n',i);
    end
    
    Rxy(i,:) = ( (Ingresso(:,i))' * Uscita )/ realiz;  % per ogni istante, faccio il prodotto matriciale [ Ingresso(t+tau) . Uscita(t) ]
  
    RxyStima( length(t)-i+1 : 2*length(t)-i ) = RxyStima( length(t)-i+1 : 2*length(t)-i ) + Rxy(i,:); % va da [len(t)->1 a 2len(t)->len(t)]
end

RxyStima = RxyStima/(dt * sigma^2 ); % normalizzazione per pulire dal rumore


poszero = find(tEsteso==0);
for i = 1:length(tEsteso)
    
    RxyStima(i) = RxyStima(i)/ ( length(t)-abs(i-poszero) ); % media su tutti gli istanti temporali
end

figure(1), plot(tEsteso,RxyStima), title('Stima della risposta all''impulso'); axis tight;

%Autocorrelazione Ry ( t, t') con t fissato su t1,t2,t3 e t'' libero
Ry= zeros( length(istanti), length(t));

figure(3);
for i=1:length(istanti)
    Ry(i,:) = mean(repmat(Uscita(:,t==istanti(i)),[1 length(t)]).*Uscita);
    str = sprintf('Ry(%fs)',istanti(i));
    subplot(1,3,i);  plot(t-istanti(i),Ry(i,:)); title(str); axis([-15 15 -2 2]);
end  
    % la STAZIONARIETA' SULL AUTOCORRELAZIONE viene persa.
     
return;