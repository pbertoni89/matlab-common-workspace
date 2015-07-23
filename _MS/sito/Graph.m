%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%GRAPH.M%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Menù principale
%
%_____________________________________________
%|  Written by                                |
%|                                            |
%|     Vitti Roberto      Soldo Fabio         |
%|____________________________________________|
%
%


clc;
M = MENU('DISEGNATORE DI FUNZIONI DI LYAPUNOV'...
   ,'Istruzioni per l''uso del programma'...
   ,'Inserimento funzione di Lyapunov'...
   ,'Visualizzazione funzione di Lyapunov'...
   ,'Fine programma');


if M == 1
   bdclose('all');              %Chiude tutte le finestre simulink
   helpdlg ('La guida è nel Command Window','TUTOR MESSAGE');
   guida;
   graph;
end

if M == 2
   bdclose('all');              %Chiude tutte le finestre simulink
   funzione;
   Ls1=strcat('Funzione di Lyapunov :',Ls);
   str=strvcat(Ls1);
   msgbox(str,'FUNZIONE DI LIAPUNOV INSERITA');  % Visualizza dati sistema
   pause(1);
   graph;
end

if M==3
   bdclose('all');              %Chiude tutte le finestre simulink
   grigliax=[-10:0.1:10];
   grigliay=grigliax;
   [x,y]=meshgrid(grigliax,grigliay);
   [z]=eval(Ls);
   if any(imag(z)~=0)
      errordlg ('Attenzione!!La funzione inserita non è corretta perchè assume dei valori immaginari','TUTOR MESSAGE');
   else
	   meshc(x,y,z);
	   title('Funzione di Lyapunov')
	   xlabel('x1'),ylabel('x2'),zlabel('V(x1,x2)')
      graph;
   end
end

if M == 4
   bdclose('all');              %Chiude tutte le finestre simulink
   uscita;
end


