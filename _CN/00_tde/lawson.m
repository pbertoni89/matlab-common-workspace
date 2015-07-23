function [tt,u]=lawson(odefun,tspan,y0,Nh,varargin)
%LAWSON  Risolve equazioni differenziali
%   usando il metodo di Runge-Kutta4 esplicito.
%   [T,Y] = LAWSON(ODEFUN,TSPAN,Y0,NH) con
%   TSPAN = [T0,TF] integra il sistema di equazioni
%   differenziali y' = f(t,y) dal tempo T0 a TF con
%   condizione iniziale Y0 usando il metodo di 
%   Lawson (RK) esplicito su una griglia equispaziata di 
%   Nh intervalli.
%   La funzione ODEFUN(T,Y) deve ritornare un vettore
%   contenente f(t,y), della stessa dimensione di y.
%   Ogni riga del vettore soluzione Y corrisponde ad
%   un istante temporale del vettore colonna T.
%   [T,Y] = LAWSON(ODEFUN,TSPAN,Y0,NH,P1,P2,...) passa
%   i parametri addizionali P1,P2,... alla funzione
%   ODEFUN come ODEFUN(T,Y,P1,P2...).

tt=linspace(tspan(1),tspan(2),Nh+1);
h=(tspan(2)-tspan(1))/Nh; hh=h*0.5; 
y=y0(:);
w=y; u=y.';
h2=h/2; h4=h/4;h34=3*h4; h16=h/16; h7=h/7; h90=h/90;
for t=tt(1:end-1)
  
  k1=feval(odefun,t,w,varargin{:});
  t1 = t + h2; w1 = w + h2* k1;
  k2=feval(odefun,t1,w1,varargin{:});
  t1 = t + h4; w1 = w + h16*(3*k1+k2);
  k3=feval(odefun,t1,w1,varargin{:});
  t1 = t + h2; w1 = w + h2*k3;
  k4=feval(odefun,t1,w1,varargin{:});
  t1 = t + h34; w1 = w + h16*(-3*k2+6*k3+9*k4);
  k5=feval(odefun,t1,w1,varargin{:});
  t1 = t + h; w1 = w + h7*(k1+4*k2+6*k3-12*k4+8*k5);
  k6=feval(odefun,t1,w1,varargin{:});
  w=w + h90*(7*k1+32*k3+12*k4+32*k5+7*k6);
  u = [u; w.'];

end

tt=tt';
end