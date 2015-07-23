 
%%  STATISTICA DI ORDINE N
% 
%     VETTORE VC di N VC, identificate dall estrazione di un ISTANTE di tempo.
% 
%% PRIMO - SECOND ORDINE 
% 
% si riferisce al numero di ISTANTI di tempo utilizzati nella definizione.
%     
%%  SECOND ORDINE => PRIM ORDINE
%   in ogni caso!!!
% 
%% MEDIA DEL PROCESSO
% 
%     integrale di a per la pdf, sulla casistica.
% 
%% AUTOCORR TRA DUE ISTANTI
% 
%     integrale doppio (sulla casistica) di a1*a2* la pdf congiunta TRA I DUE ISTANTI.
%        Rx (t1,t2) = E[ X(t1) X(t2) ]
% 
%% Stazionarietà : implica indipendenza dal TEMPO
% 
%     senso STRETTO => LATO
%     
%         PRIM: pdf non dipende dal tempo
%     
%     senso LATO
%     
%         MEDIA = PRIM :       non dipende dal tempo
%          
%         AUTOCOR = SEC :   dipende solo dalla delta tempo
%            Rx (t1,tau) = E[ X(t1) X(t) ]
%               ella pratica la autocorr trasla
% 
% 
%% Ergodicità : implica indipendenza dalle REALIZZAZIONI.   
%   ERGODICO => STAZIONARIO!!! ( sia per media OR che per autocorr)
% 
%     senso STRETTO
%     
%         PRIM:    pdf non dipende dal tempo nè dalla real
%     
%     senso LATO
%     
%         MEDIA = PRIM :    media non dipende dal tempo nè dalla real
%          
%         AUTOCOR = SEC :   dipende solo dalla delta tempo
%                               Rx(tau) = phi_x(tau)   phi autocorr di una
%                               realizzazione qualsiasi.
%
%           Rx(0) = E[ X^2(t) ]  = POTENZA PROCESSO
%
%
%% PROCESSI TIPICI

    %% PROCESSO PAM
% 
%         ergodico per definizione => stazionario => Wiener Kinkin
% 
    %% SINUSOIDE A FASE RAND
% 
%         stazionaria 
%                 NO senso stretto.
%                 senso lato SECOND ordine (secondo autocorrelazione)
% 
%         ergodica
%                 risp media e risp autocorr. la phi di sin(2pi.f.t+?)  è .5*cos(2pi.tau)
% 
    %% ONDA TRI A FASE RAND
% 
%         verificare che la fase casuale SPAZI SOLO NEL PERIODO!
% 
%         stazionaria
%                 senso lato PRIM ordine (secondo media). anche SECONDO.
% 
%         ergodica
%                 risp media e risp autocorr.
% 
    %% PROCESSO GAUSSIANO
% 
%         E[X(t)] = 0 
%         PHI(f) = sinc^2(6f)
%         stazionario media
%         stazionario autocorr => WIENER KINKIN:  PHI(f)= fourier( Rx(t) )
%         verificare che pdf(a) non dipenda dal tempo. o cade l'ipotesi di staz
%         ..milioni di calcoli..


%% FILTRAGGIO DI PROCESSI
% 
%      problema: definire la CROSS-CORRELAZIONE tra INGRESSO E USCITA
%      di un PROCESSO tramite un sistema LTI
% 
%      ergodicità aiuta molto => studio una sola realizzazione (magari
%      anche comoda, esempio a fase zero)
%  
%      R_x(tau) = phi_x(tau)   <->  PHI_x(f)   (Wiener Kinkin)
%    
%      PHI_x(f) = |X(f)|^2  ma solo per segnali di ENERGIA!
%    
%      PHI_xy(f) = PHI_x(f) . H(f)   <->   R_xy(tau)  =  phi_xy(tau)
% 
%      PHI_y(f) = PHI_x(f) . |H(f)| ^2    <->  R_y(tau)
% 
   
    