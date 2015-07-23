clear, clc, close all

% x = tau ; y = theta
% 1 = add ; 2 = swap ; 3 = remove
T = 20; Q = 50;

mu1 = [0 0];
mu2 = [T/2 Q/2];
mu3 = [T Q];

sigma_x1 = T/2;
sigma_y1 = Q/3;
 
sigma_x2 = T;
sigma_y2 = Q;

sigma_x3 = (1)*(T/2);
sigma_y3 = (1)*(Q/3); %(100)*((T/Q));

angle = 0;

%for angle = 0:pi/100:pi
    a = cos(angle)^2/2/sigma_x1^2 + sin(angle)^2/2/sigma_y1^2;
    b = -sin(2*angle)/4/sigma_x1^2 + sin(2*angle)/4/sigma_y1^2 ;
    c = sin(angle)^2/2/sigma_x1^2 + cos(angle)^2/2/sigma_y1^2;
    C1 = [a b; b c];
%end

angle = 45;
    a = cos(angle)^2/2/sigma_x2^2 + sin(angle)^2/2/sigma_y2^2;
    b = -sin(2*angle)/4/sigma_x2^2 + sin(2*angle)/4/sigma_y2^2 ;
    c = sin(angle)^2/2/sigma_x2^2 + cos(angle)^2/2/sigma_y2^2;
    C2 = [a b; b c];

angle = 0;
    a = cos(angle)^2/2/sigma_x3^2 + sin(angle)^2/2/sigma_y3^2;
    b = -sin(2*angle)/4/sigma_x3^2 + sin(2*angle)/4/sigma_y3^2 ;
    c = sin(angle)^2/2/sigma_x3^2 + cos(angle)^2/2/sigma_y3^2;
    C3 = [a b; b c];
    
tau = linspace(0,T,100) ;
theta = linspace(0,Q,100)';

[Tau,Theta] = meshgrid(tau,theta);

z1 = gauss2(Tau,Theta,mu1,C1);
z2 = gauss2(Tau,Theta,mu2,C2);
z3 = gauss2(Tau,Theta,mu3,C3);

surf(Tau,Theta,z1); hold on;
surf(Tau,Theta,z2);
surf(Tau,Theta,z3);
colormap hot
shading interp