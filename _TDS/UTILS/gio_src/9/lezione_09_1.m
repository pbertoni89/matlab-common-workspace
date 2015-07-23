% Lezione 9
rand('state', sum(clock));

% ESERCIZIO 1
% (i)
% Genero una VC di 10'000 realizzazioni, tra 0 e 1.
U = rand(1, 10000);
mediaU = mean(U); % media
varU = var(U); % varianza
hist(U, 100);
fprintf('Media di U: %f\nVarianza di U: %f\n', mediaU, varU);
pause;


% (ii)
% Partendo dalla prima, la voglio tra 3 e 5
U1 = (U .* 2) + 3;
mediaU1 = mean(U1);
varU1 = var(U1);
% hist mi mostra una QUASI pdf: non e' normalizzata.
hist(U1, 100);
fprintf('Media di U1: %f\nVarianza di U1: %f\n', mediaU1, varU1);
pause;


% Ricavo una variabile con una pdf voluta, dalla prima.
U2 = zeros(size(U));
for k = 1:length(U)
    if U(k) < 1/3
        % I valori saranno tra 0 e 1/3.
        % Li voglio tra -1/2 e 1/2, quindi li moltiplico per 3 (tra 0 e 1)
        % e sottraggo 1/2.
        U2(k) = U(k) * 3 - 1/2;
    elseif U(k) < 2/3
        % 1/3 dei campioni lo voglio a -1
        U2(k) = -1;
    else
        % l'altro 1/3 dei campioni lo voglio a 1
        U2(k) = 1;
    end
end
hist(U2, 100);
pause;




% Carta e penna!

% (iv)
% Metodo della funzione di distribuzione inversa (inverse transform
% sampling)
% 1) parto dalla pdf che voglio trovare: la integro (N.B. tra -infinito e z)
%    e trovo la distrib. F
%    Nota: se ho tipo zone differenti (vedi un tri), faccio i vari casi,
%    mettendo come estremi di integrazione ad esempio:
%    -infinito|z; -1|z; 0|z;...
%    Altra nota IMPORTANTE: ogni volta che vado avanti con gli intervalli,
%    ci devo aggiungere i risultati degli integrali passati (es per il tri
%    quando sono tra [0,1], ci aggiungo 1/2 che è l'area di tutto il
%    triangolino a sx.
% 2) pongo questa = alla F (diciamo la VC) originale, ed inverto, esplicito
%    rispetto all'altra variabile.
%    Nota: devo far combaciare le due basi della transizione, es. se devo
%    trasformare un Unif[0,1] in un tri => dovrò considerare il triangolino
%    a sx quando U è tra 0 e 1/2 etc.
% Ottengo cosi' una nuova VC che e' funzione di quella originaria (ciò che
% mi chiede l'esercizio).
U3 = zeros(size(U));
for k = 1:length(U)
    if U(k) < 1/2
        U3(k) = sqrt(2*U(k)) - 1;
    else
        %                  v--- questo meno l'ho messo io per far
        %                  v   risultare!!!!! non so come mai non mi esca.
        U3(k) = 1 - sqrt(2 - 2*U(k));
    end
end
hist(U3, 100), pause, close;




% valor medio: mu = integrale (x * pdf)
% varianza: sigmaX quadro = vx =   1/(N-1)  * sommatoria x - mx

% 1) trasformare VC in distribuzione uniforme
% prendiamo U => Fz alla -1 => Z
% FZ = integrale da -infinito a z, di pdf
% invertire: la poniamo a U e cerchiamo di invertirla, esplicitiamo z in
% funzione di U.

% come calcoliamo la pdf? hist(z, 100) 
% dobbiamo normalizzare in modo che l'integrale faccia 1
% prendiamo le altezze e le dividiamo per (N * dx)
% c'è il modo per non disegnare: [H, x] = hist(z, 1000) mette in H le ampiezze, e
% in x i valori sull'asse X.
% dx lo calcolo facendo la differenza tra 2 x consecutive