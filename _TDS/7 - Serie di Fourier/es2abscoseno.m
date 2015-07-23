clear all; close all; clc;

% Assi del tempo e della frequenza
t= -10:.01:10;

T=2;  % sarebbe 4 ma il modulo di fatto divide per due il periodo

x2 = abs( cos(2*pi*(1/(2*T))*t - pi/4 ) );

n_arm= [ 10, 20, 30];
%n_arm= [ 12];

for n= 1:length(n_arm)

    tot= n_arm(n)/2;  % se ho dieci armoniche andrò da -5,-4,....-1,1,2,...,5
    X0= 2/pi;
    Xneg= zeros(1, tot);  % cioè i coefficienti minori di zero
    Xpos = Xneg;
    x2appr = X0;
    
    Xk= zeros(1, 2*tot);  % conterrà le n armoniche desiderate (10, 20 o 30)

    for i= 1: tot
        Xneg(i) = -tot +i -1;  % riempie -10/2, -10/2 +1, -10/2 + 2 ... 
        Xpos(i) = i;  % riempie -10/2 + 6, -10/2 +7, .. -10/2 + 10 ... 
    end

    for i= 1 : tot 
        Xk(i)=        ( -2/ (pi*( 4*(Xneg(i)^2 -1) ) ) ) * exp(-1i*pi*Xneg(i)/2) ;     % riempie Xk(-5), Xk(-4), Xk(-3), Xk(-2), Xk(-1)
        Xk(i+tot)=    ( -2/ (pi*( 4*(Xpos(i)^2 -1) ) ) ) * exp(-1i*pi*Xpos(i)/2) ;     % riempie Xk(+1), Xk(+2), Xk(+3), Xk(+4), Xk(+5)
    end
    
    for i= 1 : tot
       x2appr = x2appr + Xk(i)      * exp( 1i*2*pi*(Xneg(i)/T)*t); 
       x2appr = x2appr + Xk(i+tot)  * exp( 1i*2*pi*(Xpos(i)/T)*t); 
    end
    
    err = x2 - x2appr;

    str= sprintf('Coseno rettificato, con %d armoniche', n_arm(n));
    figure('name', str);
    subplot(1,3,1); plot(t, x2, 'b'); title('$$coseno\ rettificato$$','Interpreter','latex','FontSize',20); axis( [-3.5 3.5 -.3 1.3] )
    subplot(1,3,2); plot(t, x2, 'b'); hold on; plot(t, x2appr, 'r'); title('$$SdF$$','Interpreter','latex','FontSize',20); axis( [-3.5 3.5 -.3 1.3] )
    subplot(1,3,3); plot(t, err, 'g'); title('$$segnale\ errore$$','Interpreter','latex','FontSize',20); axis( [-3.5 3.5 -.3 1.3] )
end
    
return;