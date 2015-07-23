
clear all; close all; clc;

t=-10:0.01:10;
T=4;
Td=5; % periodo dente di sega

expStabile = zeros(1, length(t));
expInstabile = expStabile;
ondaTri = expStabile;

baseTri = 2; % il fattore per cui moltiplico la base: da 2->4
offsetZero = 1;

for n = floor(min(t)/T):ceil(max(t)/T)

   expStabile = expStabile + exp(-t +n*T).* my_rect( (t- (1/2)*T - n*T) /T );
   expInstabile = expInstabile + exp(+t -n*T).* my_rect( (t- (1/2)*T - n*T) /T );
   %ondaTri = ondaTri + tri(+t -n*T).* my_rect( (t  - n*T) /T ); % devo sfasare il rect! tolgo il -1/2
   
   % creare un onda triangolare con tri di base 4  ioè [-2,2] con return
   % zero di 1 cioè il prossimo parte da [3,7]
   % ondaTri = ondaTri + tri( t -n*(baseTri)-offsetZero ).* my_rect( (t -n*(baseTri*2)) / (baseTri*2) ); % devo sfasare il rect! tolgo il -1/2
   
   baseSegn= 1; offsetZero= baseSegn * (baseSegn / 1 ) +3;  % T2 = T1 * (rapporto base segnale / base rect )
   ondaTri =  ondaTri + tri((t-n*offsetZero)/baseSegn).* my_rect( (t-n*offsetZero)/offsetZero);
   %cosRettif = cosRettif + abs( cos( +t*((2*pi)/T) -n*((2*pi)/T) )).* my_rect( (t- (1/2)*((2*pi)/T) -n*((2*pi)/T) ) * ((2*pi)/T) );
end
    

  %% !!!! DENTE DI SEGA
denteSega=t;

n= ceil( ( t(length(t))-t(1) ) / T);

for k=floor(-n/2):floor(n/2)

   denteSega= denteSega + (t- (k*Td)*2).* my_rect((t -k*Td)/Td); 
end 


    figure(1)
subplot(2,2,1); plot(t,expStabile,'r'); %axis([-4 4 -10 10]);
subplot(2,2,2); plot(t,expInstabile,'r'); %axis([-4 4 -3 3]);
subplot(2,2,3); plot(t,denteSega,'r'); %axis([-8 8 -5 5]);
subplot(2,2,4); plot(t,ondaTri,'r'); grid on; %axis([-8 8 -5 5]); 
