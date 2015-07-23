function [an] = c_succ_e(N)
%C_SUCC_E Summary of this function goes here
% valore N molto grande, ad es. N = 10^20) 
% e che costruisca due vettori nn, an che contengono 
% rispettivamente n e an per alcuni valori
% n ? N : 1 ? n ? N e li rappresenti graficamente.

% hint:   a=[a;x] mette in coda ad a il valore x (scalare xor vettore)
	L10N = fix(log10(N))+1;
	espo = exp(1)*ones(L10N,1);
	an = zeros(L10N,1); nn = an;
	% an(1) = 2; % piede di ricorsione fisso a n=1 => (1+1)^1
	i=1;
	while(i<=N)
		I = fix(log10(i));
		an(I+1) = (1+1/i)^i;
		nn(I+1) = i;
		i=i*10; % progressione logaritmica
	end
	
	semilogx(nn, an, 'o', nn, espo, 'r--');
end

