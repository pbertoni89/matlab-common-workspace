which my_segnali;

% Disegno segnali elementari.

t= -5:.1:5;   % tempo base

t1= -5:.01:5;  % tempo più fine

t2= -5:.001:5; % tempo finissimo

%disp(t);

% disegnare x(t)= 1+5sen^2(t)

x = 5*( sin(t2).^2 )+1;  % .^ è array power.   ^ è matrix power

plot(t2,x,'r'); % disegna x su t, in rosso.
hold on; % conserva quanto graficato finora nella finestra. Se non ci fosse, ridisegnerei daccapo

axis( [min(t) max(t) min(x)-1 max(x)+1] )  % scala le assi cartesiane

y = plot(t,5*sin(t)+1,'b');   % plot diretto

axis tight;  % assi minime contenenti il disegno

figure % apre una nuova finestra
plot(t,t.^2,'k*'); % disegno una parabola usando delle stars nere

pause;
close; % chiude la finestra del grafico corrente
pause;
close all; % chiude tutte le finestre

pause;
plot(t2,[x;t2.^2] );  % devo usare t2 perchè della stessa dimensione di x
%plot(t,x,'r',t,t.^2,'k');

return;