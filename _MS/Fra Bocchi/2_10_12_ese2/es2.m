%es2
close all
clc 
clear
%punti di equilibrio

xeq1 = [0 0]'
xeq2 = [2 4]'
xeq3 = [-1 1]'
x0 = [-1 -1]'


%linearizzo il sistema con i tre punti di equilibrio
%linearizzo il sistema
[A B C D] = linmod('es2_sim',xeq1)
%autovalori e autovettori
[autovet_xeq1,autoval_xeq1] = eig(A);

%linearizzo il sistema
[A B C D] = linmod('es2_sim',xeq2)
%autovalori e autovettori
[autovet_xeq2,autoval_xeq2] = eig(A);


%linearizzo il sistema xeq3
[A B C D] = linmod('es2_sim',xeq3)
%autovalori e autovettori
[autovet_xeq3,autoval_xeq3] = eig(A);

%simulare T tempo
[T,xout,simout] = sim('es2_sim');

%traettoria e movimento
plot(xout(:,1),xout(:,2),'b-');
axis([-20 20 -20 20])

figure
plot(T,xout(:,1),'b-');
hold on
plot(T,xout(:,2),'r-');
hold off

