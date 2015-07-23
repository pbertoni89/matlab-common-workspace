
clear all; close all; clc;

dt = .01; 
df = dt;
t= -10:dt:10;
f = -15:df:15;

%% SEGNALE INFORMATIVO DA TRASMETTERE
informazione = mysinc(t).^2;
FTinformazione = fourierTrasf(informazione,t,f);
figure(1);
subplot(1,2,1); plot(t,informazione); title('$$informazione(t)$$','Interpreter','latex'), axis([-5 5 -.1 1.1]);
subplot(1,2,2); plot(f,abs(FTinformazione)); title('$$\vert FTinformazione(f)\vert$$','Interpreter','latex'), axis([-5 5 -.1 1.1]);
% banda di FTinformazione: banda = 1 % è esattamente l'estremo destro del
% tri(f)

%% COSENO MOLTIPLICATORE
phase = pi/3;
freq = 7.5;
moltiplicatore = cos(2*pi*freq*t + phase);
FTmoltiplicatore = T_Fourier(moltiplicatore,t,f);
figure(2);
subplot(1,2,1); plot(t,moltiplicatore); title('$$moltiplicatore(t)$$','Interpreter','latex')
subplot(1,2,2); plot(f,abs(FTmoltiplicatore)); title('$$FTmoltiplicatore$$','Interpreter','latex')

%% NODO MOLTIPLICATORE
prodotto = informazione.*moltiplicatore;
TFprodotto = T_Fourier(prodotto,t,f);
figure(3);
subplot(1,2,1); plot(t,prodotto); title('$$prodotto(t)$$','Interpreter','latex'),  axis([-5 5 -1 1]);
subplot(1,2,2); plot(f,abs(TFprodotto)); title('$$TFprodotto$$','Interpreter','latex')
% set(gca,'XTick',-15:15);
% banda di TFprodotto (segnale AM-Double Sideband Carrier: AM-DSB): B_AM = 2

% filtro passa-banda di banda B_AM/2 centrato in fp+banda/2
% (tengo solo metà triangolo)
% => lo costruisco modulando un passa-basso (ovvero convolvendo con due
% dirac in frequenza

%% FILTRO PASSA BANDA
h_bandpass = mysinc(t).*cos(2*pi*(freq+1/2)*t);
H_bandpass = T_Fourier(h_bandpass,t,f);
figure(4);
subplot(1,2,1); plot(t,h_bandpass); title('$$h\ filtro(t)$$','Interpreter','latex'),  axis([-5 5 -1 1]);
subplot(1,2,2); plot(f,abs(H_bandpass)); title('$$H\ filtro$$','Interpreter','latex')
%set(gca,'XTick',-15:15);

%% FILTRAGGIO SSB
% padding per prodotto fino a t=-30:30
t1 = -30:dt:30;
am_pad = [zeros(1,(30-10)/dt) prodotto zeros(1,(30-10)/dt)];  % array [ 2000zeri | segnale_prodotto | 2000zeri ]
am_SSB = myshift(filter(h_bandpass,1,am_pad)*dt,-10/dt);
AM_SSB = T_Fourier(am_SSB,t1,f);
figure(5);
subplot(1,2,1); plot(t1,am_SSB); title('$$am$$','Interpreter','latex')
subplot(1,2,2); plot(f,AM_SSB); title('$$AM$$','Interpreter','latex')
%set(gca,'XTick',-15:15);

%% NODO MOLTIPLICATORE: DEMODULAZIONE SINCRONA
% elimino il padding 
am_dem = am_SSB (t1>=-10 & t1<=10) .* moltiplicatore; % prelevo solo la parte [-10,10]
AM_dem = T_Fourier(am_dem,t,f);
figure(6);
subplot(1,2,1); plot(t,am_dem); title('$$am_{dem}(t)$$','Interpreter','latex')
subplot(1,2,2); plot(f,AM_dem); title('$$\vert AM_{dem}(f)\vert$$','Interpreter','latex')
%set(gca,'XTick',-15:15);
    
    
    
    
    
    
return;