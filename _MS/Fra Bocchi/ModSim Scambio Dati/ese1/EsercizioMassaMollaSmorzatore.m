clc; %cancella la command window
close all; %chiude tutte le figure
clear all; %cancella tutte le varibili

% Simulazione di un corpo di massa m soggetta a una forza u e una forza elastica e una viscosa.
% m*a=u-k*y-b*v
% a accelerazione
% v velocità
% y posizione
% k costante elastica
% b costante smorzamento

% Nei sistemi meccanici, normalmente si considerano come grandezze di stato
% la posizione e la velocita.
% Si definisce quindi x1=y e x2=v
% la velocità è la derivata della posizione quindi
% Dx1=x2 (dove con Dx1 intendo la derivata di x1)
% Dx2=a=-k/m*x1-b/m*x2+u/m

% definiamo x il vettore x=[x1;x2] e quindi
% Dx=[0 1;-k/m -c/m]*x+[0;1/m]*u

% l'uscita sarà
%y=[1 0]*x+0*u

% per cui
% A=[0 1;-k/m -b/m], B=[0;1/m], C=[1 0], D=0


% Dati m=1, k=0.25, b=1, u=2, tempo di simulazione 10

m=1;
k=0.25;
b=1;
A=[0 1;-k/m -b/m];
B=[0;1/m];
C=[1 0];
D=0;
ueq=2;

% Calcolare il punto di equilibrio del sistema
% Dx=0 -> Dx=A*x+B*u=0 -> A*x=-B*u
% x=-inv(A)*B*u se det(A) diverso da 0
if det(A)==0
    disp('non si può calcolare xeq')
else
    xeq=-inv(A)*B*ueq
end

% simulare il sistema
sys=ss(A,B,C,D) %def. sistema
x0=[0 0]'; %def. stato iniziale
t=(0:0.01:10)'; %def. tempo simulaz.
u=ueq*ones(size(t)); %def. ingresso

[y,t,x] = lsim(sys,u,t,x0); %simula il sistema

% Tracciare i movimenti delle variabili di stato
plot(t,x)

% Tracciare il movimento dell'uscita
figure
plot(t,y)

% Tracciare la traiettoria
figure
plot(x(:,1),x(:,2))