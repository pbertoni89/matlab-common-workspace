% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 4c - Antitrasformata Zeta

clear; clc; close all;
t_start = cputime;

    fprintf('Benvenuto nel programma per l''antitrasformata Zeta.\n');
    fprintf(' Bug noti al momento:\n'); 
    fprintf(' 1) se un polo e uno zero si semplificano, una sequenza nel risultato esce nulla. \n');
    fprintf(' 2) la ricostruzione simbolica della risposta all''impulso funziona solamente con UN polo (singolo).\n');
    fprintf(' n) non sono note altre situazioni d''eccezione. Have fun! \n\n');
    fprintf('Premere un tasto per avviare. \n');
pause;

n = -10:10;  % bassissimo o grafici esplodono!
segnale = zeros(1,length(n)); % segnale x(n) FINALE
                
% basi di finestra IIR per segnali ricostruiti
caus = step(n);                                  % u(n)
anti = my_rotate( my_shift( step(n),n,1), n );   % u(-n-1)

    %num_plus = [1 .5]; % osservare che il padding zero avviene a DX se sono in z^-1, a SX in z
    %den = [1 -(1/8)*cos(pi/16) .81 ];  % devo aggiungeere uno zero a SX

    %num_plus = [ 3 0 ]; 
    %den = [1 -1/4 -1/8];

    %num_plus = [ 1 -1/3 ]; %non devo flippare , nemmeno num_plus = [ 1 0  4 ];
    %den = [ 1 +1/3 ];                                      % den = [ 1 -1/3 0 ];

    %num_plus = [ 1 0];  % PERFETTO
    %den = [ 1 -3];      % PERFETTO

    %num_plus = [ 1 0 0  ];  %testing di my_div funziona, ma aggiunge uno zero
    %den = [1 -3/2 1/2];     %di troppo all'inizio del quoziente in modo leftsided.


    %num_plus = [ 1 2 1 ];  %unuseful per il confronto, perchè benini esegue
    %den = [1 -3/2 1/2];    %UNA divisione giusto per riportarlo in forma propria e poi prosegue con i
                            %fratti (e l'esercizio viene lasciato da continuare). 

    % propria singoli
    %num_plus = [ -1 4];
    %den = [ 1 .7 -2];                    

    % POLI MULTIPLI 0   troppo semplice; inseriamo un polo distinto
    %num_plus = [ 1 0 ]; 
    %den = [ 1 -2 1 ]        

    % POLI MULTIPLI 1
    %num_plus = [ 1 -3 0 ];
    %den = [ 1 -4 4 ]

    % POLI MULTIPLI 1
    %num_plus = [ 1 -3 0 0 ];
    %num_plus = [ 1 1 0 ];
    %den = [ 1 -5 8 -4 ];
    a = 0.8;
    % TDE
    num_plus = [1 0];
    den =[1 -10/3 +1];

polynum = poly1d('coefficients', num_plus);
polyden = poly1d('coefficients', den);
degrnum = polynum.Degree;
degrden = polyden.Degree;

% fixing per il passaggio z+ (default ML)  ->  z-
gap = degrden - degrnum;
num_mins = num_plus;
for i = 1 : gap
    num_mins = [ 0 num_mins ];
end
 
Hplus =  tf(num_plus, den, 1, 'variable', 'z')
Hmins =  tf(num_mins, den, 1, 'variable', 'z^-1')

% 28 dicembre:: residues
residue(num_plus,den)


%% ZERI E POLI
[ Hzeros Hpoles Hgain ] = tf2zp( num_plus, den )   % POLI & ZERI IN Z+!  % Hzeros ha la H per distinguerlo dalla keyword zeros(a,b)

%Hupoles: metto in discussione unique(). spesso è inaffidabile
    precision = .01;

    HpolesRF = round( Hpoles*(1/precision) ) * (precision);  % ROUNDOFF FIXING

Hupoles = unique( HpolesRF )';

lupoles = length(Hupoles);
lpoles = length(Hpoles);

for i = 1 : lupoles
    
    HupolesN(i) = length( find( ismember( HpolesRF, Hupoles(i) )  ) );

end 

absupoles = abs(Hupoles);  % unused e questo è un errore

figure('name','Zero & Poles');
zplane(Hzeros, Hpoles); title('Zeros & Poles');

        % rzt= -2:.1:2;
        % izt= rzt;
        % 
        % [rz,iz]= meshgrid(rzt,izt); % abbiam creato il piano di appoggio
        % 
        % %z = abs ( x.^2+y.^2+1./x;
        % z = rz + 1i * iz;
        % Z = abs ( (z  +1) / (z^-2+z-4) );  % rapporto d'esempio: come implementare X(z) vero?
        % 
        % colormap(jet);
        % surf(rz,iz,abs(z));
        % 
        % hold on;
        % shading interp;


%% CASISTICA 1:  PROPRIA&SINGOLI ; 

if length(Hpoles) == lupoles && degrnum < degrden
    
                [ seq, segnale ] = simple_fracts(num_mins,den,n)
        
                figure('name', 'Segnale antitrasformato');
                for i = 1 : lupoles
                    subplot(1,lupoles+1,i); stem( n, seq(i,:),  'b', 'filled'); title(['polo  ',num2str(Hupoles(i))] );
                end 
                    subplot(1,lupoles+1,lupoles+1); stem( n, segnale,  'r', 'filled');  title('$$x(n)$$','Interpreter','latex','FontSize',18);

                    
%% CASISTICA 2:  IMPROPRIA&SINGOLI ; 
 

elseif lpoles == lupoles && degrnum >= degrden
      
               %TODO:  Applicare divisione polinomiale.. 
               % (if) la sequenza che vogliamo è causale <=> la roc è l'ultima dell'array
               %    => dobbiamo dividere in Z- 
               % (elseif) la sequenza che vogliamo è anticausale <=> la roc è la prima dell'array
               %    => dobbiamo dividere in Z+
               % (else) sono in un caso intermedio.... e non ho idea di come si faccia.

               % POI: una volta applicata deconv(b,a) e compreso i gradi che vengon
               % buttati fuori, devo costruire il segnale a partire da Q
               % E applicare residue(resto,den) sempre attenzione ai gradi!


               K = degrnum-degrden+1;
               
               rocs = 0:lupoles;  % #rocs = #Hupoles + 1
               lrocs = length(rocs);

               % presento possibili ROC
               fprintf('Trasformata impropria, a poli singoli. Eseguirò %d divisioni polinomiali.\n', K);
               fprintf('Ho isolato %d Regioni di Convergenza.\n\n', lrocs);
               fprintf(' 1)  |z| < %.2f \n ', Hupoles(1)); % regione più interna
               for i = 2:lupoles
                 fprintf('%d) %.2f < |z| < %.2f \n ', i, Hupoles(i-1), Hupoles(i));  % corone circolari
               end
               fprintf('%d) |z| > %.2f \n ', lrocs , Hupoles(lupoles) ); % regione più esterna

               % richiesta input ROC
               fprintf('Scegliere una regione dove trasformare. [1... %d]\n\n ', lrocs);
               roc = input('');
               while( roc<1 || roc>lrocs )
                fprintf('Valore non ammesso!\n'); 
                roc = input('');
               end
              
               % leftsided => potenze DEcrescenti.
               if roc==1   
                    [ q r ] = long_div( fliplr(num_plus), fliplr(den), length( n(1) : n(n==-1) ) );
                    %[ q3 r3 ] = deconv( num_mins, fliplr(den) ); 
                    segnale = [ fliplr(q) zeros(1,length( n(n==0) : n(length(n)) )) ]; %segnale = anti(n<0) .* q;
               
               % rightsided => potenze CREscenti.
               elseif roc==lrocs 
                    [ q r ] = long_div( num_mins, den, length( n(n==0) : n(length(n)) ) );
                    %[ q3 r3  ] = deconv( num_mins, den ); 
                    segnale = [ zeros(1, length(n(1):n(n==-1)) ) q ]; %segnale = caus(n>=0) .* q;
                    
               else
                    fprintf('In fase di progettazione.\n\n');
               end

               figure('name', 'Segnale antitrasformato');
                    stem( n, segnale,  'r', 'filled');  title('$$x(n)$$','Interpreter','latex','FontSize',18);
 
                    
   %% CASISTICA 3:  PROPRIA&MULTIPLI ; 
            
   
elseif lpoles > lupoles && degrnum < degrden  
   
            fprintf('Trasformata propria e a poli multipli.\n\n');

            [fracts testpoles]= residue(num_mins,den); % where:
                                                   %       r0 residues
                                                   %       p0 poles
                                                   %       k0 direct term(?)
                                                   

            % è inutile fixare dal roundoff p0... ho già fatto questo lavoro! 
            % mi appoggio ai vettori Hupoles e HupolesN
            
            fracts = round( fracts*(1/precision) ) * (precision);  % ROUNDOFF FIXING
            testpoles = round( testpoles*(1/precision) ) * (precision);  % ROUNDOFF FIXING
            
            % richiamo tutto il discorso sulla ROC. casistica 1
            % considerare l'idea di implementare una funzione apposta!
            
           %% L IDEA ORA E' SCOMPORRE H(Z) GESTENDO A PARTE I POLI SINGOLI
           %% DA QUELLI MULTIPLI.
           % I SINGOLI ANDREBBERO INVIATI A SINGLE_FRACTS(), MA QUESTO
           % VUOLE I PARAMETRI POLINOMIALI => IMPLEMENTARE DUE FUNZIONI
           % DIVERSE, UNA COI POLINOMI L'ALTRA CON I POLI E RESIDUI GIA' PRONTI! 
           % CONSIDERAZIONE: SIMPLE_FRACTS() VA PROPRIO SCOMPOSTA IN DUE;
           
            % UNA PARTE CHE GESTISCE L'EVENTUALE ESTRAZIONE DI POLI&RESIDUI,
           
            % L'ALTRA, CHE PUO' ESSERE FUNZIONE ANTI(), CHE PROMPTI LA ROC
            % E COSTRUISCA LE SEQUENZE DI USCITA.
           

   
%% CASISTICA 4:  IMPROPRIA&MULTIPLI ;    
else  
    fprintf('Trasformata impropria con N>=M e a poli multipli. Aiuto!!!!\n\n');
end




% fine casistiche antitrasformata
%% Stima per la ricostruzione (FEATURE SPERIMENTALE); utilizzo classe simbolica del Matlab

if lupoles==1
        clear n;
        if roc==1           % anticausale
            stima = q(3)/q(4)
        elseif roc==lrocs   % causale
            stima = q(4)/q(3)
        end
        syms n;
        x = stima^n 
        ztrans(x)
else
%         clear n;
%         stima = zeros(1,lupoles);
% 
%         if(roc==1)   
%             for i = 1 : lupoles
%                 stima(i) = seq(i,3)/seq(i,4)
%             end
%         elseif(roc==lrocs) 
%             for i = 1 : lupoles
%                 stima(i) = seq(i,4)/seq(i,3)
%             end
%         else   % corona intermedia
%             for i = 1 : lupoles
%                 if Hupoles(i) <= Hupoles(roc-1)
%                     stima(i) = seq(i,4)/seq(i,3)
%                 else
%                    stima(i) = seq(i,3)/seq(i,4)
%                 end
%             end
%         end
% 
%         syms n; 
%         x = [];
%         parte = [];
% 
%         for i = 1 : lupoles
%             parte(i) = fratti(i) * stima(i)^n 
%             x = x + parte(i)
%         end
%         ztrans(x)
end

% end program
fprintf ( 1, 'Exit with success. Elapsed CPU time: %f\n', cputime - t_start );

return;