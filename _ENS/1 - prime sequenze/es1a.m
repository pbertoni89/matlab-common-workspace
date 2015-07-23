
% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 

% esercizio 1: segnali e operazioni elementari
%

clear; clc; close all;

n= -10:10;
t= -10:.1:10; % per inviluppi seno

A= .75;      x1= A* impulso(n);

B= .9;       x2= B* step(n);

C= 1; N= 5;  x3= C* rectN(n,N);

E= .5;       x4= (E.^n) .* step(n);

D= 1; f0_raz= 0.25; f0_irr= sqrt(2)/10; 

x5_raz= D* sin( 2*pi*f0_raz*n); x5_raz_inv= D* sin( 2*pi*f0_raz*t);
x5_irr= D* sin( 2*pi*f0_irr*n); x5_irr_inv= D* sin( 2*pi*f0_irr*t);

str= sprintf('Sequenze elementari di ENS');
    figure('name', str);
    subplot(2,3,1); stem( n, x1,'r','filled','linewidth',2); title('$$impulso\ unitario$$','Interpreter','latex','FontSize',20);     axis( [-10 10 -.2 1.2] )
    subplot(2,3,2); stem( n, x2,'b','filled');               title('$$gradino$$','Interpreter','latex','FontSize',20);               axis( [-10 10 -.2 1.2] )
    subplot(2,3,3); stem( n, x3,'y','filled'); title('$$sequenza\ rettangolare$$','Interpreter','latex','FontSize',20);              axis( [-10 10 -.2 1.2] )
    subplot(2,3,4); stem( n, x4,'k','filled'); title('$$sequenza\ esponenziale$$','Interpreter','latex','FontSize',20);              axis( [-10 10 -.2 1.2] )
    subplot(2,3,5); stem( n, x5_raz,'g','filled'); hold on; plot(t,x5_raz_inv,'b--');           title('$$seno\ razionale$$','Interpreter','latex','FontSize',20);   axis( [-3.5 3.5 -1.1 1.1] )
    subplot(2,3,6); stem( n, x5_irr,'g','filled'); hold on; plot(t,x5_irr_inv,'b--');          title('$$seno\ irrazionale$$','Interpreter','latex','FontSize',20);  axis( [-3.5 3.5 -1.1 1.1] )
    
    
%%

n0 = 4;  % traslazione a destra se col segno positivo.
x1_trasl = my_shift( x1, n, n0);

n0 = 6;
x3_trasl = my_shift( x3, n, n0);

x3_rot = my_rotate( x3, n);

n0 = 3;
x3_rototrasl = my_rotate( my_shift( x3, n, n0), n );

D = 2;    
x6_decim = my_decimate(x3_rototrasl, n, D);

I = 3;    
n_ext = -31:31; %% awful, fix
x6_interp = my_interp(x3_rototrasl, I);

str2= sprintf('Operazioni elementari di ENS');
    figure('name', str2);
    subplot(2,3,1); stem( n, x1_trasl,'r','filled','linewidth',2); title('$$\delta(n-4)$$','Interpreter','latex','FontSize',20);        axis( [-10 10 -.2 1.2] )
    subplot(2,3,2); stem( n, x3_trasl,'b','filled');               title('$$rect_5(n-6)     $$','Interpreter','latex','FontSize',20);   axis( [-10 10 -.2 1.2] )
    subplot(2,3,3); stem( n, x3_rot,'g','filled');                 title('$$rect_5(-n)      $$','Interpreter','latex','FontSize',20);   axis( [-10 10 -.2 1.2] )
    subplot(2,3,4); stem( n, x3_rototrasl,'y','filled');           title('$$rect_5(3-n)$$','Interpreter','latex','FontSize',20);        axis( [-10 10 -.2 1.2] )
    subplot(2,3,5); stem( n, x6_decim,'r','filled');           title('$$rect_5( 2(3-n) )$$','Interpreter','latex','FontSize',20);         axis( [-10 10 -.2 1.2] )
    subplot(2,3,6); stem( n_ext, x6_interp,'k','filled');           title('$$rect_5( (3-n)/3 )$$','Interpreter','latex','FontSize',20);  axis tight

    
%%

N= 3;
n_base= -2:2; % se uso n, ottengo rettangoli spostati con tutto il loro spazio -10:10
x3= rectN(n_base,N);
x3  = x3';

p= 6;
sq_wave = x3 * ones(1,p);
sq_wave = sq_wave(:);
sq_wave = sq_wave';

n_ext= 1:length(sq_wave); % la convoluzione ha esteso il supporto!
n_ext = n_ext-ceil(length(sq_wave)/2);
n_ext2= -20:20; % comoda, per le conv tra i rect

A1 = 4; N1 = 5; A2 = 3; N2 = 3;

r1= A1* rectN(n,N1); r2= A2* rectN(n,N2);

r1_conv_r2 = conv(r1, r2);

offset = 3;
r1_trasl = my_shift(r1, n, offset);

r1_trasl_conv_r2 = conv(r1_trasl, r2);


str3= sprintf('Convoluzioni elementari di ENS');
    figure('name', str3);
    subplot(1,3,1); stem( n_ext, sq_wave, 'b'); title('$$rect_3(n) \ast \sum_k delta(n-k)$$','Interpreter','latex','FontSize',20);   %axis( [-10 10 -.2 1.2] )
    subplot(1,3,2); stem( n_ext2, r1_conv_r2, 'g'); title('$$4rect_5(n) \ast 3rect_3(n)$$','Interpreter','latex','FontSize',20);   %axis( [-10 10 -.2 1.2] )
    subplot(1,3,3); stem( n_ext2, r1_trasl_conv_r2, 'g'); title('$$4rect_5(n-1) \ast 3rect_3(n)$$','Interpreter','latex','FontSize',20);   %axis( [-10 10 -.2 1.2] )

    
return;