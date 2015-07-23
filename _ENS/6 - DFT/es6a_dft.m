% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 6a: DFT

clear; clc; close all;

n_sht = 0:3;
N_sht = length(n_sht);

n_ext = 0:29;
N_ext = length(n_ext);
 
 
 %% iii
 % Provare ad applicare la DFT ad un numero intero di periodi di un segnale sinusoidale di
 % frequenza discreta 1/4 . Cosa accade alla DFT all'aumentare del numero di periodi?
 
    f0 = .25;
    T0 = 1/f0;
    
    s0 = sin( 2 * pi * f0 * n_ext);
    
    S1 = dft_N( s0(1: 1*T0 ), 1*T0 );
    S2 = dft_N( s0(1: 2*T0 ), 2*T0 );
    S3 = dft_N( s0(1: 3*T0 ), 3*T0 );
    S4 = dft_N( s0(1: 4*T0 ), 4*T0 );

   figure('name','Seno');
     stem(n_ext,s0,'b');   title('$$\sin(2 \pi \frac{1}{4} n)$$','Interpreter','latex','FontSize',16);        axis( [ 0 29 -2 2])
   
   figure('name','DFT di diverse quantità intere di periodi' );
   
     subplot(4,2,1); stem( n_ext(1:1*T0), abs(S1),'r', 'filled');  title('$$| dft(\sin,4) |$$','Interpreter','latex','FontSize',16);
     subplot(4,2,2); stem( n_ext(1:1*T0), angle(S1),'b');          title('$$\angle dft(\sin,4)$$','Interpreter','latex','FontSize',16);
        
     subplot(4,2,3); stem( n_ext(1:2*T0), abs(S2),'r', 'filled');  title('$$| dft(\sin,8) |$$','Interpreter','latex','FontSize',16);
     subplot(4,2,4); stem( n_ext(1:2*T0), angle(S2),'b');          title('$$\angle dft(\sin,8)$$','Interpreter','latex','FontSize',16);
     
     subplot(4,2,5); stem( n_ext(1:3*T0), abs(S3),'r', 'filled');  title('$$| dft(\sin,12) |$$','Interpreter','latex','FontSize',16);
     subplot(4,2,6); stem( n_ext(1:3*T0), angle(S3),'b');          title('$$\angle dft(\sin,12)$$','Interpreter','latex','FontSize',16);
        
     subplot(4,2,7); stem( n_ext(1:4*T0), abs(S4),'r', 'filled');  title('$$| dft(\sin,16) |$$','Interpreter','latex','FontSize',16);
     subplot(4,2,8); stem( n_ext(1:4*T0), angle(S4),'b');          title('$$\angle dft(\sin,16)$$','Interpreter','latex','FontSize',16);
        
        
%%  iv
% Provare ad applicare la DFT un segnale rettangolare. Cosa accade mantenendo ssa la
% lunghezza del rect ed allungando il segnale con un padding di zeri?

N = 4;

    % n short
    x1_sht = rectN(n_sht,N);
    X1_sht = dft_N(x1_sht,N_sht);
    
    figure('name','Rettangolo Corto');

     subplot(3,1,1); stem(n_sht,x1_sht,'b', 'filled');   
        title('$$x_{sht} = rect_4(n_{sht})$$','Interpreter','latex','FontSize',20);     axis( [ 0 29 -1 2])
     subplot(3,1,2); stem(n_sht,abs(X1_sht),'r');      
        title('$$|X_{sht}| = dft(x_{sht})$$','Interpreter','latex','FontSize',20);       axis( [ 0 29 -1 4])
     subplot(3,1,3); stem(n_sht,angle(X1_sht),'g');      
        title('$$\angle X_{sht} = dft(x_{sht})$$','Interpreter','latex','FontSize',20);  axis( [ 0 29 -4 4])
 
     
    % n extended
    x1_ext = rectN(n_ext,N);
    X1_ext = dft_N(x1_ext,N_ext)';

    figure('name','Rettangolo Esteso');  
    
     subplot(3,1,1); stem(n_ext,x1_ext,'b', 'filled');   
        title('$$x_{ext} = rect_4(n_{ext})$$','Interpreter','latex','FontSize',20);     axis( [ 0 29 -1 2])
     subplot(3,1,2); stem(n_ext,abs(X1_ext),'r');      
        title('$$|X_{ext}| = dft(x_{ext})$$','Interpreter','latex','FontSize',20);       axis( [ 0 29 -1 4])
     subplot(3,1,3); stem(n_ext,angle(X1_ext),'g');      
        title('$$\angle X_{ext} = dft(x_{ext})$$','Interpreter','latex','FontSize',20);  axis( [ 0 29 -4 4])


%% v
% Provare ad applicare la DFT alla somma di due sinusoidi osservando e commentando i risultati
% relativi alla scelta di N in rapporto al periodo delle sinusoidi.
    
    f0 = 50;
    n_ext = 0:99;
    
    f1n = 2;          f2n = 5;          f3n = 10;
    f1 = f1n/f0;      f2 = f2n/f0;      f3 = f3n/f0;
    T1 = f0/f1n;      T2 = f0/f2n;      T3 = f0/f3n; 
    
    
    sin1 = sin( 2 * pi * f1 * n_ext);
    sin2 = sin( 2 * pi * f2 * n_ext);
    sin3 = sin( 2 * pi * f3 * n_ext);
    
    sin12 = sin1 + sin2;  T12 = lcm(f0,f0)/gcd(f1n,f2n);
    sin23 = sin2 + sin3;  T23 = lcm(f0,f0)/gcd(f2n,f3n);
    sin13 = sin1 + sin3;  T13 = lcm(f0,f0)/gcd(f1n,f3n);
    
     Sin12 = dft_N( sin12(1: 1*T12 ), 1*T12 );
    %Sin12 = dft_N( sin12(1: 1*T12 ), 2*T12 );
     Sin23 = dft_N( sin23(1: 1*T23 ), 1*T23 );
     Sin13 = dft_N( sin13(1: 1*T13 ), 1*T13 );

   figure('name','Seni di partenza');
     subplot(3,1,1); stem(n_ext, sin1,'b');   title('$$\sin_1(2 \pi \frac{2}{50} n)$$','Interpreter','latex','FontSize',14);  axis( [ 0 99 -2 2])
     subplot(3,1,2); stem(n_ext, sin2,'b');   title('$$\sin_2(2 \pi \frac{5}{50} n)$$','Interpreter','latex','FontSize',14);  axis( [ 0 99 -2 2])
     subplot(3,1,3); stem(n_ext, sin3,'b');   title('$$\sin_3(2 \pi \frac{10}{50} n)$$','Interpreter','latex','FontSize',14);  axis( [ 0 99 -2 2])
   
   figure('name','DFT di diverse combinazioni dei seni di partenza... N = periodo' );
   
     subplot(3,3,1); stem( n_ext,          sin12,'g');                 title('$$\sin_{12}$$','Interpreter','latex','FontSize',14);
                     hold on; ylim=get(gca,'ylim'); line([T12;T12],ylim.', 'linewidth', 2, 'color',[0,0,0]);
     subplot(3,3,2); stem( n_ext(1:1*T12), abs(Sin12),'r', 'filled');  title('$$|dft(\sin_{12},T_{12})|$$','Interpreter','latex','FontSize',14);
     subplot(3,3,3); stem( n_ext(1:1*T12), angle(Sin12),'b');          title('$$\angle dft(\sin_{12},T_{12})$$','Interpreter','latex','FontSize',14);
        
     subplot(3,3,4); stem( n_ext,          sin23,'g');                 title('$$\sin_{23}$$','Interpreter','latex','FontSize',14);
                     hold on; ylim=get(gca,'ylim'); line([T23;T23],ylim.', 'linewidth', 2, 'color',[0,0,0]);
     subplot(3,3,5); stem( n_ext(1:1*T23), abs(Sin23),'r', 'filled');  title('$$|dft(\sin_{23},T_{23})|$$','Interpreter','latex','FontSize',14);
     subplot(3,3,6); stem( n_ext(1:1*T23), angle(Sin23),'b');          title('$$\angle dft(\sin_{23},T_{23})$$','Interpreter','latex','FontSize',14);
     
     subplot(3,3,7); stem( n_ext,          sin13,'g');                 title('$$\sin_{13}$$','Interpreter','latex','FontSize',14);
                     hold on; ylim=get(gca,'ylim'); line([T13;T13],ylim.', 'linewidth', 2, 'color',[0,0,0]);
     subplot(3,3,8); stem( n_ext(1:1*T13), abs(Sin13),'r', 'filled');  title('$$|dft(\sin_{13},T_{13})|$$','Interpreter','latex','FontSize',14);
     subplot(3,3,9); stem( n_ext(1:1*T13), angle(Sin13),'b');          title('$$\angle dft(\sin_{13},T_{13})$$','Interpreter','latex','FontSize',14);
        
  
return;