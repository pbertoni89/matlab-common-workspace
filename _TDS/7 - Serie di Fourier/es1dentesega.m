clear all; close all; clc;

% Assi del tempo e della frequenza
t= -10:.01:10;
f= -15:.01:15;

T=4;

x1 = dente_sega(t,T);

n_arm= [ 10, 20, 30];

for n= 1:length(n_arm)
 
    X0=0;
    bks= zeros(1, n_arm(n));  % cioè i coefficienti b di k della parte dispari
    aks = bks;
    x1appr = X0;
    
    for k= 1:n_arm(n)
        % aks(k)= 0 già a zero
        bks(k)= ((-2)*(-1)^k)  / (pi*k) ;
    end

    for k=1:n_arm(n)
       x1appr= x1appr + 2*aks(k)*cos(2*pi*(k/T)*t) +  2*bks(k)*sin(2*pi*(k/T)*t);
    end

    err = x1 - x1appr;

    str= sprintf('Dente di sega, con %d armoniche', n_arm(n));
    figure('name', str);
    subplot(1,3,1); plot(t, x1, 'b'); title('$$\ dente\ di\ sega$$','Interpreter','latex','FontSize',20); axis( [-6.5 6.5 -5 5] )
    subplot(1,3,2); plot(t, x1, 'b'); hold on; plot(t, x1appr, 'r'); title('$$SdF$$','Interpreter','latex','FontSize',20); axis( [-6.5 6.5 -5 5] )
    subplot(1,3,3); plot(t, err, 'g'); title('$$segnale\ errore$$','Interpreter','latex','FontSize',20); axis( [-6.5 6.5 -5 5] )
end
    
return;