function [tt,u]=multiste1(odefun,tspan,y0,Nh,varargin);
%MULTISTE1  Risolve equazioni differenziali
%   usando un metodo multistep
%   [T,Y] = MULTISTE1(ODEFUN,TSPAN,Y0,NH) con
%   TSPAN = [T0,TF] integra il sistema di equazioni
%   differenziali y' = f(t,y) dal tempo T0 a TF con
%   condizione iniziale Y0 usando il metodo di 
%   multistep esplicito su una griglia equispaziata di 
%   Nh intervalli.
%   La funzione ODEFUN(T,Y) deve ritornare un vettore
%   contenente f(t,y), della stessa dimensione di y.
%   Ogni riga del vettore soluzione Y corrisponde ad
%   un istante temporale del vettore colonna T.
%   [T,Y] = MULTISTE1(ODEFUN,TSPAN,Y0,NH,P1,P2,...) passa
%   i parametri addizionali P1,P2,... alla funzione
%   ODEFUN come ODEFUN(T,Y,P1,P2...).

tt=linspace(tspan(1),tspan(2),Nh+1);
h=(tspan(2)-tspan(1))/Nh; 
y=y0(:);
w=y; u=y.';
terzo=1/3; dueterzi=2/3; h6=h/6;
hmezzi=h*0.5;
% calcolo il secondo dato iniziale con RK2
t=tt(1);
k1=feval(odefun,t,w,varargin{:});
t1 = t + hmezzi; w1 = w + hmezzi*k1;
k2=feval(odefun,t1,w1,varargin{:});
w1=w + hmezzi*(k1+k2);
u = [u; w1.'];
f0=k1;
f1=feval(odefun,tt(2),w1,varargin{:});
% calcolo il passo generico
for t=tt(2:end-1)
  w_new= terzo*w1 + dueterzi*w + h6*(11*f1-f0);
  w=w1;
  w1=w_new;
  f0=f1;
  f1=feval(odefun,t,w1,varargin{:});
  u = [u; w1.'];
end

tt=tt';