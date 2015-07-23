function x = gradino(t)
%GRADINO funzione Gradino
%   GRADINO(t) implementa la funzione gradino
%
%              = 1    se t>0
%      E(t)    = 1/2  se t=0
%              = 0    se t<0
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
%     if t(k)>0
%         x(k) = 1;
%     elseif t(k)==0
%         x(k) = 0.5;
%     else
%         x(k) = 0;
%     end
% end



% *******************************************************************
% Metodo 2: usa le operazioni logiche su vettori
% In questo caso non viene usato nessun indice sull'asse, ma
% l'operazione è eseguita su tutti i punti t(k) in modo automatico.
% *******************************************************************

x = 0.5*(t==0)+(t>0);
