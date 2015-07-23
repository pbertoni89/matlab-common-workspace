% Lezione 10 - Es. 1

A = 2;
dt = 0.01;
t = -10:dt:10;
nReal = 10000;

% (i)
matrice = zeros(nReal, length(t));
for k = 1:nReal
    theta = rand(1) .* (2*pi);
    matrice(k,:) = A .* sin(t .* 2*(pi/4) + theta);
end

plot(t, matrice(1,:)); grid on; pause;
plot(t, matrice(2,:)), grid on; pause;
plot(t, matrice(3,:)), grid on; pause;
%close;


% (ii)
istanti = [-4.2, 0, 3];
for k = 1:length(istanti)
    ist = istanti(k);
    indice = (ist + 10) / dt;
    X = matrice(:, indice);
    fprintf('La media di X%d vale: %f\n', k, mean(X));
    % ************ CALCOLO DELLA PDF **********************************
    % NB hist non mi da la pdf, perche' non e' normalizzata!
    % NB: guardarsi magari lo snippet pdf.m
    % Ri-nota: vanno bene entrambi i modi, l'area sottesa e' ancora 1.
    [distribuzione, z] = hist(X, 100);
    dz = z(2) - z(1);
    area = sum(distribuzione);
    pdf = distribuzione / (area * dz);
    fprintf('Area pdf: %f\n', sum(pdf) * dz );
    bar(z, pdf);pause;
end
%close;

% abbiamo bisogno del 2° ordine
% fissiamo uno dei 2 tempi (t1: -4.2)
% prendiamo quella colonna
% La moltiplichiamo per tutte le altre colonne della matrice, e ne calcolo
% la media
% COLONNA PER COLONNA
% E ne facciamo la media dall'alto al basso, ottengo un asse dei tempi
% (iii)
for k = 1:length(istanti)
    ist = istanti(k);
    indice = (ist + 10) / dt;
    X1 = matrice(:, indice);
    matrice_prodotto = zeros(size(matrice));
    for l = 1:length(t)
        col = X1 .* matrice(:, l);
        matrice_prodotto(:, l) = col;
    end
    % Rx(t1, t2) = E[X(t1) * X(t2)]
    Rx = mean(matrice_prodotto, 1);
    % Dipende dal delta T, ovvero t2 - t1, non da T
    plot(t - ist, Rx); xlim([-10 10]);grid on; pause;
end
close;