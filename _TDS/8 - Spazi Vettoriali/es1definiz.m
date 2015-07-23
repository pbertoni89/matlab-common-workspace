
which es1definiz;

clear; clc; close all;

dt=.01; df=dt;
t= -10:dt:10;
f= -10:df:10;

x1= 3*my_rect(t);    y1= my_tri(t);

x2= y1;              y2= my_tri(t-1);

x3= 2*my_sinc(t);    y3= 1i*y1;


fprintf('***************************************************************\n Esercizio 1: Distanza, norma, prodotto scalare\n\n');


%% i

fprintf(' x(t)= 3.rect(t)    y(t)= tri(t) \n');

fprintf('NORMA: ovvero square root dell energia \n');
fprintf(' norma(x)= %f = %f = %f \n', normaL2tipo1(x1,t), normaL2tipo2(x1,t), normaL2tipo3(x1,t) );
fprintf(' norma(y)= %f = %f = %f \n', normaL2tipo1(y1,t), normaL2tipo2(y1,t), normaL2tipo3(y1,t) );

fprintf('DISTANZA: ovvero square root dell energia del segnale errore\n');
fprintf(' distanza(x,y)= %f = %f \n', distanzaL2tipo1(x1,y1,t), distanzaL2tipo2(x1,y1,t) );

fprintf('PRODOTTO SCALARE: ovvero verosimiglianza tra i segnali\n');
fprintf(' prodscalare(x,y)= %f \n', prodscalare_tipo1(x1,y1,t) );

fprintf('DISUGUAGLIANZA DI SCHWARTZ: ovvero |prodscalare(x,y)| <= norma(x) * norma(y)\n');
fprintf('in effetti %f <= %f \n\n', abs( prodscalare_tipo1(x1,y1,t) ), normaL2tipo1(x1,t)*normaL2tipo1(y1,t) );

pause;

%% ii

fprintf(' x(t)= tri(t)    y(t)= tri(t-1) \n ');

fprintf('NORMA: ovvero square root dell energia \n');
fprintf(' norma(x)= %f = %f = %f\n', normaL2tipo1(x2,t), normaL2tipo2(x2,t), normaL2tipo3(x2,t) );
fprintf(' norma(y)= %f = %f = %f \n', normaL2tipo1(y2,t), normaL2tipo2(y2,t), normaL2tipo3(y2,t) );

fprintf('DISTANZA: ovvero square root dell energia del segnale errore \n');
fprintf(' distanza(x,y)= %f = %f \n', distanzaL2tipo1(x2,y2,t), distanzaL2tipo2(x2,y2,t) );

fprintf('PRODOTTO SCALARE: ovvero verosimiglianza tra i segnali \n');
fprintf(' prodscalare(x,y)= %f \n ', prodscalare_tipo1(x2,y2,t) );

fprintf('DISUGUAGLIANZA DI SCHWARTZ: ovvero |prodscalare(x,y)| <= norma(x) * norma(y) \n');
fprintf('in effetti %f <= %f \n\n', abs( prodscalare_tipo1(x2,y2,t) ), normaL2tipo1(x2,t)*normaL2tipo1(y2,t) );

pause;


%% iii
fprintf(' x(t)= 2.sinc(t)    y(t)= j.tri(t) \n ');

fprintf('NORMA: ovvero square root dell energia \n');
fprintf(' norma(x)= %f = %f = %f \n', normaL2tipo1(x3,t), normaL2tipo2(x3,t), normaL2tipo3(x3,t) );
fprintf(' norma(y)= %f = %f = %f\n', normaL2tipo1(y3,t), normaL2tipo2(y3,t), normaL2tipo3(y3,t) );

fprintf('DISTANZA: ovvero square root dell energia del segnale errore \n');
fprintf(' distanza(x,y)= %f = %f \n', distanzaL2tipo1(x3,y3,t), distanzaL2tipo2(x3,y3,t) );

fprintf('PRODOTTO SCALARE: ovvero verosimiglianza tra i segnali \n');
fprintf(' prodscalare(x,y)= %f \n ', prodscalare_tipo1(x3,y3,t) );

fprintf('DISUGUAGLIANZA DI SCHWARTZ: ovvero |prodscalare(x,y)| <= norma(x) * norma(y) \n');
fprintf('in effetti %f <= %f \n\n', abs( prodscalare_tipo1(x3,y3,t) ), normaL2tipo1(x3,t)*normaL2tipo1(y3,t) );

return;