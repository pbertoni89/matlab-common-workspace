clear all; close all; clc;

L = .1; R1 = 10; R2 = R1; C = 1.e-3; E = 5; t0 = 0; T = .1;

dy = @(t,y) [ y(2); 
			 (1/(L*C))*( E - (R1*C+L/R2)*y(2)  - (1+R1/R2)*y(1)) ];
y0 = [0,0];

% voglio studiare l'evoluzione temporale v=y1 e dv=y2
% non scrivo il sistema in forma matriciale; provo degli h suggeriti
% faccio tutto con eulero esplicito; il focus NON è sui metodi.

H = [ .001 .005 .01 .02 ]; i=0;
N = ceil((T-t0)./H);

for h = H, i=i+1;
	h
	tic
	[ t y ] =  eul_expl(dy, [t0 T], y0, N(i));
	toc
	figure(i); 
	subplot(2,2,1); plot(t,y(1,:),'r'); legend('v(t)');
	subplot(2,2,2); plot(t,y(2,:),'b'); legend('v''(t)');
	subplot(2,2,3); plot(y(1,:),y(2,:),'b'); 
		hold on; plot(0,0,'or'); title(['h= ',num2str(h)]);
end
% per gli ultimi due h osserviamo delle OSCILLAZIONI NUMERICHE
% che portano al BLOW-UP, per MANCANZA DI STABILITA' ASSOLUTA.

 A = [ 0, 1 ; -(1+R1/R2)/(L*C), -(R1*C+L/R2)/(L*C) ]; 
 avals = eig(A);
 H0 = -2*real(avals)./(abs(avals).^2)
 fprintf('h scelto dev''essere minore di %f \n', unique(min(H0)));
 
 % il che ci conferma il precedente asserto.