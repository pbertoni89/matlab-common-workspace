% Data un'immagine jpeg vogliamo costruirne una versione zoomata 
% per esempio da m x n pixel a 2m x 2n pixel.
clear all; close all; clc;
zoom = 2;

% l'immagine è un array a tre dimensioni, rispettivamente:
%	ordinata 
%	ascissa
%	canale R/G/B

SCIA = imread('a_scia','png'); whos SCIA
m = size(SCIA,1); % rows, y
n = size(SCIA,2); % cols, x

R = SCIA(:,:,1);
G = SCIA(:,:,2);
B = SCIA(:,:,3);

figure(1); clf;
subplot(2,2,1); image(SCIA); title('Image');
subplot(2,2,2); image(R); title('Red');
subplot(2,2,3); image(G); title('Green');
subplot(2,2,4); image(B); title('Blue');

figure(2); image(SCIA); title('Image');
%% KROENECKER: duplico semplicemente le informazioni.
% per duplicare tutte e due le dimensioni, mi serve una 2x2 !!!
Z = ones(zoom, zoom); 
% casting double necessario: le immagini sono uint8
Kron_R = kron(double(R), Z); 
Kron_G = kron(double(G), Z); 
Kron_B = kron(double(B), Z); 
% genero la matrice che ospiterà l'immagine zoomata. 3 sono i canali
% ricordarsi il casting a uint8
SCIA_Kron = uint8( zeros(zoom*m, zoom*n, 3) );

SCIA_Kron(:,:,1) = Kron_R;
SCIA_Kron(:,:,2) = Kron_G;
SCIA_Kron(:,:,3) = Kron_B; whos SCIA_Kron

figure(3); image(SCIA_Kron); title('Kron');
imwrite(SCIA_Kron,'./lez13_interp_img/b_kron.png','PNG');
% Dal plot non sembra cambiato assolutamente nulla.
% APRIRE l'immagine con un editor esterno (come Irfanview) e si vedrà!
%% BILINEARE
x = (1:n);
y = (1:m)';  % sembra che vadan trasposte per correttezza dimensionale
h = 1/zoom;
x1 = 1:h:n;
y1 = (1:h:m)';

z_R1 = interp2(x,y,double(R),x1,y1); 
z_G1 = interp2(x,y,double(G),x1,y1); 
z_B1 = interp2(x,y,double(B),x1,y1); 

Bilin_R = uint8(z_R1);
Bilin_G = uint8(z_G1);
Bilin_B = uint8(z_B1);

SCIA_Bilin = uint8( zeros(zoom*m-1, zoom*n-1, 3)); % WRN -1, -1
SCIA_Bilin(:,:,1) = Bilin_R;
SCIA_Bilin(:,:,2) = Bilin_G;
SCIA_Bilin(:,:,3) = Bilin_B; whos SCIA_Bilin

figure(4); image(SCIA_Bilin); title('Bilin');
imwrite(SCIA_Bilin,'./lez13_interp_img/c_bilin.png','PNG');

%% SPLINE CUBICA
z_Rs = interp2(x,y,double(R),x1,y1,'spline'); 
z_Gs = interp2(x,y,double(G),x1,y1,'spline'); 
z_Bs = interp2(x,y,double(B),x1,y1,'spline'); 

Spline_R = uint8(z_R1);
Spline_G = uint8(z_G1);
Spline_B = uint8(z_B1);

SCIA_Spline = uint8( zeros(zoom*m-1, zoom*n-1, 3)); % WRN -1, -1
SCIA_Spline(:,:,1) = Spline_R;
SCIA_Spline(:,:,2) = Spline_G;
SCIA_Spline(:,:,3) = Spline_B; whos SCIA_Spline

figure(5); image(SCIA_Spline); title('Spline');
imwrite(SCIA_Spline,'./lez13_interp_img/d_spline.png','PNG');

