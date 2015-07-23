clear all; close all; clc;

f1 = @(x) x^2;
fI = @(x) x^3/3;

xa = 0; xb = 10;
%x = linspace(xa,xb,1000);
%y = f(x);

I = fI(xb)-fI(xa)

Mvet = 1:1:10; % numero di punti per le integrazioni composite.

Epm = []; Et = []; Empm = []; Emt = [];
for M = Mvet
	Ipm =  i_c_pm(f1,xa,xb,M); Epm = [ Epm abs(I-Ipm) ];
	%Impm = midpointc(xa,xb,M,f1); Empm = [ Empm abs(I-Impm) ];
	It =  i_c_trap(f1,xa,xb,M); Et = [ Et abs(I-It) ];
	%Imt = trapz(xa,xb,M,f1); Emt = [ Emt abs(I-Imt) ];
	
end

H = (xb-xa)./Mvet; % è la stessa computata dentro i_c_pm
figure(1);
loglog(H,Epm,'r',H,Et,'g',H,H.^2,'b'); 
grid on;
legend('E_{PM}','E_{T}', 'H^2');
% voglio verificare l'upperbound sulla differenza in modulo dell'Err.
% Vedendo che esso è una scalatura di un valore della d2f,
% considerato che d^2(f)/dx^2 = costante, si osserva che
% effettivamente il puntomedio composito ha q=2.