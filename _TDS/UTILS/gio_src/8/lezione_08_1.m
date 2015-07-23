% La correlazione e' una sorta di somiglianza tra due segnali, fatta quando
% li shiftiamo l'uno rispetto all'altro.
% * Lineare (standard), tra segnali di energia.
% * Circolare (per segnali periodici)

% FORMULA: (per quelli di energia) = conj(x(-t)) (*) y(t)

% FIx(0) = Wx
% L'autocorrelazione di un segnale e' sempre PARI.

% Stesso codice della convoluzione, ma non lo ribaltiamo t(k) - tau =>
% t(k) + tau

% NB mettere il coniugato sul secondo segnale.

% Circolare: piu' difficile:
% * applicare la formula dell'integrale su un periodo (se e' facile)
% * passare in fourier, utilizzandone i coefficienti
% * aliasing temporale: autocorrelazione lineare del segnale isolato sul
% periodo, e poi ripeterlo per ogni periodo. Molto spesso si sovrappongono,
% tenerne conto.

% NB l'autocorrelazione di un'onda rettangolare e' un'onda triangolare.

% Il problema e': bisogna implementare una funzione che faccia shift:
% accetta in ingresso un vettore x(t) del segnale, uno shift k che e' il
% NUMERO DI indici da shiftare, non la quantita' di t.
% restituisce il segnale 
% mettiamo 3 zeri a sinistra, e poi prendiamo il segnale dall'inizio alla
% fine -3.
% ci sara' un if per vedere il segno di k

dt = 0.01;
dtau = dt;

t=-10:dt:10;
tau = t;

% SCHEMA DI ESEMPIO DI CORRELAZIONE FACILE:

%tau = t;
%dtau = dt;
%z = zeros(size(t));
%for k = 1:length(t)
%    z(k) = integrale(rect(tau) .* conj(rect(t(k) + tau)), dtau);
%end




% A
z = zeros(size(t));
for k = 1:length(t)
    z(k) = integrale(2*rect((tau - 3)/2) .* conj(rect((t(k)+tau +1)/3)), dtau);
end

figure;hold on;grid on;
title('Esercizio A');
plot(t, z);
pause;

% B
z = zeros(size(t));
for k = 1:length(t)
    z(k) = integrale(3*tri(tau / 2) .* conj(1i * tri(t(k) + tau - 1)), dtau);
end

figure;hold on;grid on;
title('Esercizio B');
plot(t, real(z), 'b');
plot(t, imag(z), 'r');
legend('Re', 'Im');
pause;

% C
z = zeros(size(t));
for k = 1:length(t)
    z(k) = integrale(sinc(tau) .* conj(-2*sin(2*pi*(t(k) + tau))), dtau);
end

figure;hold on;grid on;
title('Esercizio C');
plot(t, z);
pause;

% D
z = zeros(size(t));
for k = 1:length(t)
    z(k) = integrale((1 + 1i) * rect(tau) .* conj(2*tri((t(k) + tau +3)/2)), dtau);
end

figure;hold on;grid on;
title('Esercizio D');
plot(t, real(z), 'b');
plot(t, imag(z), 'r');
legend('Re', 'Im');
pause;

% E
z = zeros(size(t));
for k = 1:length(t)
    z(k) = integrale((0.5 .^ t) .* gradino(tau) .* conj(rect((t(k)+tau-1)/2)), dtau);
end

figure;hold on;grid on;
title('Esercizio E');
plot(t, z);