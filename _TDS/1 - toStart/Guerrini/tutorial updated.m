%
% Programma tutorial - Ctrl+C interrompe l'esecuzione
%
% Autore: Fabrizio Guerrini - v2.0
%

 
% Help

% help <comando> per aiuto testuale
% doc <comando> per aiuto ipertestuale
% lookfor <parola> cerca le funzioni con "parola" nell'aiuto testuale

%which tutorial_updated % identificazione file


% Pulizia workspace

clear; % clear <nomevar> per cancellare solo la variabile nomevar
%return; % termina l'esecuzione dello script (o della funzione) <- cancellarlo da qui


% Assegnamento esplicito

A = [3 2 4; -2 3 -1; 4 0 -6; 2 1 0]; % spazio (o virgola) separa le colonne
    % punto e virgola separa le righe
A(4,:) = []; % : significa tutta la dimensione corrispondente
    % in questo caso tutta la quarta riga
A = A'; % trasposta (coniugata)
save; % salvataggio workspace (A) in matlab.mat
pause; % attende la pressione di un tasto
clear;


% Assegnamento implicito

t = -10:.1:10; % vettore da -10 a 10 spaziato di 0.1
t1 = -100:100; % vettore da -100 a 100 spaziato di 1
B = zeros(1,3)+2; % inizializzazione con 0
C = ones(3,1)*3; % inizializzazione con 1
D = rand(3,3); % matrice casuale (pdf uniforme tra 0 e 1)


% Visualizzazione - 1

t % echo della variabile
t1
pause;


% Esercizio (visualizzare le variabili con l'echo):

% 1) generare un vettore COLONNA t2 che va da 0 a 2 con passo 0.1;

t2 = (0:.1:2)';

% 2) generare una matrice E quadrata 4x4 con ogni elemento pari a -1;

E = zeros(4,4)-1;
%E = -ones(4);

% 3) aggiungere una quinta colonna alla matrice E, tutta nulla;

E = [E zeros(4,1)];

% 4) definire la matrice F come la seconda e la terza riga di E;

F = E(2:3,:);

% 5) cancellare da F la prima colonna.

F(:,1) = [];


% *********************************************************************


% Operazioni vettoriali ed elemento per elemento

v1 = B*C; % prodotto righe per colonne: (n,p)*(p,m)=(n,m)
v2 = B.*C'; % prodotto elemento per elemento
v3 = C.^2; % elevamento a potenza elemento per elemento
v4 = B+C'; % somma (per definizione) elemento per elemento
% help ops


% Visualizzazione - 2

clc; % pulizia dello schermo
v1
v2
disp(v3) % solo valore
pause;
fprintf('v1 = %d\nPremere un tasto...\n',v1); % output formattato
pause;
clear;
load; % lettura workspace (A) da matlab.mat
B = zeros(1,3)+2;


% Esercizio:

% 1) Moltiplicare riga per colonna il vettore B con la terza colonna di A e metterlo in x

x = B*A(:,3);

% 2) Visualizzare la seguente riga: "x vale : " seguito dal valore di x (usare fprintf)

fprintf('x vale : %d\n',x);

% 3) Creare il vettore colonna v definito da x elevato alla seconda riga di A

v = x.^A(2,:);

% 4) Visualizzare v usando disp

disp(v)

% 5) Creare v1, moltiplicando B e v elemento per elemento, visualizzandolo direttamente
%    (togliendo il punto e virgola)

v1 = B.*v



% *********************************************************************


% Comandi vari per la manipolazione di matrici

A
A(2,2) % estrazione di un elemento da una matrice
pause;
A(:,3) % estrazione di una colonna da una matrice
pause;
A(1,:) % estrazione di una riga di una matrice
pause;
diag(A) % diagonale di A (quadrata)
pause;
A+eye(3) % eye=matrice diagonale
pause;
size(A) % dimensioni di A (sia per vettori che per matrici)
pause;
length(B) % lunghezza del vettore B
pause;
sum(A) % somma di un vettore o delle colonne di una matrice
sum(B)
pause;
sum(sum(A)) % somma di una matrice
pause;
abs(A) % valore assoluto
pause
A = int8(A) % cast - help datatypes
whos A % tipo della variabile
A = [A; 1 5 -2] % aggiunta di una riga
pause;
A = double([A (2:5)']) % aggiunta di una colonna e cast a double
whos A
E =  [5*rand -3*rand]
pause;
floor(E) % arrotondamento all'intero precedente
ceil(E) % arrotondamento all'intero successivo
round(E) % arrotondamento all'intero piu' vicino
mod(E,1) % resto della divisione
pause;


% *********************************************************************


% Segnali

clear;
clc;
fprintf('Parte segnali\n');
t = -10:.1:10;
x = 5*(sin(t).^2)+1; % x(t) = 1+5sen^2(t)


% Grafici

plot(t,x,'r');
axis([min(t) max(t) min(x)-1 max(x)+1]) % assi [minx maxx miny maxy]
pause;
hold on; % mantieni grafico sulla stessa finestra
plot(t,5*sin(t)+1);
axis tight % assi stretti sul grafico
hold off;
pause
figure % apre una nuova finestra
plot(t,t.^2,'k*');
pause;
close; % chiude la finestra del grafico corrente
pause;
close all; % chiude tutte le finestre
plot(t,[x;t.^2]);
%plot(t,x,'r',t,t.^2,'k');
pause;


% Cicli, condizionali e operazioni logiche

clear;
close;
t = -10:.1:10;


% Segnale rect - versione con ciclo

x1 = zeros(size(t));
for i = 1:length(t) 
    if t(i)>-0.5 && t(i)<0.5
        x1(i) = 1;
    elseif abs(t(i))==0.5
        x1(i) = 0.5;
    %else x1(i) = 0;
    end
    %if t(i)>0.5
    %    break;
    %else
    %    continue;
    %end
    %fprintf('QUI!\n');
end
plot(t,x1);
pause;


% Segnale rect - versione con operazioni logiche

x2 = 0.5*(abs(t)==0.5) + (abs(t)<0.5);
figure
plot(t,x2,'r');
pause;
close all;
clear;