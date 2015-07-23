clear all; close all; clc;
%PRESSIONE ARTERIOSA
%Data una popolazione di individui di vuole stimare 
%la relazione tra pressione arteriosa e l'età.
%I dati seguenti sono i risultati di un'operazione di 
%campionamento (x=età dell'individuo, y=pressione).

%Il programma seguente permette di stimare mediante il metodo 
%dei minimi quadrati i coefficienti di una retta di 
%regressione del tipo:
%   y = ax+b

%Per stimare i parametri è necessario definire una matrice M
%che mette in relazione lo spazio dei parametri con lo spazio
%dei dati in modo tale da minimizzare la distanza tra i dati
%misurati e quelli stimati.
%La curva cercata è lineare nei parametri quindi dato un valore x=u
%il valore di y stimato (ys) risulta:
%    ys=M(u)v
%dove v è il vettore contenente i coefficienti della retta.
%Invertendo la relazione e tenendo conto che in generale M è una matrice %rettangolare, si ricava la relazione che permette di determinare i 
%coefficienti cercati:
%    v = inv(M'*M)*M'* y


%definizione dei vettori dei dati
x= [25 30 42 55 55 69 70]';
y= [120 125 135 140 145 180 160]';

%definizione della matrice M
M=[x ones(7,1)];  % 7x2

% Calcolo del vettore contenente i parametri del modello (v)
v = (inv(M'*M))*M'* y;

%coefficienti della retta
a=v(1)
b=v(2)

%grafico rappresentante la retta di regressione dei dati iniziali
plot (x,y,'r*');
xlabel('età');
ylabel('pressione');
hold on;
ys=a*M(:,1)+ b;     %espressione della retta di regressione
plot(M(:,1),ys,'g-');
hold off;
grid;

%statistical indexes
r = corrcoef(x,y) % = corrcoef(y,ys)
r=r(1,2);
mx=mean(x) 
my=mean(y)
sx=std(x)
sy=std(y)
a_stat=r*sy/sx
b_stat=my-a_stat*mx
var_sp = var(ys)/var(y)
