function x = tri(t)
%TRI   Triangolo
%  TRI(t) implementa la funzione triangolo
%
%       tri(t) = 1-|t| se |t|<1
%              = 0     se |t|>=1
%
%  Opera su vettori.


% *******************************************************************
% ** COMMENTARE I DIVERSI BLOCCHI PER USARE I DIVERSI METODI       **
% **                                                               **
% ** in tutto il file abs() è la funzione modulo (valore assoluto) **
% *******************************************************************


% *******************************************************************
% Metodo 1 (lento): scorre tutto il vettore e decide il valore del 
% segnale in ogni punto. I punti qui sono specificati usando 
% l'indice k (ovvero i punti sono i t(k))
% 
% length(t) indica il numero di punti dell'asse
% *******************************************************************
%
% for k = 1:length(t)
%     if (t(k)>-1) && (t(k)<1)
%       x(k) = 1-abs(t(k));
%     else 
%       x(k) = 0;
%     end
% end


% *******************************************************************
% Metodo 2 (lento): scorre tutto il vettore e decide il valore del 
% segnale in ogni punto. Simile a prima ma mostra un caso in cui
% viene usata l'istruzione elseif
% *******************************************************************
%
% for k = 1:length(t)
%     if (t(k)>-1) && (t(k)<=0)
%       x(k) = 1+t(k);
%     elseif (t(k)>0) && (t(k)<=1)
%       x(k) = 1-t(k);
%     else 
%       x(k) = 0;
%     end
% end
% 


% *******************************************************************
% Metodo 3: usa le operazioni logiche su vettori
% In questo caso non viene usato nessun indice sull'asse, ma
% l'operazione è eseguita su tutti i punti t(k) in modo automatico.
% 
% L'espressione (abs(t)<=1) "seleziona" i punti compresi tra -1 e 1 
% (comando usato per il rettangolo).
% In questi punti la funzione è (1-abs(t)).
% 
% N.B. - dettaglio tecnico matlab - 
% L'espressione (abs(t)<=1), usata in questo esempio, assume valori 
% boolean, ovvero solo 1 o 0. 1 indica vero, e 0 indica falso. Questi
% valori si possono usare per creare segnali ma bisogna prestare
% attenzione ai tipi di dati. I vettori che rappresentano i segnali
% devono essere tutti di tipo double (eventualmente "complex").
% Per convertire i boolean in double è sufficiente mettere un cast,
% ad esempio in questo caso scrivere double(abs(t)<=1). Nell'esempio
% questo non è fatto perchè, moltiplicando per (1-abs(t)), che
% assume valori reali, Matlab effettua il cast automaticamente e usa
% il tipo double per la variabile x.
% *******************************************************************

x = (abs(t)<=1).*(1-abs(t));


% *******************************************************************
% Metodo 4: usa le operazioni logiche su vettori
%
% L'espressione (t>-1 & t<=0) "seleziona" i punti compresi tra -1 e 0
% (comando simile a quello usato per il rettangolo). In questi punti
% la funzione è (1+t).
%
% L'espressione (t>0 & t<=1) "seleziona" i punti compresi tra 0 e 1.
% In questi punti la funzione è (1-t).
% *******************************************************************
%
% x = ((t>-1)&(t<=0)).*(1+t)+((t>0)&(t<=1)).*(1-t);
% 
