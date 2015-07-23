clear all; close all; clc;
%definizione dei vettori x1,x2 ed il vettore delle uscite y
x1=[3 2 1 3]';
x2=[5 2 2 3]';
y=[7 10;4 5;2 3;6 6];

%definizione della Matrice M
M=[x1 x2];  

% Calcolo del vettore contenente i parametri del modello (t)
t = (inv(M'*M))*M'* y;

%coefficienti delle due curve
t = t'

a=t(1,1);
b=t(1,2);
c=t(2,1);
d=t(2,2);

%fprintf('\ndifatti %d ~= %d',y(1,1),a*x1(1)+b*x2(1))
%fprintf('\ndifatti %d ~= %d',y(1,2),c*x1(1)+d*x2(1))

%provo a stimare punti nuovi (il secondo nuovo uguale a uno esistente)
x1 = [ x1; 4; 1; 6; 2; 5];
x2 = [ x2; 4; 2; 7; 8; 1];

subplot(1,2,1); stem(x1(1:4),y(:,1),'*b'); hold on;
plot(x1,a*x1+b*x2,'r');
subplot(1,2,2); stem(x2(1:4),y(:,2),'*b'); hold on; 
plot(x2,c*x1+d*x2,'r');


