% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 5a - Variabili Casuali


clear all; close all; clc;

T = 10000;  % quanti eventi posso pescare
radT = sqrt(T);

%
U0 = rand( 1, T );

    medU0 = mean(U0);
    varU0 = var(U0);

% normalizzato dividendo i valori
[ hstU0 binsU0 ] = hist(U0, radT);
    figure(1); 
bar( binsU0, hstU0 / radT );
    
    medU1_param = -10;
    varU1_param = 20;

U1 = handleU( U0, medU1_param, varU1_param);

    medU1 = mean(U1);
    varU1 = var(U1);

[ hstU1 binsU1 ] = hist(U1, radT);
    figure(2); 
bar( binsU1, hstU1 / radT );


%% 

 N0 = randn( 1, T );

    medN0 = mean(N0);
    varN0 = var(N0);

% normalizzato dividendo i valori
[ hstN0 binsN0 ] = hist(N0, radT);
    figure(3); 
bar( binsN0, hstN0 / radT );
    
    medN1_param = -1;
    varN1_param = 2;

N1 = handleN( N0, medN1_param, varN1_param);

    medN1 = mean(N1);
    varN1 = var(N1);

[ hstN1 binsN1 ] = hist(N1, radT);
    figure(4); 
bar( binsN1, hstN1 / radT );


%%
 %  Partendo da U, generare una VC con pdf triangolare (parametrica)
 
A = 2;

Z = zeros(1,T);

de_z = .001;
z = -10 : de_z :10;

pdf_Z = (1/A)*tri(z/A);

Z = trasfVC( z, U0, pdf_Z);

[ hstZ binsZ ] = hist(Z, radT);
    figure(5); 
bar( binsZ, hstZ / radT );



return;