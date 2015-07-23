function [tt,u]=schema(odefun,tspan,y0,Nh)
% [tt,u]=schema(odefun,tspan,y0,Nh,varargin);
tt=linspace(tspan(1),tspan(2),Nh+1);
h=(tspan(2)-tspan(1))/Nh; 
y=y0(:);
w=y; u=y.';
hh=h*0.5; h12=h/12; h6=h/6;
t=tt(1); k1=odefun(t,w);
t1 = t + hh; w1 = w + hh* k1;
k2=odefun(t1,w1);
t1 = t + h; w1 = w + h*(2*k2-k1);
k3=odefun(t1,w1);
w=w + h6*(k1+4*k2+k3);
u = [u; w.'];
fnm1=k1;
fn=odefun(tt(2),w);
for t=tt(2:end-1)
t1=t+h;
w_tilde= w + hh*(3*fn-fnm1);
f_tilde=odefun(t1,w_tilde);
w_new=w+h12*(5*f_tilde+8*fn-fnm1);
f_new=odefun(t1,w_tilde);
w=w_new; fnm1=fn; fn=f_new;
u = [u; w.'];
end
tt=tt';
end
