% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 3a: DTFT

clear; clc; close all;

t_start = cputime;

n = -30:30;
f = -2: .005 :2;
t = -5: .01 :5;
band= [-.5,.5]; % aiuta a identificare spettro base

% SEQUENCES DECLARATIONS

    x1 = exp( 1i * 2 * pi * .25 * n );
    x2 = sin( 2 * pi * sqrt(2) * n );
    x3 = sin( 2 * pi * 1.2 * n - pi/3 );
    x4 = rectN( n, 10);
    x5 = rectN( n-2, 5); % x5 = my_shift(x5, n, 2);
    
        x6t =  my_tri(t/4);
    
        Tc = .1; 
        fc = 1/Tc;

        t_elapsed = t(length(t)) - t(1);                

        samples = t_elapsed * fc;   % numero di campioni
        n_c = 0 : 1 : samples ;       % campioni del segnale.
        n_sc = n_c/fc;           % n scaled, è una normalizzazione che associa i campioni al loro istante effettivo.         

        x6c = my_tri( ( ( n_c -n_c(length(n_c))/2 ) /fc) /4 );

%% DTFT CALLS

    X1 = dtft( x1, n, f);
    X2 = dtft( x2, n, f);
    X3 = dtft( x3, n, f);
    X4 = dtft( x4, n, f);
    X5 = dtft( x5, n, f);
    X6 = dtft( x6c, n_c, f);

    figure(1);
        subplot(1,2,1); stem( n, x1, 'b', 'filled'); title('$$e^{\jmath 2 \pi \frac{1}{4} n}$$','Interpreter','latex','FontSize',20); %axis( [-9 9 -.2 4] )
        subplot(1,2,2); plot( f, X1, 'r'); title('$$ X_1(f) $$','Interpreter','latex','FontSize',20); %axis( [-9 9 -.2 4] )
        hold on; ylim=get(gca,'ylim'); line([band;band],ylim.', 'linewidth', 2, 'color',[0,0,0]);
        
    figure(2);     
        subplot(1,2,1); stem( n, x2, 'b', 'filled'); title('$$\sin( 2 \pi \frac{1}{5} n)    $$','Interpreter','latex','FontSize',20); %axis( [-11 11 -.2 4] )
        subplot(1,2,2); plot( f, X2, 'r'); title('$$ X_2(f) $$','Interpreter','latex','FontSize',20); %axis( [-9 9 -.2 4] )
        hold on; ylim=get(gca,'ylim'); line([band;band],ylim.', 'linewidth', 2, 'color',[0,0,0]);
        
    figure(3);    
        subplot(1,2,1); stem( n, x3, 'b', 'filled'); title('$$\sin( 2 \pi \frac{6}{5} - \frac{\pi}{3} n)$$','Interpreter','latex','FontSize',20); %axis( [-20 20 -.2 4] )
        subplot(1,2,2); plot( f, X3, 'r'); title('$$ X_3(f) $$','Interpreter','latex','FontSize',20); %axis( [-9 9 -.2 4] )
        hold on; ylim=get(gca,'ylim'); line([band;band],ylim.', 'linewidth', 2, 'color',[0,0,0]);
        
    figure(4);
        subplot(1,2,1); stem( n, x4, 'b', 'filled'); title('$$rect_{10}(n)$$','Interpreter','latex','FontSize',20); %axis( [-9 9 -.2 4] )
        subplot(1,2,2); plot( f, X4, 'r'); title('$$ X_4(f) $$','Interpreter','latex','FontSize',20); %axis( [-9 9 -.2 4] )
        hold on; ylim=get(gca,'ylim'); line([band;band],ylim.', 'linewidth', 2, 'color',[0,0,0]);
        
    figure(5);
        subplot(1,2,1); stem( n, x5, 'b', 'filled'); title('$$rect_5(n-2)$$','Interpreter','latex','FontSize',20); %axis( [-9 9 -.2 4] )
        subplot(1,2,2); plot( f, X5, 'r'); title('$$ X_5(f) $$','Interpreter','latex','FontSize',20); %axis( [-9 9 -.2 4] )
        hold on; ylim=get(gca,'ylim'); line([band;band],ylim.', 'linewidth', 2, 'color',[0,0,0]);
        
    figure(6);
        subplot(1,2,1); stem( n_c, x6c, 'b', 'filled'); title('$$ tri(\frac{n}{4})$$','Interpreter','latex','FontSize',20); %axis( [-9 9 -.2 4] )
        subplot(1,2,2); plot( f, X6, 'r'); title('$$ X_6(f) $$','Interpreter','latex','FontSize',20); %axis( [-9 9 -.2 4] )
        hold on; ylim=get(gca,'ylim'); line([band;band],ylim.', 'linewidth', 2, 'color',[0,0,0]);
    
    fprintf ( 1, 'Elapsed CPU time = %f\n', cputime - t_start );
    return;