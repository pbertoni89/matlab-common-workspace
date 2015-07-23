close all;
clear all;


x0=[25,10]';
% tout=1;
e1=40;
e2=20;
p=0.3;
e=0.2;
k1=150;

% Disegno delle isocline dell'equazione 1
% Disegno x1=0
x2_iso1=[-500:1:500];
x1_iso1=zeros(length(x2_iso1),1);
plot(x1_iso1,x2_iso1,'r-');
hold on;

% Disegno x2=1/(pe1)-e1/(pk1)n1 => è una retta...
x1_iso1=[0,500];
x2_iso1=[];
x2_iso1(1)=e1/(p)-e1/(p*k1)*x1_iso1(1);
x2_iso1(2)=e1/(p)-e1/(p*k1)*x1_iso1(2);
plot(x1_iso1,x2_iso1,'r-');

% Disegno delle isocline dell'equazione 2
% Disegno x1=e2/(ep)
x2_iso2=[-500:1:500];
x1_iso2(1:length(x2_iso2))=e2/(e*p);
plot(x1_iso2,x2_iso2,'b.');
x2_iso2=[];
x1_iso2=[];
% Disegno x2=0
x1_iso2=[0:1:500];
x2_iso2(1:length(x1_iso2))=0;
plot(x1_iso2,x2_iso2,'b.');
hold off;

xeq1=[0,0]';
xeq2=[k1,0]';

% Calcolo delle matrici del sistema linearizzato nei due punti di equilibrioù
 
[A, B, C, D]=linmod('lotka2_sim',xeq1)
eig(A)
[autovet_xeq1,autoval_xeq1]=eig(A)
[A, B, C, D]=linmod('lotka2_sim',xeq2)
eig(A)
figure;
[T,xout,simout]=sim('lotka2_sim');
plot(xout(:,1),xout(:,2),'b-');
hold on
plot(xeq1(1),xeq1(2),'ro');
plot(xeq2(1),xeq2(2),'ro');