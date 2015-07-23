clc, clear all

A=[3 1;5 2]
B=[1;0]
C=[1 0]

ueq = 1;
x0 = [1 1];

xeq = -inv(A)*B*ueq
autoval = eig(A)

rangoR=rank(ctrb(A,B))

%CASO a
autoval=[-0.2 -10]; % reali con dominante = -1/5
%CASO b
%autoval=[-1 -10];   % reali con dominante t.c.
%   (5*tau_dom) = 5. Nel caso in esame, tau_dom = 1 => polo_dom = -1
%CASO c
% autoval=[-0.5+i -0.5-i]; cplx coniugati con parte reale -(5/10)=-0.5
%CASO d
% autoval=[-1 -2] % come a per dominante, 
% l'altro lo si sceglie tramite simulazione

K = place(A,B,autoval)
eig(A-B*K)

sim('es3_sim', [0 10]); % start/stop time