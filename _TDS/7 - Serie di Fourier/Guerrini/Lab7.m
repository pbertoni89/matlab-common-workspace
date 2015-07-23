clear all
close all

%Asse temporale
dt = 0.01;
t = -10:dt:10;


% ***************
% * ESERCIZIO 1 *
% ***************

% Punto 1

% Periodo del segnale
T1 = 4;

x1 = zeros(size(t));
for n = floor(min(t)/T1):ceil(max(t)/T1)
    x1 = x1+(t-n*T1).*rect(t/T1-n);
end

% implementazione senza ciclo
%x1 = t-T1*floor((t+T1/2)/T1);

plot(t,x1); title('x1'); axis([min(t) max(t) min(x1)-.5 max(x1)+.5]);


% Punto 2

% numero di armoniche considerato
NarmVet = [10 20 30];

% singolo periodo, per il calcolo di b
x1SingPer = x1.*rect(t/T1);


% segnale ricostruito sulle righe, usando b secondo la formula data nel testo
% ogni riga un numero di armoniche diverso dettato da NarmVett
x1Approx = zeros(length(NarmVet),length(t));

% segnale ricostruito sulle righe, usando b calcolato con la definizione
% ogni riga un numero di armoniche diverso dettato da NarmVett
x1ApproxCalc = zeros(length(NarmVet),length(t));

for n = 1:length(NarmVet)
    Narm = NarmVet(n);
    b = zeros(Narm,1);
    bCalc = zeros(Narm,1);
    for k = 1:Narm
        b(k) = -2/(pi*k)*(-1)^k;
        
        % * ESERCIZIO 3 *
        bCalc(k) = 1/T1*integrale(x1SingPer.*sin(2*pi*k/T1*t),dt);
        
        x1Approx(n,:) = x1Approx(n,:)+2*b(k)*sin(2*pi*k/T1*t);
        x1ApproxCalc(n,:) = x1ApproxCalc(n,:)+2*b(k)*sin(2*pi*k/T1*t);
    end
    figure(2)
    subplot(length(NarmVet),2,n*2-1), stem(1:Narm,b); title(sprintf('b secondo la formula data con %d armoniche',Narm));
    subplot(length(NarmVet),2,n*2), stem(1:Narm,bCalc); title(sprintf('b calcolato con l''integrale con %d armoniche',Narm));

    figure(2+n), plot(t,x1Approx(n,:)); title(sprintf('x1 ricostruito con b secondo la formula data con %d armoniche',Narm)); axis([min(t) max(t) min(x1)-.5 max(x1)+.5]);
    figure(2+length(NarmVet)+n), plot(t,x1ApproxCalc(n,:)); title(sprintf('x1 ricostruito con b calcolato con l''integrale con %d armoniche',Narm)); axis([min(t) max(t) min(x1)-.5 max(x1)+.5]);
end


% Punto 3

% uso la migliore approssimazione
figure, plot(t,x1,'b'); hold on, plot(t,x1Approx(end,:),'r--');
title('x1 vs. x1Approx'); axis([min(t) max(t) min(x1Approx(end,:))-.5 max(x1Approx(end,:))+.5]);

figure, plot(t,x1-x1Approx(end,:)); title('Errore in x1Approx'); 
axis([min(t) max(t) min(x1-x1Approx(end,:))-.1 max(x1-x1Approx(end,:))+.1]);
fprintf('Potenza dell''errore per la ricostruzione di x1 con %d armoniche: %2.3f\n',NarmVet(end),1/T1*integrale(((x1-x1Approx(end,:)).*rect(t/T1)).^2,dt));

pause;


% ***************
% * ESERCIZIO 2 *
% ***************

close all;


% Punto 1

%Periodo del segnale
T2 = 2;

x2 = abs(cos(pi/2*t-pi/4));

figure, plot(t,x2); title('x2'); axis([min(t) max(t) min(x2)-.5 max(x2)+.5]);


% Punto 2

% numero di armoniche considerato
NarmVet = [10 20 30];

% singolo periodo, per il calcolo di X
x2SingPer = x2.*rect(t/T2);

% valor medio
X0 = 2/pi;
X0Calc = 1/T2*integrale(x2SingPer,dt);

% segnale ricostruito sulle righe, usando X secondo la formula data nel testo
% ogni riga un numero di armoniche diverso dettato da NarmVett
% segnale inizializzato al valor medio
x2Approx = zeros(length(NarmVet),length(t))+X0;

% segnale ricostruito sulle righe, usando X calcolato con la definizione
% ogni riga un numero di armoniche diverso dettato da NarmVett
% segnale inizializzato al valor medio
x2ApproxCalc = zeros(length(NarmVet),length(t))+X0Calc;

for n = 1:length(NarmVet)
    Narm = NarmVet(n);

    Xpos = zeros(Narm,1);
    Xneg = zeros(Narm,1);
    XposCalc = zeros(Narm,1);
    XnegCalc = zeros(Narm,1);

    for k = 1:Narm
        Xneg(k) = -2/pi/(4*k^2-1)*exp(1j*pi*k/2);
        Xpos(k) = -2/pi/(4*k^2-1)*exp(-1j*pi*k/2);
        
        % * ESERCIZIO 3 *
        XnegCalc(k) = 1/T2*integrale(x2.*rect(t/T2).*exp(1j*2*pi*k/T2*t),dt);
        XposCalc(k) = 1/T2*integrale(x2.*rect(t/T2).*exp(-1j*2*pi*k/T2*t),dt);
        
        x2Approx(n,:) = x2Approx(n,:)+Xpos(k)*exp(-1j*2*pi*k/2*t)+Xneg(k)*exp(1j*2*pi*k/2*t);
        x2ApproxCalc(n,:) = x2ApproxCalc(n,:)+XposCalc(k)*exp(-1j*2*pi*k/2*t)+XnegCalc(k)*exp(1j*2*pi*k/2*t);
    end
    
    figure(2)
    subplot(length(NarmVet),2,n*2-1)
    stem(-Narm:Narm,real([flipud(Xneg); X0; Xpos]),'b'); hold on
    stem(-Narm:Narm,imag([flipud(Xneg); X0; Xpos]),'rx--'); axis tight
    title(sprintf('b secondo la formula data con %d armoniche',Narm));
    subplot(length(NarmVet),2,n*2)
    stem(-Narm:Narm,real([flipud(XnegCalc); X0; XposCalc]),'b'); hold on
    stem(-Narm:Narm,imag([flipud(XnegCalc); X0; XposCalc]),'rx--'); axis tight
    title(sprintf('b calcolato con l''integrale con %d armoniche',Narm));
    
    figure(2+n), plot(t,x2Approx(n,:)); title(sprintf('x2 ricostruito con X secondo la formula data con %d armoniche',Narm)); axis([min(t) max(t) min(x2)-.5 max(x2)+.5]);
    figure(2+length(NarmVet)+n), plot(t,x2ApproxCalc(n,:)); title(sprintf('x2 ricostruito con X calcolato con l''integrale con %d armoniche',Narm)); axis([min(t) max(t) min(x2)-.5 max(x2)+.5]);
end


% Punto 3

% uso la migliore approssimazione
figure, plot(t,x2,'b'); hold on, plot(t,x2Approx(end,:),'r--');
title('x2 vs. x2Approx'); axis([min(t) max(t) min(x2Approx(end,:))-.5 max(x2Approx(end,:))+.5]);

figure, plot(t,x2-x2Approx(end,:)); title('Errore in x2Approx'); 
axis([min(t) max(t) min(x2-x2Approx(end,:))-.1 max(x2-x2Approx(end,:))+.1]);
fprintf('Potenza dell''errore per la ricostruzione di x2 con %d armoniche: %.3e\n',NarmVet(end),1/T2*integrale(((x2-x2Approx(end,:)).*rect(t/T2)).^2,dt));

