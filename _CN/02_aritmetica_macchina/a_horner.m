clear all; close all;

x=0.996:0.0001:1.004;

p1=(x-1).^6;

p2=x.^6-6*x.^5+15*x.^4-20*x.^3+15*x.^2-6*x+1;

a=[1,-6,15,-20,15,-6,1];
p3=horner2(a,x);

plot(x,p1,x,p2,x,p3); 
legend('p1','p2','p3');

% si dimostra che la forma p2 è la peggiore per rappresentare p.
% anche p3 non si comporta molto bene. La causa di questo è l'errore degli
% annullamenti di quantità molto piccole del polinomio: siamo in un intorno
% di 1, quindi il valore del polinomio è in un intorno di zero..