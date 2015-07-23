% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% Simulazione

clear; clc; close all;

%i)

    l_s = 930;
    n_s = 0:l_s-1;
    s = randn(1,l_s);

%ii)

    l_h = 15;
    n_h = 0:l_h-1;
    h = triang(l_h)';

    f = -.5: .005 : .5;

    H = dtft( h, n_h, f);

    figure('name','Risposta del Filtro');

     subplot(3,1,1); stem(n_h,h,'b', 'filled');   
        title('$$h(n) $$','Interpreter','latex','FontSize',20);     axis( [ 0 15 -1 2])
     subplot(3,1,2); stem(f,abs(H),'r');      
        title('$$|H(f)|$$','Interpreter','latex','FontSize',20);       axis( [ -.5 .5 -1 10])
     subplot(3,1,3); stem(f,angle(H),'g');      
        title('$$\angle H(f) $$','Interpreter','latex','FontSize',20);  axis( [ -.5 .5 -4 4])
    
    
 %iii)
 
     pads = l_s - l_h;

     h_pad = [ h zeros(1,pads) ];

     a = conv ( s, h_pad );

     remove = floor(length(a)+1);

     a = a( 1 : floor(remove*(2/4)) );

     figure('name','Filtraggio LTI');

     subplot(3,1,1); stem(n_s,s,'b', 'filled');   
        title('$$s(n)$$','Interpreter','latex','FontSize',20);    axis( [ 0 930 -5 5])
     subplot(3,1,2); stem(n_s,h_pad,'r');      
        title('$$h(n)$$','Interpreter','latex','FontSize',20);    axis( [ 0 930 -5 5])
     subplot(3,1,3); stem(n_s,a,'g');      
        title('$$a(n) = s(n) \ast h(n)$$','Interpreter','latex','FontSize',20);  %axis( [ 0 15 -4 4])
    
    
 %iv)
 
     L = 186;
     M = length(h);
     N = L+M-1;

     blocks = l_s / L;

     h_padded = [ h zeros(1, L-1) ];

     for i = 1 : blocks 
         %fprintf('da %d a %d \n', 1+ (L)*(i-1), L*i );

        block = s( 1 + (L)*(i-1) : L*i );

        block_padded = [ block zeros(1,M-1) ];

        temp = ifft ( fft(h_padded) .* fft(block_padded) ); % FILTRAGGIO INDIRETTO

        if i == 1  
           % fprintf('salvo i primi valori da 1 al %d = %d + %d -1 \n', N, M, L );
            b = temp(1:N);
        else
           % fprintf('riporto b(1:%d) | b(%d:%d) + temp(1:%d) | in coda temp(%d:%d) \n', L*(i-1), (L*(i-1))+1, (L*(i-1))+M-1, M-1, M, N   );
            b = [ b( 1 : (L*(i-1)) )    b( (L*(i-1))+1 : (L*(i-1))+M-1 )  +  temp( 1 : M-1 )      temp( M : N )  ];
        end
      %fprintf('done step %d\n',i);

     end

     b = b(1:length(b)-(M-1));

     figure('name','Overlap & ADD');

     subplot(3,1,1); stem(n_s,s,'b', 'filled');   
        title('$$s(n)$$','Interpreter','latex','FontSize',20);    axis( [ 0 930 -5 5])
     subplot(3,1,2); stem(n_s,h_pad,'r');      
        title('$$h(n)$$','Interpreter','latex','FontSize',20);    axis( [ 0 930 -5 5])
     subplot(3,1,3); stem(n_s,b,'g');      
        title('$$b(n) = s(n) \ast h(n)$$','Interpreter','latex','FontSize',20);  %axis( [ 0 15 -4 4])

    
%v)

    d = a - b;

    figure('name','Differenza tra algoritmi di convoluzione "intera" con Overlap&Add');
        stem(n_s,d,'k');      
        title('$$d(n)=a(n)-b(n)$$','Interpreter','latex','FontSize',20);  %axis( [ 0 930 -.1 .1])  

    % IPOTIZZO CHE GLI ERRORI DELL'ORDINE DI 1e-16 SIANO DI ROUNDOFF
    % GRANULARE PIù CHE ALTRO.

return;
    
    