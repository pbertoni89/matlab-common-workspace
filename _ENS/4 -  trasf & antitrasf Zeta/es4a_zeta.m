% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 4a: trasformata Zeta

clear; clc; close all;
t_start = cputime;

num1 = [1 1]; % osservare che il padding zero avviene a DX se sono in z^-1, a SX in z
den1 = [2 1 3]; % in z il grado è dato da length-1..   in z- è sempre 0 ?

%% INPUT NUM & DEN

    H1 = tf(num1, den1, .01, 'variable', 'z^-1')

    [ H1zeros H1poles H1gain ] = tf2zp( num1, den1 )

    %[ A B C D ] = zp2ss( Hzeros, Hpoles, Hgain )  BUONA PER MARCO CAMPI

    H1upoles = unique(H1poles);  % fa anche sorting!
    rocs1 = zeros(1,length(H1upoles));

    figure(1);
    zplane( H1zeros, H1poles );
    %bode(H1);


fprintf('\n-----------------------------------------------------------------------------------------------\n');
%% INPUT ZEROS & POLES

            zeros2 = [ 0   ; 1/12];
            poles2 = [ 1/2 ; -1/3];
            gain2  = 2;

            [num2 den2] = zp2tf(zeros2, poles2, gain2)

            H2 = tf(num2, den2, .01, 'variable', 'z^-1')
            [ H2zeros H2poles H2gain ] = tf2zp( num2, den2 );

            H2upoles = unique(H2poles);  % fa anche sorting!
            rocs2 = zeros(1,length(H2upoles));

            figure(2);
            zplane( H2zeros, H2poles );



fprintf ( 1, 'Elapsed CPU time = %f\n', cputime - t_start );
    return;