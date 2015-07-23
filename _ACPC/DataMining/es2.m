%% Identificare un modello di regressione multipla (con costante di depolarizzazione) 
% che leghi le variabili indipendenti indexes e la variabile dipendente Y

% modello di regressione a P = 13 variabili.
% difatti erano 12 più la depolarizzazione

% IPOTESI PER IL MODELLO
% - errore a media nulla
% - errori incorrelati e tutti alla stessa Var: E[eps eps'] = sigma^2*eye
% - covarianza tra le X e gli errori è nulla
% - il rango di X (che comprende la depolarizzazione) è p (=>pieno) 
%       => non c'è dipendenza lineare in X

clear, clc, close all
load countries;
setDisplay = 'off';
Y = countries_scores;
n = length(Y);

fprintf('there are %d indexes for %d countries.\n', size(indexes,2), length(Y));

% definizione matrice dei dati
% matrice degli ingressi: WRNultima colonna di 1, per gestire la costante di depolarizzazione
X1 = [indexes ones(n,1)];
%andiamo a verificare il rango e il determinante [non posso, non quadrata!!
%    (vicino a zero <=> vicino alla dipendenza lineare)
%detX1 = det(X1)
rankX1 = rank(X1)
[~, p] = size(X1);

%stima dei parametri con metodo dei minimi quadrati.
% IMP i b_i sono stimatori dei beta_i !!!
b1 = inv( X1' * X1) * X1' * Y
% sotto le HP assunte, b è uno stimatore efficiente per modelli lineari dei parametri, aka
% - consistente
% - non deviato
% - a varianza minima

% calcola le uscite del modello stimato a fronte degli ingressi in X
Y1 = X1*b1;

%% Calcolare gli intervalli di confidenza dei parametri stimati.

% per modellizzare secondo Student, si assume la normalità dell'errore.
% possiamo testare la significatività statistica di ciascuna stima b_i
% esaminando il corrispondente valore del t-Student 

err1 = Y-Y1;
sigma2 = (1/(n-p)) * sum(err1.^2);
SigmaM = sigma2 * diag(inv(X1'*X1));
% attenzione al primo argomento di tinv, che a fronte di un range di conf del 5% (0.05) 
% vuole in ingresso 1-0.05/2, in quanto si utilizza SOLO UNA DELLE DUE CODE
% tinv = Inverse of Student's T cumulative distribution function
conf_I_tstd = tinv(0.975, n-p) * sqrt(SigmaM);

fprintf('La varianza vale %d.\n', sigma2)
disp('gli intervalli di confidenza dei parametri stimati:'), conf_I_tstd

%% Calcolare correlazione e mse del modello stimato

mse1 = (1/n) * sum(err1.^2)
corr1 = corrcoef(Y1, Y)

%% Applicare la feature selection (partendo dal modello vuoto) 
% (comando stepwisefit) utilizzando penter=0.05 e premove=0.1 (default)
% penter =  Max p-value for a predictor to be added
% premove = Min p-value for a predictor to be removed
% stimandone i parametri e calcolandone correlazione e mse

[~, ~, ~, sel2] = stepwisefit(X1(:, 1:p-1), Y, 'display', setDisplay)

% Input1: matrice dei dati SENZA COLONNA PER IL TERMINE DI DEPOLARIZZAZIONE, quindi ha dim (n x p-1)
% Input2: vettore di output

% Output: vettore di p-1 elementi che contiene 
%   "1" nella posizione degli elementi selezionati, 0 altrimenti

% ESEMPIO (scollegato dall'esercizio): inmodel_out2=[1 0 0 1 0 0 0 0 0 0 0 1] 
%   => la feature selection ha selezionato come input il primo, il quarto e il dodicesimo ingresso

X2 = X1(:, sel2>0);
X2 = [X2 ones(n,1)]; %ha cols = selezionati + 1

b2 = inv(X2' * X2) * X2' * Y;
Y2 = X2 * b2;

err2 = Y-Y2;
mse2 = (1/n) * sum(err2.^2)
corr2 = corrcoef(Y2, Y)

% se si vuole simulare il metodo forward bisognerebbe settare premove a 1
% stepwisefit non lo permette, quindi si usa 1-eps
% se si vuole simulare il metodo backward bisognerebbe settare penter a 0
% stepwisefit non lo permette, quindi si usa 0+eps

%% Applicare la feature selection (partendo dal modello vuoto) 
% (comando stepwisefit) utilizzando penter= 0.01, 0.5 e premove=1
% stimandone i parametri e calcolandone correlazione e mse

[~, ~, ~, sel3] = stepwisefit(X1(:, 1:p-1), Y, 'penter',.01, 'premove',1-eps, ...
                    'display', setDisplay); 

X3 = X1(:, sel3>0);
X3 = [X3 ones(n,1)];

b3 = inv(X3' * X3) * X3' * Y;
Y3 = X3 * b3;

err3 = Y-Y3;
mse3 = (1/n) * sum(err3.^2)
corr3 = corrcoef(Y3, Y)

% ~ ~ ~

[~, ~, ~, sel4] = stepwisefit(X1(:, 1:p-1), Y, 'penter',0.5, 'premove',1-eps, ...
        'display',setDisplay)

X4 = X1(:, sel4>0);
X4 = [X4 ones(n,1)];

b4 = inv(X4' * X4) * X4' * Y;
Y4 = X4 * b4;

err4 = Y-Y4;
mse4 = (1/n) * sum(err4.^2)
corr4 = corrcoef(Y4, Y)

%% Applicare la feature selection (partendo dal modello PIENO) 
% (comando stepwisefit) utilizzando penter=0 e premove=0.1
% stimandone i parametri e calcolandone correlazione e mse

[~, ~, ~, sel5] = stepwisefit(X1(:,1:p-1), Y, 'penter',eps, 'premove',0.1, ...
        'inmodel',1:p-1, 'display',setDisplay)

X5 = X1(:, sel5>0);
X5 = [X5 ones(n,1)];

b5 = inv(X5' * X5) * X5' * Y;
Y5 = X5 * b5;

err5 = Y-Y5;
mse5 = (1/n) * sum(err5.^2)
corr5 = corrcoef(Y5, Y)

%% final

mses = [mse1 mse2 mse3 mse4 mse5];
corrs = [corr1(1,2) corr2(1,2) corr3(1,2) corr4(1,2) corr5(1,2)];
errs = [err1 err2 err3 err4 err5];

figure('name','Mean Square Errors'), bar(mses)
figure('name','Correlations'), bar(corrs)
figure('name','Score vs Models'), plot(Y,'k'), hold on
    plot(Y1, 'r'), plot(Y2, 'g'), plot(Y3, 'b'), plot(Y4, 'c'), plot(Y5, 'm')
    legend('Y','Y1', 'Y2', 'Y3', 'Y4', 'Y5');
figure('name','Error Distribution'), hist(errs)
    legend('Y1', 'Y2', 'Y3', 'Y4', 'Y5');
%% Backward Selection

% (1) inizia dall’identificazione del modello completo
% (2) Per ogni variabile xi viene calcolato FL = il valore della funzione F-test
%   parziale ottenuta considerando la variabile xi come l’ultima ad essere
%   stata inserita nel modello;
% (3) A questo punto si confronta FL col valore di di una F-test critica tabulata (FC)

%   FL < FC => la variabile corrispondente e' rimossa e si torna al punto 2
%   FL > FC => la variabile xi è accettata nel modello.
% Una volta che il metodo elimina una variabile dal modello non vi è alcun
%   modo di reinserirla, il processo è irreversibile.

%% Forward Selection

% (1) inizia dal modello vuoto
% (2) Si calcola la correlazione tra ogni Xj rimanente e la variabile dipendente Y
%   la variabile con la maggiore correlazione viene selezionata.
% (3) Viene identificato il modello di regressione contenente 
%   la variabile selezionata al punto 2
% (4) Si seleziona, tra le restanti, la variabile che presenta la maggiore 
%   correlazione col “nuovo” modello e si calcola il valore FH della relativa F-test.
% (5) Si confronta FH con una F-test critica tabulata (FC)

%   FH < FC => il modello rimane invariato;
%   FH > FC => la variabile e' inclusa, si calcola il nuovo modello e si torna al punto 4

%% Stepwise Selection

% (1) inizia dal modello vuoto
% (2) Si calcola la correlazione tra ogni Xj rimanente e la variabile dipendente Y
%   la variabile con la maggiore correlazione viene selezionata.
% (3) Viene identificato il modello di regressione con la Xj selezionata al punto 2 
%   si confronta la F-test del modello con una Fc tabulata per verificare che 
%   l’inserimento di Xi abbia rilevanza statistica
% (4) Viene calcolata la correlazione tra le restanti X ed il “nuovo” modello
%   la variabile Xj con la maggiore correlazione viene selezionata
% (5) Viene identificato un modello di regressione con i due predittori Xi ed Xj
%   si confronta la F-test del modello con la F-test critica tabulata (FC)
%   per verificare che l’inserimento di Xj abbia rilevanza statistica
% (6a) Si valuta il valore della F-test parziale di Xj rispetto al modello che conteneva già Xi
%  Se tale valore soddisfa il test rispetto alla F-test critica tabulata
%   => il predittore viene mantenuto nel modello
%   else lo si elimina dal modello di regressione
% (6b) Si valuta il valore della F-test parziale di Xi supponendo che Xj fosse
% stata inserita per prima nel modello:
%   Se tale valore soddisfa una certa F-test critica tabulata
%    => il predittore viene mantenuto nel modello
%   else lo si elimina dal modello di regressione.
% (7) Se Xi ed Xj soddisfano entrambe la condizione per essere mantenute nel modello
%   si seleziona tra le restanti la X con la maggiore correlazione rispetto a Y
% (8) Viene identificato un modello di regressione con le tre Xi, Xj ed Xk 
%   si confronta la F-test del modello con una tabulata per verificare che 
%   l’inserimento di Xk abbia rilevanza statistica;
% (9) A questo punto vengono effettuati 3 controlli incrociati, ovvero si valuta 
%   il valore della F-test parziale rispetto a quello critico tabulato per
%   9. Xk, rispetto ad un modello contenente Xi ed Xj;
%   10. Xi, rispetto ad un modello contenente Xj ed Xk;
%   11. Xj, rispetto ad un modello contenente Xi ed Xk;
% (10) Il metodo reitera finché non è più possibile inserire o eliminare X


