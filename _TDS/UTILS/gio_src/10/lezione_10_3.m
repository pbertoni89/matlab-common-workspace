% Lezione 10 - Es. 3

dt = 0.01;
t = -10:dt:10;
nReal = 10000;

% (i)
matrice = rand(nReal, length(t));

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
    [distribuzione, z] = hist(X, 100);
    dz = z(2) - z(1);
    area = sum(distribuzione);
    bar(z, distribuzione / (area * dz));pause;
end
%close;

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
    plot(t - ist, Rx); xlim([-10 10]);grid on; pause;
end
close;