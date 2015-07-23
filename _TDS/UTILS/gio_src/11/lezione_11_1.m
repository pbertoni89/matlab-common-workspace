% Lezione 11 - Esercizio 1

clear all; clc; close all;

nReal = 150;

dt = 0.01;
t = -10:dt:10;
theta = rand(1, nReal) * (2*pi);

% genero un rumore gaussiano
matrice = zeros(nReal, length(t));
for k = 1:nReal
    matrice(k,:) = randn(1, length(t));
end


% Lo filtro attraverso il "filtro misterioso"
matriceFiltrata = zeros(nReal, length(t));
matriceCrossCorr = zeros(nReal, length(t));
tau = t;
dtau = dt;
poszero = find (t == 0);
for k = 1:nReal
    matriceFiltrata(k,:) = filtroMisterioso(matrice(k, :), t);
    
    % Calcolo crosscorrelazione tra ingresso e uscita:
    corr = zeros(size(t));
    for l = 1:length(t)
        % il secondo va calcolato in t + tau, ovvero traslato pian piano
        % verso sinistra.
        % Ovvero il numero di campioni di cui deve essere traslato deve
        % calare.
        corr(l) = integrale(conj( matrice(k, :) ) .* myshift(matriceFiltrata(k, :), poszero - l) , dtau);
    end
    matriceCrossCorr(k, :) = corr;
end
% Per avere un'idea, faccio una media tra tutte le crosscorrelazioni
media = mean(matriceCrossCorr, 1);
figure;hold on;grid on;
axis([0 2 0 0.2]);
plot(t, media);
hold off;

% potremmo dedurre che e' un'esponenziale decrescente moltiplicata per un
% rect(t - 1).
% ovviamente va scalato, di un fattore 2/eta.



% sfrutto teorema risposta in frequenza
% la sua uscita viene scalata della risposta in frequenza e sommata la fase
% della tdf della risposta all'impulso
% se do un ingresso una sinusoide ad un LTI, l'uscita sara':
% A*|H(f0)|*sin(2pif0t + fi + theta(H(f0)))
% misurando l'uscita disegnamo l'H(f) facendo uno sweep di frequenze

% altro modo: se il processo che do in ingresso e' bianco, la
% crosscorrelazione tra il proc di ingresso e uscita, grazie alle
% proprieta' di linearita' e tempo invarianza, esce

% Rxy(tau) = 2/eta  * h(tau)
% lo facciamo n volte, mediamo quello che viene fuori, ed abbiamo una
% risposta all'impulso

% filtro(x, t)
% gli do una realizzazione con il tempo, e lui mi da il processo in uscita
% prendiamo una riga del processo, la diamo in pasto al sistema, facciamo
% correlazione ingresso uscita, lo facciamo per tutti, facciamo la media e
% vediamo cosa viene fuori

% NB possiamo farlo perche' e' ergodico, e quindi a media nulla, altrimenti
% non posso farlo.

% es. 2, PAM
% questo deve venire staz. erg. e la differenza e' che c'e' lo sfasamento
% ovvero il t0
% Typo: t - k - t0
% (i) dovrebbe uscire un triangolo
% (ii) filtro quadratore e diodo (<=0 uguale a 0)
% dovrebbe uscire ad intuirlo guardando il filtro
% ho la marginale, unif tra -A e A
% se passa in un quadratore, esce una parabola per x >= 0
% proviamo a vedere la pdf (questa)
% per il diodo, dovrebbe uscire un delta alto 1/2 in zero, e poi ampiezza
% costante
% possiamo calcolare l'autocorrelazione del processo in uscita (vedi
% lezioni scorse)

% es. 3 AM
% facciamo finta che la fase della portante in modulazione e demodulazione
% siano le stesse
% modulatore double side band
% banda: B (semi triangolo)
% in quello traslato: 2B
% poi arriva il rumore
% all'inizio non mettere il rumore, poi vediamo.
% poi c'e' il demodulatore
% con il rumore, la potenza dopo il demodulatore
% per vedere: faccio segnale finale - iniziale e vedo solo il rumore
% rimanente.