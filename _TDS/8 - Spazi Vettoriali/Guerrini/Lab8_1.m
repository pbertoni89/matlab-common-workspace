clear all;
close all;

% Asse temporale
dt = 0.01;
t = -10:dt:10;


% ***************
% * ESERCIZIO 1 *
% ***************


%% Punto 1

fprintf('\n*** Punto 1 ***\n\n');

x1 = 3*rect(t); y1 = tri(t);

nx1 = myNorm(x1,dt); ny1 = myNorm(y1,dt);
psx1y1 = myScalarProduct(x1,y1,dt); psy1x1 = myScalarProduct(y1,x1,dt);
dx1y1 = myDistance(x1,y1,dt);

fprintf('La norma di x1 vale: %.3f\nLa norma di y1 vale: %.3f\n',nx1,ny1);
fprintf('Il prodotto scalare di x1 con y1 vale: %.3f%+.3fi\n',real(psx1y1),imag(psx1y1));
fprintf('Il prodotto scalare di y1 con x1 vale: %.3f%+.3fi\n',real(psy1x1),imag(psx1y1));
fprintf('La distanza tra x1 e y1 vale: %.3f\n',dx1y1);
fprintf('d^2 = n1^2+n2^2-2Re{ps}: %.3f=%.3f+%.3f-%.3f=%.3f\n',...
    dx1y1^2,nx1^2,ny1^2,2*real(psx1y1),nx1^2+ny1^2-2*real(psx1y1));
fprintf('Dis. Schwarz, |ps|&lt;=n1*n2: %.3f&lt;=%.3f*%.3f=%.3f\n',...
    abs(psx1y1),nx1,ny1,nx1*ny1);


%% Punto 2

fprintf('\n*** Punto 2 ***\n\n');

x2 = tri(t); y2 = tri(t-1);

nx2 = myNorm(x2,dt); ny2 = myNorm(y2,dt);
psx2y2 = myScalarProduct(x2,y2,dt); psy2x2 = myScalarProduct(y2,x2,dt);
dx2y2 = myDistance(x2,y2,dt);

fprintf('La norma di x2 vale: %.3f\nLa norma di y2 vale: %.3f\n',nx2,ny2);
fprintf('Il prodotto scalare di x2 con y2 vale: %.3f%+.3fi\n',real(psx2y2),imag(psx2y2));
fprintf('Il prodotto scalare di y2 con x2 vale: %.3f%+.3fi\n',real(psy2x2),imag(psx2y2));
fprintf('La distanza tra x2 e y2 vale: %.3f\n',dx2y2);
fprintf('d^2 = n1^2+n2^2-2Re{ps}: %.3f=%.3f+%.3f-%.3f=%.3f\n',...
    dx2y2^2,nx2^2,ny2^2,2*real(psx2y2),nx2^2+ny2^2-2*real(psx2y2));
fprintf('Dis. Schwarz, |ps|&lt;=n1*n2: %.3f&lt;=%.3f*%.3f=%.3f\n',...
    abs(psx2y2),nx2,ny2,nx2*ny2);


%% Punto 3

fprintf('\n*** Punto 3 ***\n\n');

x3 = 2*mysinc(t); y3 = 1j*tri(t);

nx3 = myNorm(x3,dt); ny3 = myNorm(y3,dt);
psx3y3 = myScalarProduct(x3,y3,dt); psy3x3 = myScalarProduct(y3,x3,dt);
dx3y3 = myDistance(x3,y3,dt);

fprintf('La norma di x3 vale: %.3f\nLa norma di y3 vale: %.3f\n',nx3,ny3);
fprintf('Il prodotto scalare di x3 con y3 vale: %.3f%+.3fi\n',real(psx3y3),imag(psx3y3));
fprintf('Il prodotto scalare di y3 con x3 vale: %.3f%+.3fi\n',real(psy3x3),imag(psx3y3));
fprintf('La distanza tra x3 e y3 vale: %.3f\n',dx3y3);
fprintf('d^2 = n1^2+n2^2-2Re{ps}: %.3f=%.3f+%.3f-%.3f=%.3f\n',...
    dx3y3^2,nx3^2,ny3^2,2*real(psx3y3),nx3^2+ny3^2-2*real(psx3y3));
fprintf('Dis. Schwarz, |ps|&lt;=n1*n2: %.3f&lt;=%.3f*%.3f=%.3f\n',...
    abs(psx3y3),nx3,ny3,nx3*ny3);

% 
% % *********************************
% % * ESERCIZIO 1 - versione inline *
% % *********************************
% 
% 
% % Funzioni
% f = {inline('3*rect(t)') inline('tri(t)');...
%      inline('tri(t)') inline('tri(t-1)');...
%      inline('2*mysinc(t)') inline('1j*tri(t)')};
% 
% for punto = 1:size(f,1)
% 
%     x = f{punto,1}(t); y = f{punto,2}(t);
% 
%     n1 = myNorm(x,dt); n2 = myNorm(y,dt);
%     ps1 = myScalarProduct(x,y,dt); ps2 = myScalarProduct(y,x,dt);
%     d = myDistance(x,y,dt);
% 
%     fprintf('\n*** Punto %d ***\n\n',punto);
%     fprintf('La norma di x vale: %.3f\nLa norma di y vale: %.3f\n',n1,n2);
%     fprintf('Il prodotto scalare di x con y vale: %.3f%+.3fi\n',real(ps1),imag(ps1));
%     fprintf('Il prodotto scalare di y con x vale: %.3f%+.3fi\n',real(ps2),imag(ps2));
%     fprintf('La distanza tra x e y vale: %.3f\n',d);
%     fprintf('d^2 = n1^2+n2^2-2Re{ps}: %.3f=%.3f+%.3f-%.3f=%.3f\n',...
%         d^2,n1^2,n2^2,2*real(ps1),n1^2+n2^2-2*real(ps1));
%     fprintf('Dis. Schwarz, |ps1|&lt;=n1*n2: %.3f&lt;=%.3f*%.3f=%.3f\n',...
%         abs(ps1),n1,n2,n1*n2);
% end
% 

pause;
return;