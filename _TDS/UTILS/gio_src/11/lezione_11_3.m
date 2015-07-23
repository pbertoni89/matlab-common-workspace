% Lezione 11 - Es. 3

fp = 1;
phi = 0;
dt = 0.01;
t = -10:dt:10;

% MODULATORE
x = sinc(t) .^ 2;
portante = cos(2 * pi * fp * t  + phi);
plot(t, x);pause;

% Passo attraverso il moltiplicatore
y1 = x .* portante;


% TODO: aggiungere del rumore
rumore = randn(1, length(t));
y2 = y1 + rumore;

% DEMODULATORE:
% 1) moltiplico per la portante
y3 = y2 .* portante;

% lo faccio passare per un filtro passabasso, a B = 1
% Ovvero convoluzione con una h(t) = trasformata inversa di rect(t/2),
% ovvero h(t) = 2*sinc(2t)
y4 = zeros(size(t));
poszero = find (t == 0);
dtau = dt;
for k = 1:length(t)
    % Ovvero il numero di campioni di cui deve essere traslato deve
    % aumentare.
    % Convoluzione
    % Nota: 4 perche' devo recuperare l'ampiezza originale.
    ht = 4 * sinc(2*(t(k) - tau) );
    y4(k) = integrale(y3 .* ht, dtau);
end
plot(t, y4);pause;

close;