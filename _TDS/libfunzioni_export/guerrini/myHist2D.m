function myHist2D(X,Y)

bins = 100;
[n,x1] = hist(X,bins);
[n,x2] = hist(Y,bins);
dx1 = x1(2)-x1(1);
dx2 = x2(2)-x2(1);
n2d = zeros(length(x2),length(x1));
for i = 1:length(x1)
    ind = find((X>x1(i)-dx1/2) & (X<=x1(i)+dx1/2));
    n2d(1:length(x2),i) = hist(Y(ind),x2);
end
pdf = n2d./(sum(sum(n2d))*dx1*dx2);
figure, imagesc(x1,x2,pdf), colorbar, set(gca,'YDir','normal')