clear;

which lancia_segnali;

% Disegno segnali elementari.

t= -5:.1:5;   % tempo base

t1= -5:.01:5;  % tempo più fine

t2= -5:.001:5; % tempo finissimo

% Dichiarazione delle funzioni
x=my_eps(t2);
y=my_rect(t2);
z=my_tri(t2);
w=my_gauss(t2);

% Inizia il plotting delle funzioni

 % Gradino
plot(t2, x, 'r');
fprintf(' gradino(8) vale %f\n', x(4));
hold on;
axis( [min(t2) max(t2) min(x)-1 max(x)+1] )

pause;
hold off;

 % Rettangolo
 plot(t2, y, 'r');
hold on;
axis( [min(t2) max(t2) min(y)-1 max(y)+1] )

pause;
hold off;

 % Triangolo
 plot(t2, z, 'r');
hold on;
axis( [min(t2) max(t2) min(z)-1 max(z)+1] )

pause;
hold off;

 % Gauss
 plot(t2, w, 'r');
hold on;
axis( [min(t2) max(t2) min(w)-1 max(w)+1] )

pause;
hold off;

return;