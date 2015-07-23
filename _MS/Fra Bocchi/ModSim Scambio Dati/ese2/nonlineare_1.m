close all;
clear all;

xeq1=[0,0]';
xeq2=[2,1]';
x0=[-30,-30]';

[A, B, C, D]=linmod('nonlineare_1_sim',xeq1);
[autovet_xeq1,autoval_xeq1]=eig(A)

[A, B, C, D]=linmod('nonlineare_1_sim',xeq2);
[autovet_xeq2,autoval_xeq2]=eig(A)

[T,xout,simout]=sim('nonlineare_1_sim');
plot(xout(:,1),xout(:,2),'b-');
axis([-5 10 0 40])
