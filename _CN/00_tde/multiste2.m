function [tn,un] = multiste2(t0,T,y0,odefun,h)
% Risoluzione problema di Cauchy y' = f(t,y) con
%  il metodo multistep u_{n+1}=u_n+h/12*(23f_n-16f_{n-1}+5f_{n-2})
%    function [tn,un] = multiste2(t0,T,y0,odefun,h)
%
%   Input: t0= istante iniziale
%          T = istante finale
%          y0 = condizione iniziale (vettore colonna se si risolve un sistema)
%          odefun = funzione del problema di Cauchy, definita con @
%            oppure tramite function. Puo' essere una funzione scalare
%            od una funzione vettoriale. Nel caso di funzione vettoriale,
%            per t scalare e y vettore, odefun(t,y) deve ritornare un vettore 
%            colonna della stessa dimensione di y.
%              Es.: y vettore di due componenti.
%                   function [f]=odefun(t,y)
%                   n=length(y); f=zeros(n,1);
%                   f(1)=3*t*cos(y(1)+y(2));
%                   f(2)=-3*sin(y(1));
%
%          h= passo di discretizzazione (costante)
%          
%   Output: tn =vettore colonna con i nodi di discretizzazione
%           un = array contenente le componenti della soluzione 
%                numerica. Su ogni riga di un c'e' una componente della
%                soluzione (se questa e' di tipo vettoriale)
%

N = ceil(abs(T-t0)/h)+1;
tn = linspace(t0,T,N);
h = tn(2)-tn(1);
un(:,1) = y0;
hmezzi=h*0.5; h34=h*0.75; h9=h/9;
% calcolo il secondo e il terzo dato iniziale con RK3
for n=1:2
K1=odefun(tn(n),un(:,n)); K2=odefun(tn(n)+hmezzi,un(:,n)+hmezzi*K1);
K3=odefun(tn(n)+h34,un(:,n)+h34*K2);
un(:,n+1) = un(:,n) + h9*(2*K1+3*K2+4*K3);
end
f1=odefun(tn(1),un(:,1));
f0=odefun(tn(2),un(:,2));

for n = 3:N-1
    f2=f1;f1=f0;
    f0=odefun(tn(n),un(:,n));
un(:,n+1) = un(:,n) + h/12*(23*f0-16*f1+5*f2);
end

tn=tn';