function x = rect(t)
%RECT funzione Rettangolo
%   RECT(t) implementa la funzione rettangolo
%
%              = 1    se |t|<1/2
%      rect(t) = 1/2  se |t|=1/2
%              = 0    se |t|>1/2 
%
%   Opera su vettori.


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
%     if abs(t(k))<1/2
%         x(k) = 1;
%     elseif abs(t(k))==1/2
%         x(k) = 0.5;
%     else
%         x(k) = 0;
%     end
% end
%


% *******************************************************************
% Metodo 2: usa le operazioni logiche su vettori
% In questo caso non viene usato nessun indice sull'asse, ma
% l'operazione è eseguita su tutti i punti t(k) in modo automatico.
% 
% L'espressione (abs(t)<=1) "seleziona" i punti compresi tra -1 e 1 
% (comando usato per il rettangolo).
% In questi punti la funzione è (1-abs(t)).
% 
% N.B. - dettaglio tecnico matlab - 
% Le espressioni (abs(t)<=1) e (abs(t)==1/2), usate in questo
% esempio, assume valori boolean, ovvero solo 1 o 0. 1 indica vero,
% e 0 indica falso. Questi valori si possono usare per creare segnali
% ma bisogna prestare attenzione ai tipi di dati. I vettori che
% rappresentano i segnali devono essere tutti di tipo double
% (eventualmente "complex"). Per convertire i boolean in double è
% sufficiente mettere un cast, ad esempio in questo caso scrivere
% double(abs(t)<=1). Nell'esempio questo non è fatto perchè, moltiplicando per i numeri
% reali 1 e 0.5, Matlab effettua il cast automaticamente e usa il
% tipo double per la variabile x.
% *******************************************************************

x = 1*(abs(t)<1/2)+0.5*(abs(t)==1/2);
