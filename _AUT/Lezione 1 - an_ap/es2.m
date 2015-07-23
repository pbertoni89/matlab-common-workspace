
%##funzione di trasferimento ##
g=tf(20,[5,106,121,20]);

%%
%punto 1

%mi aspetto 3 poli
disp(pole(g));
step(g);

%## stabilità ##
%i poli del sistema sono tutti e 3 tre negativi non
% nulli; posso dunque solo dedurre che la parte visibile
% del sistema è stabile mentre non posso dire nulla su
% quella nascosta. quindi non posso dedurre nulla
% sulla stabililtà generale del sistema.

%%
% punto 2
lez1es2