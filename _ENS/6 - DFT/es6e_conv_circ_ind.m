% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 6a: DFT

clear; clc; close all;

n = 0:5;
N = length(n);

%% start

%
x1 = [ 0 -1 2 -1];   % X1 nota = [ 0 -2 4 -2]
X1 =       dft_N(x1,length(x1));
x1_back =  idft_N(X1,length(x1));

%
y1 = rectN(n,4);
Y1 = dft_N(y1,N);
y1_back = idft_N(Y1,N);

%
y2 = n;
Y2 = dft_N(y2,N);
y2_back = idft_N(Y2,N) ;

%% convolving
% mi aspetto un ~ tri !

% rcr = ccirc_ind_N( y1, y1, 0 );   di certo corretta, N diventa 2*L -1
% rcr = ccirc_ind_N( y1, y1, 4 );   ALIASING TEMPORALE  (esce 4.rect4 )
% rcr = ccirc_ind_N( y1, y1, 5 );   ancora ALIASING
% rcr = ccirc_ind_N( y1, y1, 6 );   ultimo ALIASING (difatti N minimo è 7 )

%% OUTPUT

%
figure(1);
 subplot(1,2,1); stem(0:length(x1)-1,x1,'b', 'filled');   title('$$x_1 = {0,-1,2,-1}$$','Interpreter','latex','FontSize',20);
 subplot(1,2,2); stem(0:length(x1)-1,x1_back,'b', 'filled');   title('$$x_1 = idft(X_1,4)$$','Interpreter','latex','FontSize',20);

figure(2);     
 subplot(1,2,1); stem(0:length(x1)-1,abs(X1),'r');      title('$$|X_1|$$','Interpreter','latex','FontSize',20);          axis( [ 0 9 -1 5])
 subplot(1,2,2); stem(0:length(x1)-1,angle(X1),'g');      title('$$\angle X_1$$','Interpreter','latex','FontSize',20);   axis( [ 0 9 -5 3])

% 
figure(3);
 subplot(1,2,1); stem(n,y1,'b', 'filled');   title('$$y_1 = rect_4(n)$$','Interpreter','latex','FontSize',20);
 subplot(1,2,2); stem(n,y1_back,'b', 'filled');   title('$$y_1 = idft(Y_1,4)$$','Interpreter','latex','FontSize',20);

figure(4);     
 subplot(1,2,1); stem(n,abs(Y1),'r');      title('$$|Y_1|$$','Interpreter','latex','FontSize',20);          axis( [ 0 9 -1 5])
 subplot(1,2,2); stem(n,angle(Y1),'g');      title('$$\angle Y_1$$','Interpreter','latex','FontSize',20);   axis( [ 0 9 -3 3])

%
figure(5);
 subplot(1,2,1); stem(n,y2,'b', 'filled');   title('$$y_2 = n$$','Interpreter','latex','FontSize',20);
 subplot(1,2,2); stem(n,y2_back,'b', 'filled');   title('$$y_1 = idft(Y_2,4)$$','Interpreter','latex','FontSize',20);

figure(6);     
 subplot(1,2,1); stem(n,abs(Y2),'r');      title('$$|Y_2|$$','Interpreter','latex','FontSize',20);          
 subplot(1,2,2); stem(n,angle(Y2),'g');      title('$$\angle Y_2$$','Interpreter','latex','FontSize',20);   
 
%
figure(7);
    stem(0:length(rcr)-1, rcr, 'r'); title('$$ rect_4(n) \ast rect_4(n)$$','Interpreter','latex','FontSize',20);
 
return;