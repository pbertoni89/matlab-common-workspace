clear all; close all;

% Assi del tempo e della frequenza
t= -10:.01:10;
f= -10:.01:10;

T1=4;
T2=2;

x1base= t;   % retta passante per l'origine

x2base = abs( cos(2*pi*(1/(2*T2))*t - pi/4 ) ) .* my_rect(t/T2) ; % col rect ho preso il segnale base


%  stem( -tot:tot, real([flipud(Xneg); X0; Xpos]),'b'); hold on
%  stem( -tot:tot, imag([flipud(Xneg); X0; Xpos]),'rx--');

n_arm= [ 10, 20, 30];

for n= 1:length(n_arm)
    
    tot= n_arm(n)/2;  % se ho dieci armoniche andrò da -5,-4,....-1,1,2,...,5
   
    X1cont= 0; 
    X2cont= 2/pi;  % inserire calcolo
    
    A1 = zeros(1, 2*tot);  
    B1= A1; A1def = A1; B1def = A1;
    X2 = A1; X2def = A1;
    
    Xneg= zeros(1, tot);  % cioè i coefficienti minori di zero
    Xpos = Xneg;
    
    for k= 1: 2*tot
        
        A1def(k)= (1/T1)* riemannInt( t, 0, T1, x1base .* cos(2*pi*(k/T1)*t) );
        B1def(k)= (1/T1)* riemannInt( t, 0, T1, x1base .* sin(2*pi*(k/T1)*t) );
        
        A1(k)= 0;
        B1(k)= ((-2)*(-1)^k)  / (pi*k) ;
  
    end
    
    for i= 1: tot
        Xneg(i) = -tot +i -1;
        Xpos(i) = i;
    end

    for i= 1 : tot 
        
        X2def(i)=     (1/T2)* riemannInt( t, 0, T2, x1base .* exp( -1i*2*pi*(Xneg(i)/T2)*t) );
        X2def(i+tot)= (1/T2)* riemannInt( t, 0, T2, x1base .* exp( -1i*2*pi*(Xpos(i)/T2)*t) );
        
        X2(i)=        ( -2/ (pi*( 4*(Xneg(i)^2 -1) ) ) ) * exp(-1i*pi*Xneg(i)/2) ;     % riempie Xk(-5), Xk(-4), Xk(-3), Xk(-2), Xk(-1)
        X2(i+tot)=    ( -2/ (pi*( 4*(Xpos(i)^2 -1) ) ) ) * exp(-1i*pi*Xpos(i)/2) ;     % riempie Xk(+1), Xk(+2), Xk(+3), Xk(+4), Xk(+5)
    end
     
    figure('name','Coefficienti della Serie di Fourier per il coseno rettificato');
   % subplot(2,2,1); stem( -tot:tot, real([flipud(Xneg); X2cont; Xpos]),'b'); title('$$parte reale di formula data$$','Interpreter','latex','FontSize',20);
   % subplot(2,2,1); stem( -tot:tot, imag([flipud(Xneg); X2cont; Xpos]),'b'); title('$$parte imag di formula data$$','Interpreter','latex','FontSize',20);
  
    
end
    
return;