clear all; close all; clc;

N = (10000:10000:100000)';

CPU = [0.312002 0.998406 2.293215 4.102826 6.411641 ...
	   9.204059 12.604881 16.317705 20.826134 25.474963]';
   
% so che CPU = C * N^p   con C reale, p intero.

N_ex = linspace(N(1), N(end), length(N)*100);

% non so ancora che grado mi basterà...
% data la forma C*N^p     elimino i termini di grado <p
a1 = polyfit(N,CPU,1);	  a1(2:end)=0;
a2 = polyfit(N,CPU,2);	  a2(2:end)=0;
a3 = polyfit(N,CPU,3);	  a3(2:end)=0;

% accorgersi che ciò che pesa è p=2 non eliminando a(2:end)=0
% e osservando che in a3 si ha a3(2)>>a3(1) cioè grado terzo inutile

CPUr1_ex = polyval(a1,N_ex);
CPUr2_ex = polyval(a2,N_ex);
CPUr3_ex = polyval(a3,N_ex);

plot(N_ex, CPUr1_ex, 'r--'); hold on;
plot(N_ex, CPUr2_ex, 'g--');
plot(N_ex, CPUr3_ex, 'b--');
plot(N,CPU,'ko'); legend('n^1','n^2','n^3','x_i,y_i');

% vediamo che è sufficiente un p=2 per una perfetta approssimazione.
% lo sappiamo perchè
if(a3(1)<1.e-10)
	fprintf('E'' sufficiente p=2 per l''approssimazione');
end
% e anche perchè C*N^3 + 0*N^2 produce una schifezza.

% come trovare C? gio dice che è il primo elemento di a2.
asynt = CPU./(N.^2); C = asynt(end)
% ma anche
C = a2(1)