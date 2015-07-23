% Patrizio Giuliano Bertoni 79021 INFLT3
%

clear all
close all
clc

df = .001;
f = -1/2:df:1/2;
% f = -3/2:df:3/2; evidenzia la periodicità DTFT

%%
tri7 = triN(7);

x = [ ones(1,4) 0 0 0 tri7 ];
n_x = 0:length(x)-1;

X = dtft(x,n_x,f);

figure('name','sequenza in ingresso');
    subplot(3,1,1); stem( 0:length(x)-1, x, 'g'); axis([0 18 -.1 2]); title('x(n)');
    subplot(3,1,2);  plot(f,abs(X),'r'); title('|X(f)|');
    subplot(3,1,3); plot(f,angle(X),'b'); title('\angle X(f)');

%%
h = (1/sqrt(3)) * [ 1 1 1 ];
n_h = 0:length(h)-1;

H = dtft(h,n_h,f);

figure('name','risposta all''impulso');
    subplot(3,1,1); stem( 0:length(h)-1, h, 'g'); axis([0 18 -.1 2]); title('h(n)');
    subplot(3,1,2); plot(f,abs(H),'r'); title('|H(f)|');
    subplot(3,1,3); plot(f,angle(H),'b'); title('\angle H(f)');

%%
y = conv(x,h);
Lconv = length(x)+length(h)-1;

y = y( 1 : Lconv );
n_y = 0 : Lconv - 1;

figure('name','sequenza in uscita con convoluzione lineare');
    stem( n_y, y, 'b'); axis([0 18 -.1 2]); title('y_{diretta} = x(n) \ast h(n)');

%%
Xfft = fft(x, 2*length(x)-1 );  % devo passargli già la durata della convoluzione:  L + N - 1
Hfft = fft(h, 2*length(x)-1 );

Yfft = Xfft .* Hfft;

y_indiretta = ifft( Yfft );
y_indiretta = y_indiretta( 1 : Lconv );

y_errore = y - y_indiretta;

figure('name','sequenza in uscita con prodotto in frequenza');
    stem( 0:length(y_indiretta)-1, y_indiretta, 'b'); axis([0 18 -.1 2]); title('y_{indiretta} = X(f) . H(f)');   
figure('name','Stampa errore');
    stem( 0:length(y_errore)-1,    y_errore,    'r');  title('Stampa Errore:  y_{diretta} - y_{indiretta}'); 
    
 %%  
Y = dtft(y,n_y,f);
Ydft128 = my_dft(y,128);
Ydft128 = swap_dft(Ydft128);

figure('name','confronto DFT(y,128) con DTFT(y,df=0.01)');

    subplot(2,2,1); plot(f,abs(Y),'r'); title('|Y(f)|');                                        
    subplot(2,2,2); plot(f,angle(Y),'b'); title('\angle Y(f)');                                  
    subplot(2,2,3); stem( 0:length(Ydft128)-1, abs(Ydft128),'r');   title('|Ydft128(k)|');       axis([ 0 length(Ydft128)-1  0 18 ])
    subplot(2,2,4); stem( 0:length(Ydft128)-1, angle(Ydft128),'b'); title('\angle Ydft128(k)');  axis([ 0 length(Ydft128)-1  -4 4 ])
    
    
    
return;