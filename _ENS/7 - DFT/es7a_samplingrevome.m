% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 7a: DFT

clear; clc; close all;
dt = 1e-3;
stop = 10;
t = 0 : dt : stop-dt;  % da 0 a 10 s con passo 1 ms. 
lt = length(t);
t_elapsed = t(lt)-t(1);

N = [ 4 10 50];   
n1 = 0 : N(1)-1;   n2 = 0 : N(2)-1;   n3 = 0 : N(3)-1;

%% i
% Segnali discreti di varie lunghezze N (es. N=6, N=10, N=50), con valori presi su un periodo causale (t > 0) 
% di un segnale continuo triangolare periodico di ampiezza 1 e simmetria temporale pari.


% sc = 1;     % se sc = 2    è il tri(t/2)
% lw = 1;     % se lw = 2    son 2 secondi di tensione nulla
% 
% t_base = -1/sc : dt : 1/sc-dt;
% 
%     tri_up = my_tri( (t_base) );
%     dur_up = sc*2;
%     tri_low = zeros(1, lw/dt );  % 1k di quanti corrispondono a 1 sec su t
%     dur_low = lw;
%         
% tri_wav = [ tri_up tri_low ];
% dur_wav = dur_up + dur_low;
% 
% t_wav = -1/sc : dt : dur_up - dt;
% 
% reps = 5;                  % ripetizioni totali: DEVONO DISPARI
% reps_sx = floor(reps/2);      % ripetizioni anticausali
% 
% t_tri = - (reps_sx * dur_wav + 1) : dt : (reps_sx * dur_wav + 1 + 1) - dt;
% 
% Ttri = dur_wav;
% 
% x_tri = repmat( tri_wav, 1, reps );
% 
% tri_oss = length( t_tri( find( t_tri == 2 ) : find( t_tri == 5 ) ) );
% 
% figure('name','Triangle');
% plot(t_tri,x_tri)
% 
% 
% tri_n1 = x_tri( 1 : ( oss(1)/N(1) ) : oss(1) );
% tri_n2 = x_tri( 1 : ( oss(1)/N(2) ) : oss(1) );
% tri_n3 = x_tri( 1 : ( oss(1)/N(3) ) : oss(1) );
% 
% figure('name','Sine Sampling, lambda = 1.5');
%     subplot(3,1,1);  plot(t,sin_a,'y'); hold on; stem( n1 * t( oss(1)/N(1) ), sin1_n1, 'r');
%     subplot(3,1,2);  plot(t,sin_a,'y'); hold on; stem( n2 * t( oss(1)/N(2) ), sin1_n2, 'b');
%     subplot(3,1,3);  plot(t,sin_a,'y'); hold on; stem( n3 * t( oss(1)/N(3) ), sin1_n3, 'k');
     

%%  Sines

stop = 10;
t = 0 : dt : stop-dt; 

f0 = .5;
T0 = 1/f0;

sin_a = sin( 2 * pi * f0 * t);
Sin_a = fft(sin_a);
Sin_a = handle_fft(Sin_a);

cos_a = cos( 2 * pi * f0 * t);
Cos_a = fft(cos_a);
Cos_a = handle_fft(Cos_a);

figure('name','Sine & Cosine Starting'); 
    subplot(2,3,1);  plot(t,sin_a,'y');                                 title('$$\sin_a(2 \pi \frac{1}{2} t)$$','Interpreter','latex','FontSize',16);
    subplot(2,3,2);  plot( (0:length(t)-1)/length(t),abs(Sin_a),'r');   title('$$| Sin_a |$$','Interpreter','latex','FontSize',16);   axis([ 0 1 -10 10 ])
    subplot(2,3,3);  plot( (0:length(t)-1)/length(t),angle(Sin_a),'b'); title('$$\angle Sin_a$$','Interpreter','latex','FontSize',16); axis([ 0 1 -10 10 ])
    subplot(2,3,4);  plot(t,cos_a,'y');                                 title('$$\cos_a(2 \pi \frac{1}{2} t)$$','Interpreter','latex','FontSize',16); 
    subplot(2,3,5);  plot( (0:length(t)-1)/length(t),abs(Cos_a),'r');   title('$$| Cos_a|$$','Interpreter','latex','FontSize',16); axis([ 0 1 -10 10 ])
    subplot(2,3,6);  plot( (0:length(t)-1)/length(t),angle(Cos_a),'b'); title('$$\angle Cos_a$$','Interpreter','latex','FontSize',16); axis([ 0 1 -10 10 ])

lambda = [ 1.5 1.0 0.5 ];
oss(1) = length( t( 1 : find( t == lambda(1)*T0 )-1) );
oss(2) = length( t( 1 : find( t == lambda(2)*T0 )-1) );
oss(3) = length( t( 1 : find( t == lambda(3)*T0 )-1) );

%% ii
% Segnali discreti di varie lunghezze N, con valori presi su 1,5 periodi causali (t > 0) di un
% segnale continuo sinusoidale di ampiezza 1.

sin1_n1 = sin_a( 1 : ( oss(1)/N(1) ) : oss(1) );
sin1_n2 = sin_a( 1 : ( oss(1)/N(2) ) : oss(1) );
sin1_n3 = sin_a( 1 : ( oss(1)/N(3) ) : oss(1) );

figure('name','Sine Sampling, lambda = 1.5');
    subplot(3,1,1);  plot(t,sin_a,'y'); hold on; stem( n1 * t( oss(1)/N(1) ), sin1_n1, 'r');
    subplot(3,1,2);  plot(t,sin_a,'y'); hold on; stem( n2 * t( oss(1)/N(2) ), sin1_n2, 'b');
    subplot(3,1,3);  plot(t,sin_a,'y'); hold on; stem( n3 * t( oss(1)/N(3) ), sin1_n3, 'k');
    
%% iii

% Segnali discreti di varie lunghezze N, con valori presi su 1 periodo causali (t > 0) di un
% segnale continuo cosinusoidale di ampiezza 1.

cos2_n1 = cos_a( 1 : (oss(2)/N(1)) : oss(2) );
cos2_n2 = cos_a( 1 : (oss(2)/N(2)) : oss(2) );
cos2_n3 = cos_a( 1 : (oss(2)/N(3)) : oss(2) );

figure('name','Cosine Sampling, lambda = 1');
    subplot(3,1,1);  plot(t,cos_a,'y'); hold on; stem( n1 * t(oss(2)/N(1)), cos2_n1, 'r');
    subplot(3,1,2);  plot(t,cos_a,'y'); hold on; stem( n2 * t(oss(2)/N(2)), cos2_n2, 'b');
    subplot(3,1,3);  plot(t,cos_a,'y'); hold on; stem( n3 * t(oss(2)/N(3)), cos2_n3, 'k');
    
%% iv

% Segnali discreti di varie lunghezze N, con valori presi su 0,5 periodi causali (t > 0) di un
% segnale continuo cosinusoidale di ampiezza 1.

cos3_n1 = cos_a( 1 : (oss(3)/N(1)) : oss(3) );
cos3_n2 = cos_a( 1 : (oss(3)/N(2)) : oss(3) );
cos3_n3 = cos_a( 1 : (oss(3)/N(3)) : oss(3) );

figure('name','Cosine Sampling, lambda = .5');
    subplot(3,1,1);  plot(t,cos_a,'y'); hold on; stem( n1 * t(oss(3)/N(1)), cos3_n1, 'r');
    subplot(3,1,2);  plot(t,cos_a,'y'); hold on; stem( n2 * t(oss(3)/N(2)), cos3_n2, 'b');
    subplot(3,1,3);  plot(t,cos_a,'y'); hold on; stem( n3 * t(oss(3)/N(3)), cos3_n3, 'k');

%% v Patrick's fft of sampled sins

Sin1_n1 = fft(sin1_n1);
Sin1_n2 = fft(sin1_n2);
Sin1_n3 = fft(sin1_n3);
Cos2_n1 = fft(cos2_n1);
Cos2_n2 = fft(cos2_n2);
Cos2_n3 = fft(cos2_n3);
Cos3_n1 = fft(cos3_n1);
Cos3_n2 = fft(cos3_n2);
Cos3_n3 = fft(cos3_n3);
    
%% Es2 i Zero PADDING

% effettuare sui segnali dati un'operazione di zero padding inserendo un numero M di zeri in coda al segnale. 
% Disegnare lo spettro DFT del segnale dato e delle DFT dei segnali paddati per diversi valori di M.

M = [ 06 20 40 ];   
m1 = zeros(1,M(1));   m2 = zeros(1,M(2));   m3 = zeros(1,M(3));

sin1_n1_m1 = [ sin1_n1 m1 ];
sin1_n2_m2 = [ sin1_n2 m2 ];
sin1_n3_m3 = [ sin1_n3 m3 ];

cos2_n1_m1 = [ cos2_n1 m1 ];
cos2_n2_m2 = [ cos2_n2 m2 ];
cos2_n3_m3 = [ cos2_n3 m3 ];

cos3_n1_m1 = [ cos3_n1 m1 ];
cos3_n2_m2 = [ cos3_n2 m2 ];
cos3_n3_m3 = [ cos3_n3 m3 ];


% Sin1_n1_m1  = dft_N( sin1_n1_m1, N(1)+M(1) ) ;
% Sin1_n2_m2  = dft_N( sin1_n2_m2, N(2)+M(2) ) ;
% Sin1_n3_m3  = dft_N( sin1_n3_m3, N(3)+M(3) ) ;
% 
% Cos2_n1_m1  = dft_N( cos2_n1_m1, N(1)+M(1) ) ;
% Cos2_n2_m2  = dft_N( cos2_n2_m2, N(2)+M(2) ) ;
% Cos2_n3_m3  = dft_N( cos2_n3_m3, N(3)+M(3) ) ;
% 
% Cos3_n1_m1  = dft_N( cos3_n1_m1, N(1)+M(1) ) ;
% Cos3_n2_m2  = dft_N( cos3_n2_m2, N(2)+M(2) ) ;
% Cos3_n3_m3  = dft_N( cos3_n3_m3, N(3)+M(3) ) ;

Sin1_n1_m1  = fft( sin1_n1_m1, N(1)+M(1) ) ;
Sin1_n2_m2  = fft( sin1_n2_m2, N(2)+M(2) ) ;
Sin1_n3_m3  = fft( sin1_n3_m3, N(3)+M(3) ) ;

Cos2_n1_m1  = fft( cos2_n1_m1, N(1)+M(1) ) ;
Cos2_n2_m2  = fft( cos2_n2_m2, N(2)+M(2) ) ;
Cos2_n3_m3  = fft( cos2_n3_m3, N(3)+M(3) ) ;

Cos3_n1_m1  = fft( cos3_n1_m1, N(1)+M(1) ) ;
Cos3_n2_m2  = fft( cos3_n2_m2, N(2)+M(2) ) ;
Cos3_n3_m3  = fft( cos3_n3_m3, N(3)+M(3) ) ;

 figure('name','padded Sine DFT, lambda = 1.5');
   
     subplot(3,2,1); stem( 0:N(1)+M(1)-1, abs(Sin1_n1_m1),'r', 'filled');  title('$$| dft(\sin_1, N_{4}+M_{6}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,2); stem( 0:N(1)+M(1)-1, angle(Sin1_n1_m1),'b');          title('$$\angle dft(\sin_1, N_{4}+M_{6})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,3); stem( 0:N(2)+M(2)-1, abs(Sin1_n2_m2),'r', 'filled');  title('$$| dft(\sin_1, N_{20}+M_{10}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,4); stem( 0:N(2)+M(2)-1, angle(Sin1_n2_m2),'b');          title('$$\angle dft(\sin_1, N_{20}+M_{10})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,5); stem( 0:N(3)+M(3)-1, abs(Sin1_n3_m3),'r', 'filled');  title('$$| dft(\sin_1, N_{50}+M_{20}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,6); stem( 0:N(3)+M(3)-1, angle(Sin1_n3_m3),'b');          title('$$\angle dft(\sin_1,N_{50}+M_{20})$$','Interpreter','latex','FontSize',16);

 figure('name','padded Cosine DFT, lambda = 1.0');
   
     subplot(3,2,1); stem( 0:N(1)+M(1)-1, abs(Cos2_n1_m1),'r', 'filled');  title('$$| dft(\cos_2, N_{4}+M_{6}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,2); stem( 0:N(1)+M(1)-1, angle(Cos2_n1_m1),'b');          title('$$\angle dft(\cos_2, N_{4}+M_{6})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,3); stem( 0:N(2)+M(2)-1, abs(Cos2_n2_m2),'r', 'filled');  title('$$| dft(\cos2, N_{20}+M_{10}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,4); stem( 0:N(2)+M(2)-1, angle(Cos2_n2_m2),'b');          title('$$\angle dft(\cos2, N_{20}+M_{10})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,5); stem( 0:N(3)+M(3)-1, abs(Cos2_n3_m3),'r', 'filled');  title('$$| dft(\cos2, N_{50}+M_{20}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,6); stem( 0:N(3)+M(3)-1, angle(Cos2_n3_m3),'b');          title('$$\angle dft(\cos2,N_{50}+M_{20})$$','Interpreter','latex','FontSize',16);
     
 figure('name','padded Cosine DFT, lambda = 0.5');
   
     subplot(3,2,1); stem( 0:N(1)+M(1)-1, abs(Cos3_n1_m1),'r', 'filled');  title('$$| dft(\cos_3, N_{4}+M_{6}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,2); stem( 0:N(1)+M(1)-1, angle(Cos3_n1_m1),'b');          title('$$\angle dft(\cos_3, N_{4}+M_{6})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,3); stem( 0:N(2)+M(2)-1, abs(Cos3_n2_m2),'r', 'filled');  title('$$| dft(\cos3, N_{20}+M_{10}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,4); stem( 0:N(2)+M(2)-1, angle(Cos3_n2_m2),'b');          title('$$\angle dft(\cos3, N_{20}+M_{10})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,5); stem( 0:N(3)+M(3)-1, abs(Cos3_n3_m3),'r', 'filled');  title('$$| dft(\cos3, N_{50}+M_{20}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,6); stem( 0:N(3)+M(3)-1, angle(Cos3_n3_m3),'b');          title('$$\angle dft(\cos3,N_{50}+M_{20})$$','Interpreter','latex','FontSize',16);
     
%% Es2 ii Zero Interleaving

% effettuare sui segnali dati un'operazione di zero interleaving inserendo un numero L di zeri tra un campione e l'altro.
% Disegnare lo spettro DFT del segnale dato e delle DFT dei segnali paddati per diversi valori di L.

L = [ 06 20 40 ];   
l1 = zeros(1,L(1));   l2 = zeros(1,L(2));   l3 = zeros(1,L(3));

sin1_n1_l1 = my_interp( sin1_n1, n1, L(1) );
sin1_n2_l2 = my_interp( sin1_n2, n2, L(2) );
sin1_n3_l3 = my_interp( sin1_n2, n3, L(3) );

cos2_n1_l1 = my_interp( cos2_n1, n1, L(1) );
cos2_n2_l2 = my_interp( cos2_n2, n2, L(2) );
cos2_n3_l3 = my_interp( cos2_n3, n3, L(3) );

cos3_n1_l1 = my_interp( cos3_n1, n1, L(1) );
cos3_n2_l2 = my_interp( cos3_n2, n2, L(2) );
cos3_n3_l3 = my_interp( cos3_n3, n3, L(3) );


Sin1_n1_l1  = fft( sin1_n1_l1, N(1)+L(1) ) ;
Sin1_n2_l2  = fft( sin1_n2_l2, N(2)+L(2) ) ;
Sin1_n3_l3  = fft( sin1_n3_l3, N(3)+L(3) ) ;

Cos2_n1_l1  = fft( cos2_n1_l1, N(1)+L(1) ) ;
Cos2_n2_l2  = fft( cos2_n2_l2, N(2)+L(2) ) ;
Cos2_n3_l3  = fft( cos2_n3_l3, N(3)+L(3) ) ;

Cos3_n1_l1  = fft( cos3_n1_l1, N(1)+L(1) ) ;
Cos3_n2_l2  = fft( cos3_n2_l2, N(2)+L(2) ) ;
Cos3_n3_l3  = fft( cos3_n3_l3, N(3)+L(3) ) ;


 figure('name','interleaved Sine DFT, lambda = 1.5');
   
     subplot(3,2,1); stem( 0:N(1)+L(1)-1, abs(Sin1_n1_l1),'r', 'filled');  title('$$| dft(\sin_1, N_{4}+L_{6}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,2); stem( 0:N(1)+L(1)-1, angle(Sin1_n1_l1),'b');          title('$$\angle dft(\sin_1, N_{4}+L_{6})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,3); stem( 0:N(2)+L(2)-1, abs(Sin1_n2_l2),'r', 'filled');  title('$$| dft(\sin_1, N_{20}+L_{10}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,4); stem( 0:N(2)+L(2)-1, angle(Sin1_n2_l2),'b');          title('$$\angle dft(\sin_1, N_{20}+L_{10})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,5); stem( 0:N(3)+L(3)-1, abs(Sin1_n3_l3),'r', 'filled');  title('$$| dft(\sin_1, N_{50}+L_{20}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,6); stem( 0:N(3)+L(3)-1, angle(Sin1_n3_l3),'b');          title('$$\angle dft(\sin_1,N_{50}+L_{20})$$','Interpreter','latex','FontSize',16);

 figure('name','interleaved Cosine DFT, lambda = 1.0');
   
     subplot(3,2,1); stem( 0:N(1)+L(1)-1, abs(Cos2_n1_l1),'r', 'filled');  title('$$| dft(\cos_2, N_{4}+L_{6}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,2); stem( 0:N(1)+L(1)-1, angle(Cos2_n1_l1),'b');          title('$$\angle dft(\cos_2, N_{4}+L_{6})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,3); stem( 0:N(2)+L(2)-1, abs(Cos2_n2_l2),'r', 'filled');  title('$$| dft(\cos2, N_{20}+L_{10}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,4); stem( 0:N(2)+L(2)-1, angle(Cos2_n2_l2),'b');          title('$$\angle dft(\cos2, N_{20}+L_{10})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,5); stem( 0:N(3)+L(3)-1, abs(Cos2_n3_l3),'r', 'filled');  title('$$| dft(\cos2, N_{50}+L_{20}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,6); stem( 0:N(3)+L(3)-1, angle(Cos2_n3_l3),'b');          title('$$\angle dft(\cos2,N_{50}+L_{20})$$','Interpreter','latex','FontSize',16);
     
 figure('name','interleaved Cosine DFT, lambda = 0.5');
   
     subplot(3,2,1); stem( 0:N(1)+L(1)-1, abs(Cos3_n1_l1),'r', 'filled');  title('$$| dft(\cos_3, N_{4}+L_{6}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,2); stem( 0:N(1)+L(1)-1, angle(Cos3_n1_l1),'b');          title('$$\angle dft(\cos_3, N_{4}+L_{6})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,3); stem( 0:N(2)+L(2)-1, abs(Cos3_n2_l2),'r', 'filled');  title('$$| dft(\cos3, N_{20}+L_{10}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,4); stem( 0:N(2)+L(2)-1, angle(Cos3_n2_l2),'b');          title('$$\angle dft(\cos3, N_{20}+L_{10})$$','Interpreter','latex','FontSize',16);
     subplot(3,2,5); stem( 0:N(3)+L(3)-1, abs(Cos3_n3_l3),'r', 'filled');  title('$$| dft(\cos3, N_{50}+L_{20}) |$$','Interpreter','latex','FontSize',16);
     subplot(3,2,6); stem( 0:N(3)+L(3)-1, angle(Cos3_n3_l3),'b');          title('$$\angle dft(\cos3,N_{50}+L_{20})$$','Interpreter','latex','FontSize',16);
     
%% Es 3 i Zero Padding in Frequenza

% Attenzione:   se dft(N/2) != 0, no problemi. sparo zeri a destra e a sinistra.
%                 else, ricordiamoci che il dft(N/2) è il campione più
%                 negativo di tutti!!! quindi?
 
 
return;


