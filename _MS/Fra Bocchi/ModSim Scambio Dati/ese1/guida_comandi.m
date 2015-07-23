clc; %cancella la command window
close all; %chiude tutte le figure
clear all; %cancella tutte le varibili
%NOTA queste tre funzioni sono da utilizzare all'inizio di ogni script!!


a=1 % Definizione di un scalare
A=2 % Nota: Matlab � case-sensitive, quindi "A" e "a" sono due variabili diverse.

B=[1 2 3;4 10 6] 
%Definizione di matrice. Occorre racchiudere gli elementi della matrice fra due quadre.
%gli elementi vanno inseriti riga per riga. Gli elementi della stessa riga vanno separati
%con degli spazi, finita la riga, si passa alla successiva con un punto e virgola.

C=[6 8 10;4 5 1];
%Il punto e virgola a fine istruzione serve a evitare che matlab stampi sulla command windows
%il risultato dell'istruzione.

d=B(2,2) %per accedere a un elemento di una matrice (gi� esistente) occorre digitare il nome
%della matrice seguito da parentesi tonde contenenti l'indice della riga e della colonna
%dell'elemento desiderato.
%NOTA: non si pu� accedere a un elemento che non esiste, ad esempio B(4,3)

C(2,3)=3 %per modificare un elemento della matrice occorre scrivere il nome della matrice
%seguito da tonde contenenti l'indice della riga e della colonna dell'elemento da modificare
%a SINISTRA dell'uguale, mentre a destra va messo il nuovo valore.

F=C(1:2,1:2) %per accedere a una sottomatrice (pi� elementi) occorre digitare il nome
%della matrice seguito da parentesi tonde contenenti l'indici della righe (primo indice seguito 
% da due punti e ultimo indice, nel esempio dalla primo al secondo) e delle colonne (come le righe)

C(1:2,3)=[3;1] %per modificare una sottomatrice occorre scrivere il nome della matrice
%seguito da tonde contenenti l'indici delle righe e delle colonne (come prima) dell'elemento 
%da modificare a SINISTRA dell'uguale, mentre a destra vanno messi i nuovi valori.
%NOTA: se si modificano elementi che superano le dimensioni della matrice, quest'ultima viene
%allargata.

H=[B C] %in questo modo si affiancano matrici aggiungendo colonne (cio� si affianca C a destra di B)

I=[B;C] %in questo modo si affiancano matrici aggiungendo righe (cio� si affianca C sotto a B)

%% operazioni fra matrici
% sono ammesse tutte le operazioni algebriche ben definite.
L=B+C; %somma di matrici (di equali dimensioni)
M=B-C; %sottrazioni di matrici (di equali dimensioni)
O=C'; %matrice trasposta.
P=B*O; %prodotto fra matrici. Possibile solo se le matrici hanno indici interni uguale, cio�:
% se B ha dimensioni n x m, C ha dimensioni m x p, il risulta avr� dimensioni n x p.
R=inv(P); %inversa di P (solo per matrici quadrate)
detR=det(R); %determinante di erre.

%% operazioni fra elementi
S=B.*C; %prodotto elemento per elemento (solo per matrici di equali dimensioni)
T=B./C; %divisione elemento per elemento (solo per matrici di equali dimensioni)
U=B.^2; %elevazione a potenza elemento per elemento (solo per matrici di equali dimensioni)

%% matrici "importanti"
V=zeros(4,3) %matrice di zeri con quattro righe e tre colonne
Z=ones(4,3) %matrice di uni con quattro righe e tre colonne
Y=5*ones(4,3) %matrice di cinque con quattro righe e tre colonne
W=eye(4) %matrice identit� 4x4.

%% vettori e operazioni varie
x=0:10 %vettore riga di 11 elementi, che partono da 0 e arrivano a 10 incrementando di 1
v=(0:10)' %vettore colonna di 11 elementi, che partono da 0 e arrivano a 10 incrementando di 1
t=(0:0.01:20)'; %vettore colonna con elementi che partono da 0 e arrivano a 20 incrementando di 0.01

lunghezza=length(t); %numero di elementi del vettore t
[nr,nc]=size(A); %restituisce il numero di righe e numero di colonne della matrice A
% NOTA, l'operatore size restituisce due valori, che vanno messi a sinistra racchiusi fra quadre.
% In generale, la sintassi di un comando �:
% [risultato1,risultato2,risultato3, ... , risultato_m]=comando(argomento1,argomento2,argomento3, ... , argomento_n)

u=ones(size(t)); %il comando ones prende come valori i risultati del comando size. Quindi:
%Matlab esegue il comando size restituendo il numero di righe e di colonne di t
%questi vengono passati al comando ones, che crea quindi un vettore di uni delle stesse dimensioni di t.

y=t.^2;

figure; %apre una nuova figura
plot(t,u); % disegna il grafico con t sull'asse delle ascisse, e u sull'asse delle ordinate.
plot(t,y); % disegna il grafico con t sull'asse delle ascisse, e y sull'asse delle ordinate. SOVRASCRIVENDO
% il precedente grafico

figure
plot(t,u)
hold on; %"conserva" il grafico anche se ne verrano plottato degl'altri
plot(t,y,'g'); %disegna in verde.
%NOTA: tutti i comandi matlab sono descritti nell'help. Matlab ha due help:
% uno accessibile da tastiera digitando "help nome_comando" ad esempio "help plot";
% un'altro (pi� dettagliato) � accessibile da matlab cliccando sul punto di domanda in alto a destra
%NOTA2: cercando nell'help "linespec" si ottengono tutti i comandi per curare l'estetica dei grafici.

grid on; %crea una griglia

