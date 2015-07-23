clear all;
close all;

% Asse temporale
dt = 0.01;
t = -10:dt:10;

% Segnale da approssimare
x = 10*sin(t).*(1+sqrt(abs(t)));
%x = 10*sin(2*pi*t).*(1+sqrt(abs(t)));

% Lista colori per plots
colors = {'b' 'g' 'r' 'c' 'm' 'y' 'k'...
    'b--' 'g--' 'r--' 'c--' 'm--' 'y--' 'k--'...
    'b:' 'g:' 'r:' 'c:' 'm:' 'y:' 'k:'};


% ***************
% * ESERCIZIO 3 *
% ***************


%% Punto 1

B1 = zeros(20,length(t));
for k = 1:20
    B1(k,:) = rect(t-k+21/2);
    figure(1), plot(t,B1(k,:),colors{k}), hold on
end
title('Base di rect')


%% Punto 2

G1 = zeros(20,20);
for k = 1:20
    for h = 1:20
        G1(k,h) = integrale(B1(k,:).*conj(B1(h,:)),dt);
    end
end
fprintf('G1:\n');
disp(G1)


%% Punto 3 e 4

Appr_x = zeros(size(t));
alpha1 = zeros(20,1);
for k = 1:20
    alpha1(k) = integrale(x.*conj(B1(k,:)),dt);
    Appr_x = Appr_x + alpha1(k)*B1(k,:);
end
figure(2), plot(t,x,'r','LineWidth',2), hold on
plot(t,Appr_x), title('$$x\ \mbox{e}\ \hat{x}$$','Interpreter','latex');
fprintf('\nEnergia dell''errore di approssimazione per la base di rect: %2.3f\n',...
    integrale((abs(x-Appr_x)).^2,dt));


%% Punto 5

B2 = zeros(21,length(t));
for k = 1:21
    B2(k,:) = tri(t-k+11);
    figure(3), plot(t,B2(k,:),colors{k}), hold on
end
title('Base di tri')

G2 = zeros(21,21);
for k = 1:21
    for h = 1:21
        G2(k,h) = integrale(B2(k,:).*conj(B2(h,:)),dt);
    end
end
fprintf('G2:\n');
disp(G2)

Appr_x2 = zeros(size(t));
theta2 = zeros(21,1);
for k = 1:21
    theta2(k) = integrale(x.*conj(B2(k,:)),dt);
end
alpha2 = inv(G2)*theta2;
for k = 1:21
    Appr_x2 = Appr_x2 + alpha2(k)*B2(k,:);
end
figure(4), plot(t,x,'r','LineWidth',2), hold on
plot(t,Appr_x2), title('$$x\ \mbox{e}\ \hat{x}_2$$','Interpreter','latex');
fprintf('\nEnergia dell''errore di approssimazione per la base di tri: %2.3f\n',...
    integrale((abs(x-Appr_x2)).^2,dt))


%% Punto 6

B2ort = zeros(21,length(t));
B2ort(1,:) = B2(1,:)/sqrt(integrale((abs(B2(1,:))).^2,dt));
figure(5), plot(t,B2ort(1,:),colors{1}), hold on
for k = 2:21
    v = B2(k,:);
    for r = 1:k-1
        v = v-integrale(v.*conj(B2ort(r,:)),dt).*B2ort(r,:);
    end
    B2ort(k,:) = v/sqrt(integrale((abs(v)).^2,dt));
    figure(5), plot(t,B2ort(k,:),colors{k}), hold on
end
title('Base di tri ortogonalizzata')


G2ort = zeros(21,21);
for k = 1:21
    for h = 1:21
        G2ort(k,h) = integrale(B2ort(k,:).*conj(B2ort(h,:)),dt);
    end
end
fprintf('G2ort:\n');
disp(G2ort)

Appr_x3 = zeros(size(t));
alpha3 = zeros(21,1);
for k = 1:21
    alpha3(k) = integrale(x.*conj(B2ort(k,:)),dt);
    Appr_x3 = Appr_x3 + alpha3(k)*B2ort(k,:);
end
figure(6), plot(t,x,'r','LineWidth',2), hold on
plot(t,Appr_x3), title('$$x\ \mbox{e}\ \hat{x}_3$$','Interpreter','latex');
fprintf('\nEnergia dell''errore di approssimazione per la base di tri ortogonalizzata: %2.3f\n',...
    integrale((abs(x-Appr_x3)).^2,dt))

%% Punto 7

gamma = conj(inv(G2));
B2biort = zeros(21,length(t));
for l = 1:21
    for j = 1:21
        B2biort(l,:) = B2biort(l,:)+B2(j,:)*gamma(j,l);
    end
    figure(7), plot(t,B2biort(l,:),colors{l}), hold on
end

G2biort = zeros(21,21);
for k = 1:21
    for h = 1:21
        G2biort(k,h) = integrale(B2biort(k,:).*conj(B2biort(h,:)),dt);
    end
end
fprintf('G2biort:\n');
disp(G2biort)

Appr_x4 = zeros(size(t));
theta4 = zeros(21,1);
for k = 1:21
    theta4(k) = integrale(x.*conj(B2biort(k,:)),dt);

end
alpha4 = inv(G2biort)*theta4;
for k = 1:21
    Appr_x4 = Appr_x4 + alpha4(k)*B2biort(k,:);
end
figure(8), plot(t,x,'r','LineWidth',2), hold on
plot(t,Appr_x4), title('$$x\ \mbox{e}\ \hat{x}_4$$','Interpreter','latex');
fprintf('\nEnergia dell''errore di approssimazione per la base biortogonale a quella di tri: %2.3f\n',...
    integrale((abs(x-Appr_x4)).^2,dt));

pause;
return;