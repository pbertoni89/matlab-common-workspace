% Lezione 11 - Esercizio 2

dt = 0.01;
t = -10:dt:10;
nReal = 5000;
nPer = 10;
A = 2;


% Fase iniziale casuale
t0 = rand(1, nReal) - 1/2; % unif tra [-1/2, 1/2]

% Genero la matrice di pam
pam = zeros(nReal, length(t));
for l = 1:nReal
    realizzazione = zeros(size(t));
    for k = -nPer:nPer
        Ak = rand(1) * (2*A) - A; % unif in [-A, A]
        realizzazione = realizzazione + Ak * rect(t - k - t0(l));
    end
    pam(l, :) = realizzazione;
end
figure;hold on;grid on;plot(t, pam(1,:));hold off;

% (i)

% Verifico la proprieta' di stazionarieta'
% Per essere verificata, la funzione di autocorrelazione Rx non deve
% variare al variare del tempo.
istanti = [0 1.2 4.5 6];
for k = 1:length(istanti)
    ist = istanti(k);
    indice = (ist + 10) / dt;
    X1 = pam(:, indice);
    matrice_prodotto = zeros(size(pam));
    for l = 1:length(t)
        col = X1 .* pam(:, l);
        matrice_prodotto(:, l) = col;
    end
    % Rx(t1, t2) = E[X(t1) * X(t2)]
    Rx = mean(matrice_prodotto, 1);
    % Dipende dal delta T, ovvero t2 - t1, non da T
    plot(t - ist, Rx); xlim([-2 2]);grid on; pause;
end
close;
% Ok,  fa piu' o meno un tri di ampiezza 1.35
% E' stazionario.



% (ii)
% Filtro con un quadratore: S[x(t)] = x(t) ^ 2
uscite = zeros(nReal, length(t));
for k = 1:nReal
    uscita = pam(k, :) .^ 2;
    uscite(k, :) = uscita;
end

media = mean(uscita, 1);
fprintf('Media del processo in uscita: %f\n', media);


% Calcolo la funzione di autocorrelazione dell'uscita
istanti = [0 1];
for k = 1:length(istanti)
    ist = istanti(k);
    indice = (ist + 10) / dt;
    X1 = uscite(:, indice);
    matrice_prodotto = zeros(size(uscite));
    for l = 1:length(t)
        col = X1 .* uscite(:, l);
        matrice_prodotto(:, l) = col;
    end
    % Rx(t1, t2) = E[X(t1) * X(t2)]
    Rx = mean(matrice_prodotto, 1);
    % Dipende dal delta T, ovvero t2 - t1, non da T
    plot(t - ist, Rx); xlim([-10 10]);grid on; pause;
end
close;
plot(t, uscite(1, :));pause;

[distribuzione, z] = hist(uscite, 100);
dz = z(2) - z(1);
area = sum(distribuzione);
bar(z, distribuzione / (area * dz));pause;



% (ii)
% Filtro con un diodo: S[x(t)] = x(t) se x > 0
uscite = zeros(nReal, length(t));
for k = 1:nReal
    % diodo
    uscita = max(pam(k, :), 0);
    uscite(k, :) = uscita;
end

media = mean(uscita, 1);
fprintf('Media del processo in uscita: %f\n', media);


% Calcolo la funzione di autocorrelazione dell'uscita
istanti = [0 1];
for k = 1:length(istanti)
    ist = istanti(k);
    indice = (ist + 10) / dt;
    X1 = uscite(:, indice);
    matrice_prodotto = zeros(size(uscite));
    for l = 1:length(t)
        col = X1 .* uscite(:, l);
        matrice_prodotto(:, l) = col;
    end
    % Rx(t1, t2) = E[X(t1) * X(t2)]
    Rx = mean(matrice_prodotto, 1);
    % Dipende dal delta T, ovvero t2 - t1, non da T
    plot(t - ist, Rx); xlim([-10 10]);grid on; pause;
end
close;

% Provo a visualizzare la pdf
[distribuzione, z] = hist(uscite, 100);
dz = z(2) - z(1);
area = sum(distribuzione);
bar(z, distribuzione / (area * dz));pause;