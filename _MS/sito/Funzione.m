%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FUNZIONE.M%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Inserimento funzione di Lyapunov
%
%_____________________________________________
%|  Written by                                |
%|                                            |
%|    Vitti Roberto      Soldo Fabio          |
%|____________________________________________|
%
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%Visualizzazione dati sistema%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt={'Inserire la funzione desiderata o usare quella di default.               Operatori utilizzabili: + - * / .^ ( ) .                                      N.B.1 Utilizzare le variabili x e y per l''inserimento della funzione                      N.B.2 I valori della funzione non possono risultare complessi                      N.B.3 La funzione deve soddisfare i seguenti requisiti:                      @V(x) deve essere continua                                                      @Il minimo di V(x) deve coincidere con il p.to di equilibrio                      @V''(x)=grad[V(x)]*f(x)<=0'};
def={Ls};
dlgTitle='INSERIMENTO FUNZIONE DI LYAPUNOV';
lineNo=1;
answer=inputdlg(prompt,dlgTitle,lineNo,def);
Ls=cat(1,answer{1,:});

