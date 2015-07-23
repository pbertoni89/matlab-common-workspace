% Lezione 9 - Esercizio 2

% Distr. unif. tra 0 e 2
A1 = rand(1, 100000) .* 2;
%hist(A1, 100);

% X e Y calcolate con carta e penna

Y = sqrt(2 .* U);
%hist(Y, 100);

X = sqrt(8 .* U);
%hist(X, 100);

% HIST2D: Codice del profe
bins = 100;
[n,x1] = hist(X,bins);
[n,x2] = hist(Y,bins);
dx1 = x1(2)-x1(1);
dx2 = x2(2)-x2(1);
n2d = zeros(length(x1),length(x2));
for i = 1:length(x1)
    ind = find((X>x1(i)-dx1/2) & (X<=x1(i)+dx1/2));
    n2d(i,1:length(x2)) = hist(Y(ind),x2);
end
pdf = n2d./(sum(sum(n2d))*dx1*dx2);
h = imagesc(x1,x2,pdf); colorbar;