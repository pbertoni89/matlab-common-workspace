clear all

% Retroazione dello stato con osservatore...
% ATTENZIONE ALLE CONVENZIONI DI SEGNO! 
% Lezione:(A+BK), (A+LC)
% Esercitazione: (A-BC) (A-LC)
% Verificare cambi di segno nello schema simulink!

A=[3 -2;-7 3]
B=[1;3]
C=[1 1]

% Mancanza nel testo... ueq è un dato ed è fissato a 1.
ueq=1;
x0=[1 1];


xeq=-inv(A)*B*ueq
eig(A)

rank(obsv(A,C))
rank(ctrb(A,B))

autoval=[-0.2 -5]; % caso A: nodo stabile => autovalori reali negativi
		  %	    costante di tempo 5s => polo dominante in -1/5

%autoval=[-1-10*i -1+10*i] % caso B: fuoco stabile => autovalori c.c. con parte reale negativa...


K=place(A,B,autoval)
eig(A-B*K)


L=place(A',C',10*autoval)' % caso A: autovalori dell'osservatore posti una decade più a sinistra di quelli di (A-BK)
%L=place(A',C',[-10 -11])' % caso B: autovalori dell'osservatore posti una decade più a sinistra di quelli di (A-BK)... Meglio reali, attenzione 
			  % 	    al fatto che matlab non posiziona autovalori reali equivalenti!
eig(A-L*C)

es4_sim
