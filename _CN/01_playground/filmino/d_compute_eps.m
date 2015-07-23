% eps è il più piccolo numero macchina che sommato a 1 restituisce un
% numero maggiore di 1.

epsilon=1;

while epsilon+1 > 1
	epsilon=epsilon/2;
end

% vanifica l'ultima divisione. in MATLAB non esiste il do{} while()!!!
epsilon=epsilon*2;

disp('epsilon ='); epsilon
disp('eps ='); eps