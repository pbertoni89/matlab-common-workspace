clear all; close all; clc;
% stimare sperimentalmente p e q
% della fdq composita contenuta in "quad2c.m".

%% grado di precisione p
% grado del polinomio interpolatore di lagrange 
% usato nella formula di Newton Cotes relativa. 

% massimo grado polinomiale per cui l'integrale è ESATTO.

% iniziamo a dare in pasto alla fdq monomi crescenti
xa = 0; xb = 1;
% f = x.^k integrato tra 0 e 1 deve restituire 1/(k+1) per ogni k>=1
k = 1; kmax = 10; encore = 1;
while k<kmax && encore==1
	f = @(x) x.^k;
	Iexe = 1/(k+1);
	Ifdq = quad_mistero_c(f,xa,xb,1);
	if abs(Iexe-Ifdq) > eps 
		p = k-1;
		fprintf('L''ordine di precisione è %d\n',p);
		encore = 0;
	end
	k = k+1;
end

%% ordine di accuratezza q
% (qualora gli n intervalli siano equispaziati)
% grado del monomio H^q per cui l'errore commesso è proprorzionale.
clear all; xa = 0; xb = 1;
n_vet = [10 20 40 80 160 320];
Err4 = []; Err5 = [];
% Siccome la precisione 3 è raggiunta, proviamo con x^5.
% potrei anche con x^4, certo.
f4 = @(x) x^4; f5 = @(x) x^5;
Iexe4 = 1/(4+1); Iexe5 = 1/(5+1)
for n = n_vet
	I4 = quad_mistero_c(f4,xa,xb,n);
	I5 = quad_mistero_c(f5,xa,xb,n);
	Err4 = [Err4 abs(I4-Iexe4)];
	Err5 = [Err5 abs(I5-Iexe5)];
end

H = (xb-xa)./n_vet;
loglog(H,Err4,H,Err5, H,H, H,H.^2, H,H.^3, ...
	H,H.^4, H,H.^5);
grid on;
legend('Err x^4','Err x^5','H^1','H^2','H^3','H^4','H^5',2);
% errori chiaramente paralleli ad H^4, solo traslati
% => l'ordine di accuratezza è 4.