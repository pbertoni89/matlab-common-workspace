function [px] = horner2(a,x)
%
% Valuta un polinomio di grado n 
%              p(x) = a_1 x^n + ... + a_{n+1}
%   con il metodo di Horner
%
%    p(x)=a_1+x*(a_2+x*(a_3 +x*(.....+x*a_{n+1})))
%
% Parametri di ingresso
%   a     vettore contenente i coefficienti del polinomio
%         da valutare
%   x     vettore di punti nei quali si vuole valutare il polinomio
%
% Parametri di uscita
%   px    vettore dei valori del polinomio nei punti di x
%
% function [px] = horner2(a,x)
%

	n=length(a)-1;
	px=a(1);
	for j=2:n+1
		px=a(j)+px.*x;
	end
end