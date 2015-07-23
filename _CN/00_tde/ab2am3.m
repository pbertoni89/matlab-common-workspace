function [tt,u]=ab2am3(odefun,tspan,y0,Nh,varargin)
%AB2AM3  Risolve equazioni differenziali
%   usando un metodo multistep
%   [T,Y] = AB2AM3(ODEFUN,TSPAN,Y0,NH) con
%   TSPAN = [T0,TF] integra il sistema di equazioni
%   differenziali y' = f(t,y) dal tempo T0 a TF con
%   condizione iniziale Y0 usando il metodo di 
%   predictor corrector su Nh intervalli equispaziati con 
%   predictor= Adams-Bashfort 2 esplicito 
%   corrector= Adams-Moulton 3 implicito
%   La funzione ODEFUN(T,Y) deve ritornare un vettore
%   contenente f(t,y), della stessa dimensione di y.
%   Ogni riga del vettore soluzione Y corrisponde ad
%   un istante temporale del vettore colonna T.
%   [T,Y] = AB2AM3(ODEFUN,TSPAN,Y0,NH,P1,P2,...) passa
%   i parametri addizionali P1,P2,... alla funzione
%   ODEFUN come ODEFUN(T,Y,P1,P2...).

tt=linspace(tspan(1),tspan(2),Nh+1);
h=(tspan(2)-tspan(1))/Nh; 
y=y0(:);
w=y; u=y.';
hh=h*0.5; h12=h/12; h6=h/6;
% calcolo il secondo dato iniziale con RK3
t=tt(1);
  k1=odefun(t,w,varargin{:});
  t1 = t + hh; w1 = w + hh* k1;
  k2=odefun(t1,w1,varargin{:});
  t1 = t + h; w1 = w + h*(2*k2-k1);
  k3=odefun(t1,w1,varargin{:});
  w=w + h6*(k1+4*k2+k3);
u = [u; w.'];
fnm1=k1;
% calcolo il passo generico
for t=tt(2:end-1)
  fn=odefun(t,w,varargin{:});
  t1=t+h;
  w_tilde= w + hh*(3*fn-fnm1);
  f_tilde=odefun(t1,w_tilde,varargin{:});
  w=w+h12*(5*f_tilde+8*fn-fnm1);
  fnm1=fn;
  u = [u; w.'];
end

tt=tt';
end