
dx = A*x+B*u;
y  = C*x;

ueq = 1;

xeq = inv(A)*B*ueq;

% per il controllo dobbiamo modificare il sistema. 
% invece di mettere una u costante, metto
% u = ueq - K*(x-xeq)
%che esprime la lontananza dall'equilibrio. d'altronde x=xeq => u=ueq

% ATTENZIONE: abbiamo ribaltato il segno rispetto a MODSIM, e siamo tornati
% alla notazione di Matlab. pertanto ciò che verrà restituito da place(..)
% NON dovrà essere cambiato di segno.

% TR = 5*TD
% TD = 1/abs(real(lambdaD)))  con D==dominante

% lambdaD = -1 => domino con -10

% a = [-1 -10]

% b = [-.5+-1i]
