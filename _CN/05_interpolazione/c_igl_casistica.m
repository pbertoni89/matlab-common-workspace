clear all; close all; clc;

%% Convergenza con nodi Equispaziati (roundoff portano divergenza)

f = @(x) sin(pi*x); 
just_errors = 1; % if 0 plots every interp

xa = -pi; xb = pi;
xext = linspace(xa, xb, 500); % x estesa
yext = f(xext);

Ef = []; prove = 4:4:80;

for n = prove;
	
	xn = linspace(xa, xb, n+1);
	yn = f(xn);

	vdm = vander(xn);
	an = vdm\yn';

	pn = polyval(an,xext);
	if just_errors == 0
		figure();
		plot(xext,yext,'b'); hold on;
		plot(xn, yn, 'k^'); title(['n=',num2str(n)]);
		plot(xext, pn, 'r'); legend('f(x)','y_n','p_n');
	end
	
	Ef = [ Ef max(abs(yext-pn)) ];
end

figure()
semilogy(prove, Ef); legend('max(En)');
% L’errore decresce fino a circa n = 32, poi tende a crescere
% per effetto della propagazione degli errori di arrotondamento. 
% In questo caso possiamo concludere che 
% i polinomi pn -> f per n -> Inf ? 
% sì, in assenza di errori di arrotondamento!
% difatti con n sostanziosi il condizionamento di vdm diventa assurdo
fprintf('K(X) con n = %i: %d\n',n,cond(vdm));
% si arriva a K(X) = .e+52 con n = 80

%% Divergenza con nodi Equispaziati

% f = @(x) 1./(x.^2+1);
% xa=-5; xb=5;

% ..... copio script

% qua l'errore inizia a sollevarsi. Ricordiamo che
% essendo i nodi equispaziati NON CONOSCO CSUFF per la CVG.

%% Convergenza con Nodi di Chebychev (roundoff portano divergenza)

f = @(x) 1./(x.^2+1);
xa=-5; xb=5;
just_errors = 1;

xext = linspace(xa, xb, 500);
yext = f(xext);

Ef = []; prove = 4:4:80;

for n = prove;
	
	xn = chebyspace(xa,xb,n);
	yn = f(xn);

	vdm = vander(xn);
	an = vdm\yn';

	pn = polyval(an,xext);
	if just_errors == 0
		figure();
		plot(xext,yext,'b'); hold on;
		plot(xn, yn, 'k^'); title(['n=',num2str(n)]);
		plot(xext, pn, 'r'); legend('f(x)','y_n','p_n');
	end
	
	Ef = [ Ef max(abs(yext-pn)) ];
end

figure('name','Errori con Chebychev')
semilogy(prove, Ef); legend('max(En)');