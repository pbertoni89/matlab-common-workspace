% Inizializzazione
clear all;
close all;

dt = 0.01;
t = -10:dt:10;


% ***************
% * ESERCIZIO 1 *
% ***************

x = 3.5*sin(2*pi*1/4*t);
xq = myQuant(x,2,-0.5);
figure, plot(t,xq,'Linewidth',2)
hold on, plot(t,x,'r--'), title('TEST')
pause;
close;


% ***************
% * ESERCIZIO 2 *
% ***************

x = 1/2*t.^3+5*t.^2+20-2*(t+10).^2;


% Punti 1 e 2

for bits = [2 4 8 16]
    xq = myQuant(x,bits,0);
    figure, plot(t,xq,'Linewidth',2)
    hold on, plot(t,x,'r--'), title(sprintf('%d bits, shift=0',bits))
    
    errq = x-xq;
    fprintf('Energia dell''errore di quantizzazione con %d bits: %.4f\n',...
        bits,integrale(errq.^2,dt));
    binEdges = linspace(-(max(x)-min(x))/2^(bits+1),(max(x)-min(x))/2^(bits+1),20);
    dx = binEdges(2)-binEdges(1);
    h_e = histc(errq,binEdges);
    pdf_e = h_e(1:end-1)/(dx)/length(x);
    figure, plot(binEdges(1:end-1)+dx/2,pdf_e), title(sprintf('pfd caso %d bits, shift=0',bits))
end
pause;
close all;


% Punto 3

fprintf('\n************\n\n');

shift = -1:.1:1;
for s = shift
    xq = myQuant(x,16,s);
    errq = x-xq;
    fprintf('Energia dell''errore di quantizzazione con 16 bits e shift %.2f: %.8f\n',...
        s,integrale(errq.^2,dt));
end


% Punto 4

fprintf('\n************\n\n');

for s = shift
    xq = myQuant(x,2,s);
    errq = x-xq;
    fprintf('Energia dell''errore di quantizzazione con 2 bits e shift %.2f: %.1f\n',...
        s,integrale(errq.^2,dt));
end