close all;
clear all;

xeq1=[0,0]';
xeq2=[2,4]';
xeq3=[-1,1]';

x0=[-1,-1]';

[A, B, C, D]=linmod('nonlineare_2_sim',xeq1);
A
[autovet_xeq1,autoval_xeq1]=eig(A)

[A, B, C, D]=linmod('nonlineare_2_sim',xeq2);
A
[autovet_xeq2,autoval_xeq2]=eig(A)

[A, B, C, D]=linmod('nonlineare_2_sim',xeq3);
A
[autovet_xeq2,autoval_xeq2]=eig(A)

[T,xout,simout]=sim('nonlineare_2_sim');
plot(xout(:,1),xout(:,2),'b-');
