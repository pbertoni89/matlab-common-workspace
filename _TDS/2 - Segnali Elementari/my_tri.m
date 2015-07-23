% Funzione Triangolo

function x= my_tri(t)


% *******************************************************************
% Metodo 1 (lento): scorre tutto il vettore con l'indice 'k', 
% e decide il valore del segnale in ogni punto.
%
% for k = 1:length(t)
%     if (t(k)>-1) && (t(k)<1)
%       x(k) = 1-abs(t(k));
%     else 
%       x(k) = 0;
%     end
% end

% *******************************************************************
% Metodo 2 (lento): simile al metodo 1, ma esploso
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


% x = (abs(t)<=1) .* (1-abs(t));    
% .* array multiply

x = ( (t>-1) & (t<=0) ) .* (1+t) + ( (t>0) & (t<=1) ) .* (1-t);




