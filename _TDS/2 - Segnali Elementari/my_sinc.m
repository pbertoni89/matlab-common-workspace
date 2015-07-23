function x = mysinc(t)
%MYSINC funzione Sinc modificata
%   SINC(t) implementa la funzione sinc
%
%                    sen(pi*t)
%      sinc(t)    = -----------
%                      pi*t
%
%   Opera su vettori.


% *******************************************************************
% ** COMMENTARE I DIVERSI BLOCCHI PER USARE I DIVERSI METODI       **
% **                                                               **
% ** in tutto il file abs() ? la funzione modulo (valore assoluto) **
% *******************************************************************


% *******************************************************************
% Metodo 1 (lento): scorre tutto il vettore e decide il valore del 
% segnale in ogni punto. I punti qui sono specificati usando 
% l'indice k (ovvero i punti sono i t(k))
% 
% length(t) indica il numero di punti dell'asse; ~ indica negazione
% *******************************************************************
% 
% for k = 1:length(t)  
%     if t(k)~=0
%         x(k) = sen(pi*t(k))/(pi*t(k));
%     else
%         x(k) = 1;
%     end
% end
%


% *******************************************************************
% Metodo 2: usa le operazioni logiche su vettori
% Il vettore x è inizializzato con valori tutti uguali a 1.
% In questo caso selezioniamo le posizioni in cui l'asse t è diverso
% da zero e mettiamo gli indici relativi nella variabile not_zero_pos 
% (posizioni in cui il vettore t è diverso da zero).
% Il calcolo viene poi eseguito solo su queste posizioni
% *******************************************************************

x=ones(size(t));
not_zero_pos=find(t~=0);
x(not_zero_pos)=sin(pi*t(not_zero_pos))./(pi*t(not_zero_pos));

% *******************************************************************
% Metodo 3: usa le operazioni su vettori, trattando il caso
% particolare (NaN) per t=0 con il comando logico isnan() che 
% individua i punti in cui ci sono i NaN (Not a Number)
% *******************************************************************
%
% x = sin(pi*t)./(pi*t);
% x(isnan(x)) = 1;
