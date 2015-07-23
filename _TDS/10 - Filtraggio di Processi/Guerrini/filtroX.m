function y = filtroX(x,t)
% Filtro misterioso
%
% y = filtroMisterioso(x,t)
%

dt = t(2)-t(1);

h = exp(-t).*rect(t-1);

supportStart = t(min(find(h~=0)));

h = h(h~=0);

y = myshift(filter(h,1,x)*dt,supportStart/dt);