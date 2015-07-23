clear all
close all


% ***************
% * ESERCIZIO 1 *
% ***************

% Per Matlab ver >=7.4
rand('twister',sum(100*clock));

% Per Matlab ver <7.4
%rand('state',sum(100*clock))

% Numero campioni
nCamp = 100000;


% Punto 1

U = rand(nCamp,1);


% Punto 2

U1 = 3*U;


% Punto 3

U2 = 3+2*U;


% Punto 4

U3 = (U<=1/2).*(4*U-1) - 2*(U>1/2&U<=3/4) + 2*(U>3/4);
% U3 = zeros(nCamp,1);
% for u = 1:nCamp
%     if U(u)<=1/2
%         U3(u) = 4*U(u)-1;
%     elseif U(u)>1/2 && U(u)<=3/4
%         U3(u) = -2;
%     else
%         U3(u) = 2;
%     end
% end


% Punto 5

% analitico

Z = (U<=1/2).*(sqrt(2*U)-1) + (U>1/2).*(1-sqrt(2-2*U));
% Z = zeros(nCamp,1);
% for u = 1:10000
%     if U(u)<=0.5
%         Z(u) = sqrt(2*U(u))-1;
%     else
%         Z(u) = 1-sqrt(2-2*U(u));
%     end
% end

% numerico - questo funziona con qualunque pdf

% Z = zeros(nCamp,1);
% dalpha = .001;
% alpha = -10:dalpha:10;
% f_Z = tri(alpha);
% %f_Z = 3/2*tri(alpha).^2;
% %f_Z = abs(sin(alpha)); f_Z = f_Z/sum(f_Z*dalpha);
% F_Z = zeros(size(alpha));
% for i = 2:length(alpha)
%     F_Z(i) = F_Z(i-1)+f_Z(i)*dalpha;   % sommatoria integrale
% end
% % F_Z clipping
% zeroIndex = sum(F_Z==0);
% oneIndex = sum(F_Z==F_Z(end));
% F_Zclip = F_Z(zeroIndex:end-oneIndex+1);
% alphaClip = alpha(zeroIndex:end-oneIndex+1);
% for u = 1:nCamp
%     yIndex = abs(F_Zclip-U(u))==min(abs(F_Zclip-U(u)));
%     Z(u) = alphaClip(yIndex);
% end

% plots
myHist1D(U), title('U unif. in [0,1]')
myHist1D(U1), title('U1 unif. in [0,3]')
myHist1D(U2), title('U2 unif. in [3,5]')
myHist1D(U3), title('U3 con pdf = 1/2*(rect(x/2) + 1/4*delta(x-2) + 1/4*delta(x+2))')
myHist1D(Z), title('Z con pdf = tri(x)')
pause;
close all;


% ***************
% * ESERCIZIO 2 *
% ***************


% Punto 1

U1 = rand(nCamp,1); % per generazione X
U2 = rand(nCamp,1); % per generazione Y
%X = 2* (U1 .^ (1/4));
X = 2* (U1).^(1/3);
Y = (X /2) .* U2.^(1/2);

% plot 2D
myHist2D(X,Y);
title('pdf congiunta di X e Y'),

% marginali
myHist1D(X), title('pdf di X')
myHist1D(Y), title('pdf di Y')


% Punto 2

fprintf('La media campionaria di X vale %f; la media statistica E[X] vale %f.\n',mean(X),8/5);
fprintf('La media campionaria di Y vale %f; la media statistica E[Y] vale %f.\n',mean(Y),8/15);
fprintf('La correlazione campionaria tra X e Y vale %f; la correlazione E[XY] vale %f.\n',mean(X.*Y),8/9);
fprintf('La varianza campionaria di X vale %f; la varianza statistica E[(X-E[X])^2] vale %f.\n',var(X),8/75);
fprintf('La varianza campionaria di Y vale %f; la varianza statistica E[(Y-E[X])^2] vale %f.\n',var(Y),11/225);
pause;
close all;


% ***************
% * ESERCIZIO 3 *
% ***************

A = 2;

dt = 0.01;
t = -10:dt:10;
nReal = 10000;


% Punto 1

phi = rand(nReal,1)*2*pi;
procSinFaseCasuale = zeros(nReal,length(t));

for j = 1:nReal
    procSinFaseCasuale(j,:) = A*sin(pi*t/2+phi(j));
end


% Punto 2

tSample = [-4.2 0 3];

X = zeros(nReal,length(tSample));
for i = 1:length(tSample)
    X(:,i) = procSinFaseCasuale(:,t==tSample(i));
    str = sprintf('PDF del processo SINUSOIDE A FASE CASUALE in t=%fs',tSample(i));
    myHist1D(X(:,i)), title(str)
    fprintf('La media del processo SINUSOIDE A FASE CASUALE in t=%f vale: %f\n',tSample(i),mean(X(:,i)));
end


% Punto 3

Rx = zeros(length(tSample),length(t));
for i = 1:length(tSample)
    Rx(i,:) = mean(repmat(procSinFaseCasuale(:,t==tSample(i)),[1 length(t)]).*procSinFaseCasuale);
    str = sprintf('Autocorrelazione del processo SINUSOIDE A FASE CASUALE (funzione di t'') centrato in t=%fs',tSample(i));
    figure, plot(t-tSample(i),Rx(i,:)), title(str)
end
pause;
close all;


% ***************
% * ESERCIZIO 4 *
% ***************


% Punto 1

procQuadra = zeros(nReal,length(t));


% Caso 1
%fase = zeros(nReal,1);

% Caso 2
%fase = rand(nReal,1)*2;

% Caso 3
fase = rand(nReal,1);

fprintf('PROGRESSION...\n')
for j = 1:nReal
    if mod(j,1000) == 0
        fprintf('j=%d\n',j);
    end
    for k = -6:6
        procQuadra(j,:) = procQuadra(j,:)+(2*A*rand-A)*rect(t-2*k-fase(j));
    end
end


% Punto 2

Y = zeros(nReal,length(tSample));
for i = 1:length(tSample)
    Y(:,i) = procQuadra(:,t==tSample(i));
    str = sprintf('PDF del processo ONDA QUADRA BIPOLARE RZ in t=%fs',tSample(i));
    myHist1D(Y(:,i)), title(str)
    
    fprintf('La media del processo ONDA QUADRA BIPOLARE RZ in t=%f vale: %f\n',tSample(i),mean(Y(:,i)));
end


% Punto 3

Ry = zeros(length(tSample),length(t));
for i = 1:length(tSample)
    Ry(i,:) = mean(repmat(procQuadra(:,t==tSample(i)),[1 length(t)]).*procQuadra);
    str = sprintf('Autocorrelazione del processo ONDA QUADRA BIPOLARE RZ (funzione di t'') centrato in t=%fs',tSample(i));
    figure, plot(t-tSample(i),Ry(i,:)), title(str)
end
pause;
close all;


% ***************
% * ESERCIZIO 5 *
% ***************


% Punto 1

procZ = randn(nReal,length(t));


% Punto 2

Z = zeros(nReal,length(tSample));
for i = 1:length(tSample)
    Z(:,i) = procZ(:,t==tSample(i));
    str = sprintf('PDF del processo RUMORE BIANCO PDF UNIFORME in t=%fs',tSample(i));
    myHist1D(Z(:,i)), title(str)
    fprintf('La media del processo RUMORE BIANCO PDF UNIFORME in t=%f vale: %f\n',tSample(i),mean(Z(:,i)));
end


% Punto 3

Rz = zeros(length(tSample),length(t));
for i = 1:length(tSample)
    Rz(i,:) = mean(repmat(procZ(:,t==tSample(i)),[1 length(t)]).*procZ);
    str = sprintf('Autocorrelazione del processo RUMORE BIANCO PDF UNIFORME (funzione di t'') centrato in t=%fs',tSample(i));
    figure, plot(t-tSample(i),Rz(i,:)), title(str)
end
pause;
close all;