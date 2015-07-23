% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 5c: MP3 READING

clear; clc; close all;

% M = mp3read('C:\Users\patrizio\Desktop\mp3_new\001.mp3');

% perchè non funziona? è ignoto, ma bisogna fare la chiamata manuale da
% console del programma mpg123.exe nella directory qui sopra.
% il comando è mpg123.exe -w 001.wav 001.mp3 .. restituisce su stdout
% (non ho idea di come implementare una pipe al matlab, e giudico troppo
% lungo ed estenuante per i miei scopi) le seguenti informazioni:
%  - Title:
%  - Artist:
%  - Album:  
%  - Comment:
%  - Year:  
%  - Genre:
%  - MPEG Version & Layer
%  !- Bitrate
%  !- Sample frequency
%  - Stereo/Mono/Join Stereo

% Fs sample frequency della traccia 001.

Tplay = 8;

path = 'C:\Users\patrizio\Desktop\mp3_new\001.wav';
[ W Fs ] = wavread(path);   

Wsx = W(:,1)';
Wdx = W(:,2)';


%% TEMPO E FREQUENZE

Ts = 1/Fs;     % periodo di campionamento
nc = length(Wsx); % numero di campioni
t = Ts : Ts : nc*Ts ; % asse temporale REALE
% length(t) dev essere uguale a nc!

Ttrack = t(length(t)) - t(1);

% Fast Fourier Transform
%Fsx = fft(Wsx);
%Fdx = fft(Wdx);

% ecco perchè sbagliavo: la DFT va da 0 a N-1
 %sbagliata:  f = -(nc*Fs)/2 + Fs : Fs : (nc*Fs)/2;
f = 0 : Fs : (nc*Fs)-Fs;

% figure('name','Left Channel');
%     subplot(1,2,1); plot(t,Wsx,'b');  xlabel('Time (s)'); title('Channel SX')
%     subplot(1,2,2); stem(f,Fsx,'g');  xlabel('Frequency (Hz)'); title('Specter')
% 
% figure('name','Right Channel');
%     subplot(1,2,1); plot(t,Wdx,'b');  xlabel('Time (s)'); title('Channel DX')
%     subplot(1,2,2); stem(f,Fdx,'g');  xlabel('Frequency (Hz)'); title('Specter')


%% SOMMA A RUMORE A MEDIA NULLA

AmpNoise = .1;  % fattore correttivo (potenza del rumore)  (non potenza secondo leonardi)
                % il rumore è al massimo il 10% dell'ampiezza massima!
noise = randn(1,nc)*AmpNoise;

Zsx = Wsx + noise;
Zdx = Wdx + noise;

Z(:,1) = Zsx;
Z(:,2) = Zdx;


%% TENTATIVO DI FILTRAGGIO   

%Y = LP_Double_Matrix(Z, 1.3, 0); % capire perchè restituisca solo zeri.
h = 2*[ .25 .5 .25 ];

Ysx = conv(h,Zsx);
Ydx = conv(h,Zdx);

Y(:,1) = Ysx;
Y(:,2) = Ydx;


%% RIPRODUZIONE AUDIO
    
%fprintf('Playing file for %d secs at default speed: Fs = %d Hz\n\n', Tplay, 8192);
    %sound(W);
    %pause(Tplay);       %sleep(10s)
    %clear playsnd;   %stops playing

fprintf('Playing file for %d secs at proper file speed: Fs = %d Hz\n\n', Tplay, Fs);
    sound(W,Fs);
    pause(Tplay);      
    clear playsnd; 
    
fprintf('Playing dirty file for %d secs at proper file speed: Fs = %d Hz\n\n', Tplay, Fs);
    sound(Z,Fs);
    pause(Tplay);      
    clear playsnd; 
    
fprintf('Playing cleaned file for %d secs at proper file speed: Fs = %d Hz\n\n', Tplay, Fs);
    sound(Y,Fs);
    pause(Tplay);      
    clear playsnd; 
    
    

return;