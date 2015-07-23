% Inizializzazione
clear all;
close all;

A = 2;
devStd = 3; % deviazione standard del rumore

dt = 0.01;
t = -10:dt:10;
nReal = 1000;
tSample = [-4.2 0 3];

% Per Matlab ver >=7.4
rand('twister',sum(100*clock));

% Per Matlab ver <7.4
%rand('state',sum(100*clock))


%%
% ***************
% * ESERCIZIO 1 *
% ***************

procZ = zeros(nReal,length(t));
t0 = rand(nReal,1)-1/2;
fprintf('PROGRESSION...\n');
for j = 1:nReal
    if mod(j,1000) == 0
        fprintf('j=%d\n',j);
    end
    for k=-10:10
        procZ(j,:) = procZ(j,:)+(2*A*rand-A)*rect(t-k-1/2-t0(j));
    end
end

procZquadr = procZ.^2;
procZdiod = procZ;
procZdiod(procZdiod<0) = 0;

dx = 0.01;
x = -2*A:dx:2*A;
binCenters = -2*A+dx/2:dx:2*A-dx/2;

Rz = zeros(length(tSample),length(t));
Rzquadr = zeros(length(tSample),length(t));
Rzdiod = zeros(length(tSample),length(t));

for i = 1:length(tSample)
    
    % PAM
    h_Z = hist(procZ(:,t==tSample(i)),binCenters);
    pdf_Z = h_Z/(dx*nReal);
    str = sprintf('PDF del processo PAM in t=%fs',tSample(i));
    figure(2+(i-1)*6), plot(binCenters,pdf_Z), axis([-2*A 2*A 0 2]), title(str)
    
    fprintf('La media del processo PAM in t=%f vale: %f\n',tSample(i),mean(procZ(:,i)));
    
    Rz(i,:) = ((procZ(:,t==tSample(i)))'*procZ)/nReal;
    str = sprintf('Autocorrelazione del processo PAM (funzione di t'') centrato in t=%fs',tSample(i));
    figure(3+(i-1)*6), plot(t-tSample(i),Rz(i,:)), title(str)
    
    % PAM + quadratore
    h_Zfilt1 = hist(procZquadr(:,t==tSample(i)),binCenters);
    pdf_Zfilt1 = h_Zfilt1/(dx*nReal);
    str = sprintf('PDF del processo PAM filtrato con il quadratore in t=%fs',tSample(i));
    figure(4+(i-1)*6), plot(binCenters,pdf_Zfilt1), axis([-2*A 2*A 0 2]), title(str)
    
    fprintf('La media del processo PAM filtrato con il quadratore in t=%f vale: %f\n',tSample(i),mean(procZquadr(:,i)));
    
    Rzquadr(i,:) = ((procZquadr(:,t==tSample(i)))'*procZquadr)/nReal;
    str = sprintf('Autocorrelazione del processo PAM filtrato con il quadratore (funzione di t'') centrato in t=%fs',tSample(i));
    figure(5+(i-1)*6), plot(t-tSample(i),Rzquadr(i,:)), title(str)
    
    % PAM + diodo
    h_Zfilt2 = hist(procZdiod(:,t==tSample(i)),binCenters);
    pdf_Zfilt2 = h_Zfilt2/(dx*nReal);
    str = sprintf('PDF del processo PAM filtrato con il diodo in t=%fs',tSample(i));
    figure(6+(i-1)*6), plot(binCenters,pdf_Zfilt2), axis([-2*A 2*A 0 2]), title(str)
    
    fprintf('La media del processo PAM filtrato con il diodo in t=%f vale: %f\n',tSample(i),mean(procZdiod(:,i)));
    
    Rzdiod(i,:) = ((procZdiod(:,t==tSample(i)))'*procZdiod)/nReal;
    str = sprintf('Autocorrelazione del processo PAM filtrato con il diodo (funzione di t'') centrato in t=%fs',tSample(i));
    figure(7+(i-1)*6), plot(t-tSample(i),Rzdiod(i,:)), title(str)
    
end

pause;
close all;

%%
% ***************
% * ESERCIZIO 2 *
% ***************

procX = devStd*randn(nReal,length(t)); % processo d'ingresso - rumore bianco guassiano
procY = zeros(nReal,length(t)); % processo d'uscita - filtrato misteriosamente
fprintf('PROGRESSION...\n');

for j = 1:nReal
    if mod(j,1000) == 0
        fprintf('j=%d\n',j);
    end
    procY(j,:) = filtroMisterioso(procX(j,:),t);
end

tExt = min(t)*2:dt:max(t)*2;
Rxy = zeros(nReal, length(t));
RxyM = zeros(1,length(tExt));

for i = 1:length(t)
    if mod(t(i),1) == 0
        fprintf('t=%.1fs\n',t(i));
    end
    Rxy(i,:) = ((procX(:,i))'*procY)/nReal; % crosscorrelazione processo ingresso-processo uscita
    RxyM(length(t)-i+1:2*length(t)-i) = RxyM(length(t)-i+1:2*length(t)-i)+Rxy(i,:); % ?
end
RxyM = RxyM/(dt*devStd^2); % normalizzazione

poszero = find(tExt==0);
for i = 1:length(tExt)
    RxyM(i) = RxyM(i)/(length(t)-abs(i-poszero)); % media su tutti gli istanti temporali
end

figure(1), plot(tExt,RxyM), title('Stima della risposta all''impulso'); % confrontare con filtroMisterioso
pause;
close all;


%%
% ***************
% * ESERCIZIO 3 *
% ***************

df = 0.01;
f = -15:df:15;

a = mysinc(t).^2;
A = T_Fourier(a,t,f);
figure, plot(t,a); title('$$a(t)$$','Interpreter','latex')
figure, plot(f,abs(A)); title('$$\vert A(f)\vert$$','Interpreter','latex')
% banda di A: B_A = 1

phi = pi/3;
fp = 7.5;
m = cos(2*pi*fp*t+phi);
M = T_Fourier(m,t,f);
figure, plot(t,m); title('$$m(t)$$','Interpreter','latex')
figure, plot(f,abs(M)); title('$$\vert M(f)\vert$$','Interpreter','latex')


am = a.*m;
AM = T_Fourier(am,t,f);
figure, plot(t,am); title('$$am(t)$$','Interpreter','latex')
figure, plot(f,abs(AM)); title('$$\vert AM(f)\vert$$','Interpreter','latex')
set(gca,'XTick',-15:15);
% banda di AM (segnale AM-Double Sideband Carrier: AM-DSB): B_AM = 2

% filtro passa-banda di banda B_AM/2 centrato in fp+B_A/2
% (tengo solo metà triangolo)
% => lo costruisco modulando un passa-basso

h_bandpass = mysinc(t).*cos(2*pi*(fp+1/2)*t);
H_bandpass = T_Fourier(h_bandpass,t,f);
figure, plot(t,h_bandpass); title('$$h_{bandpass}(t)$$','Interpreter','latex')
figure, plot(f,abs(H_bandpass)); title('$$\vert H_{bandpass}(f)\vert$$','Interpreter','latex')
set(gca,'XTick',-15:15);

% padding per am fino a t=-30:30
t1 = -30:dt:30;
am_pad = [zeros(1,(30-10)/dt) am zeros(1,(30-10)/dt)];
% filtraggio
am_SSB = myshift(filter(h_bandpass,1,am_pad)*dt,-10/dt);
AM_SSB = T_Fourier(am_SSB,t1,f);
figure, plot(t1,am_SSB); title('$$am_{SSB}(t)$$','Interpreter','latex')
figure, plot(f,AM_SSB); title('$$\vert AM_{SSB}(f)\vert$$','Interpreter','latex')
set(gca,'XTick',-15:15);

% demodulazione sincrona: rimoltiplico per m
% elimino il padding 
am_dem = am_SSB(t1>=-10 & t1<=10).*m;
AM_dem = T_Fourier(am_dem,t,f);
figure, plot(t,am_dem); title('$$am_{dem}(t)$$','Interpreter','latex')
Lab10figure, plot(f,AM_dem); title('$$\vert AM_{dem}(f)\vert$$','Interpreter','latex')
set(gca,'XTick',-15:15);