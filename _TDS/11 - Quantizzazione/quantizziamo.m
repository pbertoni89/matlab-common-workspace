clear all; close all; clc;

dt= .01;
t = -10:dt:10;
bits= 1:1:16;
colors = {'b' 'g' 'r' 'c' 'm' 'y' 'b--' 'g--' 'r--' 'c--' 'm--' 'y--' 'k--' 'b:' 'r:' 'g:'};
y_discreto = zeros(1, length(t) );
xQ = y_discreto;
errQ = y_discreto;

%% i)

y = sin(t);

figure('name','Sinusoide'); hold on; plot(t, y, 'k');

for i=1: 4 %length(bits)
    y_discreto = myQuant(y, i, 1);
    plot(t, y_discreto, colors{i});
end
hold off;


%% ii)

x = .2* t.^3 + 5* t.^2 - 2*(t+10).^2 + 20;

figure('name','Segnale Polinomiale'); hold on; plot(t, x, 'k');

% errQ = -x(t) + Q(t) ma perchè Q(t,s) è un processo stocastico ?
for i=1: length(bits)/2
    xQ = myQuant(x, i, 0);
    
    figure(i+2);
    subplot(1,2,1);
    
    plot(t, xQ,'Linewidth',2); hold on;
    plot(t,x,'r--'), title(sprintf('%d bits, shift=0', i)); hold off;
    
    errQ = x - xQ;
    fprintf('Energia dell''errore di quantizzazione con %d bits e shift 0: %.4f\n', i, integrale( errQ.^2,dt));
    
    binEdges = linspace(-(max(x)-min(x))/2^(i+1),(max(x)-min(x))/2^(i+1),20);
    dx = binEdges(2)-binEdges(1);
    hist_err = histc(errQ, binEdges);
    pdf_err = hist_err(1:end-1)/(dx)/length(x);
    
    subplot(1,2,2); plot( binEdges(1:end-1)+dx/2, pdf_err), title(sprintf('pfd caso %d bits, shift=0', i))
end

%% iii)

fprintf('*****************************************\n');
shift = -1:.1:1;
for s = shift
    xQ = myQuant(x,16,s);
    errQ = x - xQ;
    fprintf('Energia dell''errore di quantizzazione con 16 bits e shift %.2f: %.8f\n', s, integrale(errQ.^2,dt));
end

%% iv)

fprintf('*****************************************\n');
shift = -1:.1:1;
for s = shift
    xQ = myQuant(x,2,s);
    errQ = x - xQ;
    fprintf('Energia dell''errore di quantizzazione con 2 bits e shift %.2f: %.8f\n', s, integrale(errQ.^2,dt));
end
  

return;