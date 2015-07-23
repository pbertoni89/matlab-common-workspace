function reale = polreal(z)
% function reale = polreal(z) restituisce il valore 1 se il polinomio 
% con radici z è a coefficienti reali, 0 in caso contrario

reale=0;
p=poly(z);
x=find(imag(p)~=0);
if isempty(x) reale=1; end
return;
