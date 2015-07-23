function [ f ] = fun_ptosfera( t, x )
%Restituisce una funzione f: f = F(t,x) con x vettore.
% generalmente usiamo y nel contesto delle ode; 
% qua useremo x per il suo senso fisico (la posizione).

% f in ogni colonna iesima ha la derivata prima della x iesima.
% quindi nelle prime tre ha le velocità,
% nelle seconde tre ha le accelerazioni. 

% WRN: x è una matrice 3,1; NON contiene il TEMPO!!!

n = 3;
f = zeros(size(x)); % dimensioni 2*n, 1

m = 1; g = 9.81;
FG = [0 0 -g*m]';
H = 2*eye(n);

GR = 2*x(1:3);
v = x(4:6); 

% le funzioni dello spazio sono velocità!
f(1:3) = v;
% le funzioni delle velocità sono accelerazioni!
f(4:6) = (FG-GR*((m*v'*H*v+FG'*GR))/(GR'*GR))/m;

end

