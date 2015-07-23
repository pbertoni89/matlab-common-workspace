%close all;
clear all;


x0=[25,10]';
tout=1;
e1=40;
e2=10;
p=0.2;
e=0.1;
k1=800;
%k1=4000;

xeq1=[0,0]';
xeq2=[k1,0]';
xeq3=[e2/(e*p),(e1/p)*(1-e2/(e*p*k1))];

% Calcolo delle matrici del sistema linearizzato nei due punti di equilibrioù
 
[A, B, C, D]=linmod('lotka2_sim',xeq1)
eig(A)
[A, B, C, D]=linmod('lotka2_sim',xeq2)
eig(A)
[A, B, C, D]=linmod('lotka2_sim',xeq3)
eig(A)
figure;
[T,xout,simout]=sim('lotka2_sim');
plot(xout(:,1),xout(:,2),'b-');
hold on
plot(xeq1(1),xeq1(2),'ro');
plot(xeq2(1),xeq2(2),'ro');
plot(xeq3(1),xeq3(2),'ro');

