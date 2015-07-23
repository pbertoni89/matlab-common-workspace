% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 

% esercizio 2a: convoluzione lineare
%

clear; clc; close all;

%n_x = -30:30;
%n_y = -20:20;
n_x = -7:8;
n_y = -11:26;

Dx = 3; %durata
Ox = 2; %offset
x = rectN(n_x, Dx);
x = my_shift(x, n_x, Ox);

Dy = 2; %durata
Oy = 4; %offset
y = rectN(n_y, Dy);
y = my_shift(y, n_y, Oy);

w = my_conv_handler(x, y, n_x, n_y);

figure('name', 'Convoluzione lineare di prova');

    subplot(1,3,1); stem( n_x,    x,      'y', 'filled'); title('$$x$$','Interpreter','latex','FontSize',20); %axis( [-9 9 -.2 4] )
    subplot(1,3,2); stem( n_y,    y,      'g', 'filled'); title('$$y$$','Interpreter','latex','FontSize',20); %axis( [-11 11 -.2 4] )
    subplot(1,3,3); stem( w(2,:), w(1,:), 'r', 'filled'); title('$$x \ast y$$','Interpreter','latex','FontSize',20); %axis( [-20 20 -.2 4] )


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

    x1 = rectN(n_x, 5);
    x1 = my_shift( x1, n_x, 3 );
    
    y1 = rectN(n_y, 7);
    y1 = my_shift( y1, n_y, -1 );

    w1 = my_conv_handler(x1, y1, n_x, n_y); 
    
figure('name', 'Convoluzione suggerita numero 1');

    subplot(1,3,1); stem( n_x,    x1,      'y', 'filled'); title('$$x_1$$','Interpreter','latex','FontSize',20); %axis( [-11 11 -.2 4] )
    subplot(1,3,2); stem( n_y,    y1,      'g', 'filled'); title('$$y_1$$','Interpreter','latex','FontSize',20); %axis( [-11 11 -.2 4] )
    subplot(1,3,3); stem( w1(2,:), w1(1,:), 'r', 'filled'); title('$$x_1 \ast y_1$$','Interpreter','latex','FontSize',20); %axis( [-20 20 -.2 4] )
    
  
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

    x2 = n_x .* step(n_x) .* rectN(n_x, 6);
    y2 = n_y .* step(n_y) .* rectN(n_y, 9);
    
    w2 = my_conv_handler(x2, y2, n_x, n_y); 
    
figure('name', 'Convoluzione suggerita numero 2');

    subplot(1,3,1); stem( n_x,    x2,      'y', 'filled'); title('$$x_2$$','Interpreter','latex','FontSize',20); %axis( [-11 11 -.2 4] )
    subplot(1,3,2); stem( n_y,    y2,      'g', 'filled'); title('$$y_2$$','Interpreter','latex','FontSize',20); %axis( [-11 11 -.2 4] )
    subplot(1,3,3); stem( w2(2,:), w2(1,:), 'r', 'filled'); title('$$x_2 \ast y_2$$','Interpreter','latex','FontSize',20); %axis( [-20 20 -.2 4] )
    
    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

    x3 = (.25).^ n_x .* step(n_x);
    y3 = my_shift( impulso(n_y), n_y, -1) +  my_shift( impulso(n_y), n_y, 1);
    
    w3 = my_conv_handler(x3, y3, n_x, n_y); 
    
figure('name', 'Convoluzione suggerita numero 3');

    subplot(1,3,1); stem( n_x,    x3,      'y', 'filled'); title('$$x_3$$','Interpreter','latex','FontSize',20); %axis( [-11 11 -.2 4] )
    subplot(1,3,2); stem( n_y,    y3,      'g', 'filled'); title('$$y_3$$','Interpreter','latex','FontSize',20); %axis( [-11 11 -.2 4] )
    subplot(1,3,3); stem( w3(2,:), w3(1,:), 'r', 'filled'); title('$$x_3 \ast y_3$$','Interpreter','latex','FontSize',20); % axis( [-20 20 -.2 4] )
    
return;