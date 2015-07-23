%esercizio 1

clear all
close all

%punti di equilibrio più condizione inzizlae
xeq1 = [0,0]';
xeq2 = [2,1]';
x0 = [10,10];

[A, B, C, D] = linmod('es1_sim', xeq1); %prendo il sistema simulink fato e gli dico
%di lieanrizzarlo con xeq1
[autovet_xeq1, autoval_xeq1] = eig(A);


%faccio la stessa cosa con xeq2
[A, B, C, D] = linmod('es1_sim', xeq2); %prendo il sistema simulink fato e gli dico
%di lieanrizzarlo con xeq1
[autovet_xeq2, autoval_xeq2] = eig(A);%calcola autovettori e autovalori


%simulare T tempo
[T,xout,simout] = sim('es1_sim');

%traettoria e movimento
plot(xout(:,1),xout(:,2),'b-');
axis([-20 20 -20 20])

figure
plot(T,xout(:,1),'b-');
hold on
plot(T,xout(:,2),'r-');
hold off

