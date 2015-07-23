% Funzione Rettangolo

function x= my_rect(t)

% *******************************************************************
% Metodo 1 (lento): scorre tutto il vettore con l'indice 'k' 
% decide il valore del segnale in ogni punto. 
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
% Metodo 2: operazioni logiche su vettori

x = 1*(abs(t)<1/2) + 0.5*(abs(t)==1/2);
