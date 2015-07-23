function ResIntegrale = integrale(x,dt)

% Approssimiamo l'area della funzione con la somma delle aree di
% rettangoli. Moltiplicando x per dt creiamo un vettore in cui nella
% posizione k generica è contenuta l'area di un rettangolo di base dt e
% altezza x(k). Il comando 'sum' fa la somma di questi valori.

%ResIntegrale=sum(x*dt);

% dt si può fattorizzare (più efficiente). <porto fuori dalla sommatoria>

ResIntegrale=dt*sum(x);