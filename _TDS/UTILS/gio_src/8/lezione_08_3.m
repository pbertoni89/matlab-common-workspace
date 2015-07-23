% Lezione 8 - Esercizio 3: autocorrelazione circolare

dt = 0.01;
t = -10:dt:10;
T = 2;
nPer = 5;

% Genero il mio segnale periodico
x = ondaRectBip(t);
xT = zeros(size(t));
for l = -nPer:nPer
    x1 = trasla(x, (T * l)/dt);
    xT = xT + x1;
end

figure;hold on;grid on;plot(t, xT);
title(sprintf('Onda Rect periodica di periodo T=%d', T));
hold off;


tau = t;
dtau = dt;

% Ne calcolo l'autocorrelazione lineare
corr = zeros(size(t));
for k = 1:length(t)
    corr(k) = integrale(ondaRectBip(tau) .* conj( ondaRectBip(t(k) + tau) ), dtau);
end

% Ricavo l'autocorrelazione circolare da quella lineare, facendo la
% sommatoria della funzione di autocorrelazione traslata ogni volta di T.
corrT = zeros(size(t));
for l = -nPer:nPer
    x1 = trasla(corr, (T * l)/dt);
    corrT = corrT + x1;
end



figure;hold on;grid on;plot(t, corrT);
title('AutoCorrelazione di xT ottenuta come rep{correlazione di T}');
hold off;