function [xex,yex,zex]=campoex(t,q,m,E,B,v0)
%
% costruzione della traiettoria esatta di una particella di massa m e carica q
% soggetto ad un campo elettrico uniforme e costante E, ad un campo magnetico
% uniforme e costante B e di velocita' iniziale v0
%
% Input:  t= vettore (riga o colonna)  contenente i tempi in cui si vuole
%            valutare la posizione della particella
%         q= carica della particella
%         m= massa della particella
%         E = vettore di 3 componenti: campo elettrico
%         B = vettore di 3 componenti: campo magnetico
%         v0 = vettore di 3 componenti: velocita' iniziale
%
% Output: xex=vettore contenente x(t) (stessa dimensione del vettore t)
%         yex=vettore contenente y(t) (stessa dimensione del vettore t)
%         zex=vettore contenente z(t) (stessa dimensione del vettore t)
%

qm=q/m; mq=m/q;
xex=-(mq*v0(2)/B(3)+mq/B(3)^2*E(1))*(cos(qm*B(3)*t)-1)+...
mq*v0(1)/B(3)*sin(qm*B(3)*t);
yex=-mq/B(3)*v0(1)*(1-cos(qm*B(3)*t))-E(1)/B(3)*t+(mq/B(3)*v0(2)+...
mq/B(3)^2*E(1))*sin(qm*B(3)*t);
zex=qm*0.5*E(3)*t.^2+v0(3)*t;
end