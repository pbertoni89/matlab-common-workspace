clear all; close all; clc; format shorte;
na = 2; nb = 14;
ERR = []; KA = []; DX = [];


%% studio come errore su soluzione dipenda da errori sui dati.

for n = na:nb
	clear A b
	A = hilb(n);
	xesat = ones(n,1);
	
	for i=1:n
			b(i) = sum(1./(i:i+n-1));
	end
	
	b = b';
	x = A\b;
	% errori MOLTO GROSSI su una matrice piccola che non dovrebbe
	% rappresentar problemi... alziamo n e peggiora ancora.
	e = norm(x-xesat)/norm(x); % errore relativo
	% dovrei ora usare il cond della A vera, non di quella di macchina
	k = cond(A); d = k*eps;
	ERR = [ ERR e]; KA = [ KA k]; DX = [ DX d];
	if e >= d
		disp('vi è qualche implementazione sbagliata.')
	end
end

figure(1); 
% l'errore relativo converge a 1
subplot(1,3,1); plot(na:nb, ERR,'b');legend('ERR');
subplot(1,3,2); plot(na:nb, DX, 'g'); legend('DX=KA \epsilon');
subplot(1,3,3); plot(na:nb, KA, 'r'); legend('KA');