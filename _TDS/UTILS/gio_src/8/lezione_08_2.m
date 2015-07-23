% Lezione 8 - Es. 2: Autocorrelazione lineare

dt = 0.01;
nPer=6;
T=2;
t=-T*nPer/2:dt:T*nPer/2;


%x = ondaRectBip(t);
%figure;hold on;grid on;plot(t, x);hold off;


tau = t;
dtau = dt;

conv = zeros(size(t));
for k = 1:length(t)
    % Note: in questo caso genero ogni volta ondaRectBip(tau), che e' lo
    % stesso, potevo farlo solo una volta fuori dal for;
    % anche per il secondo, poteva essere piu' semplice utilizzare la
    % funzione myshift.
    % Inoltre, potevo unire convoluzione e correlazione nello stesso for.
    conv(k) = integrale(ondaRectBip(tau) .* ondaRectBip(t(k) - tau), dtau);
end

corr = zeros(size(t));
for k = 1:length(t)
    corr(k) = integrale(ondaRectBip(tau) .* conj( ondaRectBip(t(k) + tau) ), dtau);
end


figure;hold on;grid on;plot(t, conv);plot(t, corr, 'r');
title('Esercizio 2');
legend('Convoluzione tra x e se stesso', 'Autocorrelazione di x');
hold off;
axis([-4 5 -3 3]);