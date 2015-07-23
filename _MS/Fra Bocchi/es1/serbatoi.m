clc;
close all;
clear all;

% x1 livello del serbatoio 1
% x2 livello del serbatoio 2

% serbatoio 1
% u portante entrante
% k1*x1 portata uscente
% S1 area del serbatoio
% S1*Dx1=u-k1*x1
% Dx1=u/S1-k1/S1*x1

% serbatoio 2
% k1*x1 portante entrante
% k2*x2 portata uscente
% S2 area del serbatoio
% S2*Dx2=k1*x1-k2*x2
% Dx2=k1/S2*x1-k2/S2*x2

% portata uscente dal 2 = uscita
% y=k2*x2

S1=1; 
S2=1;
k1=0.5; 
k2=0.8;
ueq=1; 
x0=[1,1];


A = [-k1/S1 0; k1/S2 -k2/S2 ];
B = [1/S1 0]';
C = [0 k2];
D = 0;

%punto d'equilibrio
if det(A)==0
   disp('La matrice A non e'' invertibile, non si può calcolare xeq'); 
else
    xeq = -inv(A)*B*ueq
end

%simulare il sistema 
sys = ss(A,B,C,D)%definiamo il sistema
x0 = [1 1]';%definisco le condizioni iniziali
t=(0:.01:10)';%range di tempo, sempre come vettore colonna
u = ueq*ones(size(t)); %creo il vettore di ingresso che è costante

%simulo ill sistema
[y,t,x] = lsim (sys,u,t,x0);

%tracciare i movimenti delle variabili di stato
plot(t,x);

%tracciare i movimenti dell'uscita
figure
plot(t,y);

%tracciare la traettoria
figure
plot(x(:,1),x(:,2));





