%sistema idraulico: due serbatoi in cascata di sezione cilindrica 
%                   con superficie unitaria e afflusso u
% x_1: livello serbatoio monte  ==> x'_1 = - k_1 x_1 + u
% x_2: livello serbatoio valle  ==> x'_2 = k_1 x_1 - k_2 x_2
% y:   deflusso serbatoio valle ==>    y = k_2 x_2

clear all;

%parametri
k1=.5; % coeff. di deflusso del primo serbatoio
k2=.8; % coeff. di deflusso del secondo serbatoio

%matrici del sistema:
A=[-k1 0; k1 -k2]; % sistema di ordine 2: le due altezze idriche
B=[1; 0];          % 1 ingresso: afflusso al serbatoio di testa
C=[0 k2];          % 1 uscita: deflusso dal serbatoio di coda
D=0;               % sistema proprio

%sistema (e' una funzione del Control System Toolbox)
sys=ss(A,B,C,D); % State-Space model continuo

%orizzonte temporale della simulazione
t=0:0.01:10; % 1001 istanti di passo .01

%ingresso
u(1:length(t),1)=1; % occorre descriverne il valore su tutto l'orizzonte
ueq=1;

%condizione iniziale
x0=[1;1]; % valore dello stato (vettoriale) all'istante 0 della simulazione

[y,t,x]=lsim(sys,u,t,x0); % simulazione di un sistema lineare

plot(t,x(:,1),'r-'); % movimento della prima componente dello stato:
                     %  altezza idrica del primo serbatoio
hold on
plot(t,x(:,2),'b-'); % movimento della seconda componente dello stato:
                     %  altezza idrica del secondo serbatoio

figure;

plot(x(:,1),x(:,2)); % traiettoria

continuo
