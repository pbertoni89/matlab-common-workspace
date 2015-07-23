function [ f ] = protone( t, x )
%Restituisce una funzione f: f = F(t,x) con x vettore.
% generalmente usiamo y nel contesto delle ode; 
% qua useremo x per il suo senso fisico (la posizione).

% f in ogni colonna iesima ha la derivata prima della x iesima.
% quindi nelle prime tre ha le velocità,
% nelle seconde tre ha le accelerazioni. 

% costretto a hardcode per come richiamo l'handle
v0 = [1.e7 0 0]';

% WRN: x è una matrice 3,1; NON contiene il TEMPO!!!
f = zeros(size(x)); % dimensioni 2*n, 1

E = [0 0 0]; B = [0 0 1.3e-7];
m = 1.67e-27; q = 1.6e-19;

% le funzioni dello spazio sono velocità!
v = x(4:6); f(1:3) = v;
% le funzioni delle velocità sono accelerazioni!
f(4) = (q/m)*(E(1)*t+B(3)*x(2)-B(2)*x(3)) + v0(1);
f(5) = (q/m)*(E(2)*t-B(3)*x(1)+B(1)*x(2)) + v0(2);
f(6) = (q/m)*(E(3)*t+B(2)*x(1)-B(1)*x(2)) + v0(3);

end

