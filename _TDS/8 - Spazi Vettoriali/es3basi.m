clear all; close all; clc;

dt=.01; df=dt;
t= -10:dt:10;

colors = {'b' 'g' 'r' 'c' 'm' 'y' 'k' 'b--' 'g--' 'r--' 'c--' 'm--' 'y--' 'k--' 'b:' 'g:' 'r:' 'c:' 'm:' 'y:' 'k:'};

x= 10*sin(   1*t).*(1+sqrt( abs(t) ) );

%x= 10*sin(2*pi*t).*(1+sqrt( abs(t) ) );

% si motivi la pessima proiezione di sin(2pi.t) su entrambe le basi.
% nel periodo base [0,2] ma come in tutti gli altri io ho o rect o tri, che
% sono funzioni pari. Se la sinusoide è a pulsazione 2pi, il suo periodo
% diventa proprio [0,2] e la mia proiezione è l'integrale di una funzione
% PARI PER UNA DISPARI... il prodotto è nullo!
% invece con sin(pi.t) io ho comunque un'approssimazione mediocre

%%  i)   ii)   iii)

base_rect = zeros(20, length(t) );
I_rect= zeros(20,20);
proiez_rect= zeros(20, length(t) );
approx_rect= zeros( 1, length(t) );

for k = 1:20
    base_rect(k,:) = my_rect(t -k +21/2);
end

for i= 1:20
    for j= 1:20
        I_rect(i,j)= prodscalare_tipo1( base_rect(i,:), base_rect(j,:), t);
    end
end

for k = 1:20
    proiez_rect(k,:) = prodscalare_tipo1( x, base_rect(k,:), t);
    approx_rect= approx_rect+  proiez_rect(k,:) .* base_rect(k,:) ;
end     

%%    iv)

base_tri = zeros(21, length(t) );  % base non ortogonale!!
proiez_tri= base_tri;
approx_tri= zeros( 1, length(t) );
I_tri= zeros(21,21);

for k = 1:21
    base_tri(k,:) = my_tri(t -k +11);
end

% trovare il vettore proiez_tri tc SOMMATORIA( base2_di_k * beta_di_k ) minimizzi l'errore

for k = 1:21
    proiez_tri(k,:) = prodscalare_tipo1( base_tri(k,:), x, t);
end

for i= 1:21
    for j= 1:21
        I_tri(i,j)= prodscalare_tipo1( base_tri(i,:), base_tri(j,:), t);
    end
end

proiez_tri = I_tri \ proiez_tri;  % equivalente a inv(I_tri) * proiez_tri

for k = 1:21
    approx_tri= approx_tri+  proiez_tri(k,:) .* base_tri(k,:) ;
end     

%% Graham Schmidt    v)

 base_tri_orto = zeros(21, length(t) );
 precedenti= zeros(1, length(t) );
 proiez_tri_orto= zeros(20, length(t) );
 approx_tri_orto= zeros( 1, length(t) );
 
 % primo vettore
 base_tri_orto(1,:)= base_tri(1,:)/normaL2tipo1( base_tri(1,:), t);
 
 for k= 2:21
     
     for r=1:k-1
        precedenti= precedenti + prodscalare_tipo1( base_tri(k,:), base_tri_orto(r,:), t) .* base_tri_orto(r,:);
     end
     
     base_tri_orto(k,:)= base_tri(k,:) - precedenti;
     
     base_tri_orto(k,:)= base_tri_orto(k,:)/normaL2tipo1( base_tri_orto(k,:), t);
 end
 %ho ortogonalizzato
 
for k = 1:21
    proiez_tri_orto(k,:) = prodscalare_tipo1( x , base_tri_orto(k,:), t);
    approx_tri_orto = approx_tri_orto +  proiez_tri_orto(k,:) .* base_tri_orto(k,:) ;
end     

%%    vi)

base_tri_bio= zeros( 21, length(t) );
temp = conj(inv(I_tri));
I_tri_bio= zeros(21,21);  % matrice che deve risultare identica.
approx_tri_bio = zeros(size(t));
proiez_tri_bio = zeros(21,1);

for i = 1:21
    for j = 1:21
        base_tri_bio(i,:) = base_tri_bio(i,:) + base_tri(j,:) * temp(j,i);
    end
end

for i = 1:21
    for j = 1:21
        I_tri_bio(i,j)= prodscalare_tipo1( base_tri_bio(i,:), base_tri_bio(j,:), t);
    end
end

% fprintf('Matrice identica:\n');
% disp(I_tri_bio)

for k = 1:21
    proiez_tri_bio(k) = prodscalare_tipo1(x, base_tri_bio(k,:) , t);
end

proiez_tri_bio =  I_tri_bio \ proiez_tri_bio;

for k = 1:21
    approx_tri_bio = approx_tri_bio + proiez_tri_bio(k) * base_tri_bio(k,:);
end


%% STAMPE E GRAFICI

plot(t, x, 'r'); title('10.sin(t).(1+sqrt(|x|))');

%
figure('name','Approssimazione ai minimi quadrati: basi utilizzate');

subplot(2,2,1);  
for k = 1:20
   plot(t, base_rect(k,:),colors{k}), hold on; title('base di rect ortogonale');
end

subplot(2,2,2);  
for k = 1:21
   plot(t, base_tri(k,:),colors{k}), hold on; title('base di tri non ortogonale');
end

subplot(2,2,3);  
for k = 1:21
   plot(t, base_tri_orto(k,:),colors{k}), hold on; title('base di tri ortogonalizzata');
end

subplot(2,2,4); 
for k = 1:21
   plot(t, base_tri_bio(k,:),colors{k}), hold on;  title('base binormale alla base di tri');
end

%
figure('name','Approssimazione ai minimi quadrati: risultati');

subplot(2,2,1); plot(t, x, 'r'); title('base di rect ortogonale'); hold on; plot(t, approx_rect, 'b'); axis([-10 10 -60 60]); hold off;
subplot(2,2,2); plot(t, x, 'r'); title('base di tri non ortogonale'); hold on; plot(t, approx_tri, 'b'); axis([-10 10 -60 60]); hold off;
subplot(2,2,3); plot(t, x, 'r'); title('base di tri ortogonalizzata'); hold on; plot(t, approx_tri_orto, 'b'); axis([-10 10 -60 60]); hold off;
subplot(2,2,4); plot(t, x, 'r'); title('base binormale a base tri'); hold on; plot(t, approx_tri_bio, 'b'); axis([-10 10 -60 60]); hold off;

%
fprintf('L energia dell errore di approssimazione è il quadrato della distanza tra i due segnali.\n\n');
fprintf('Per la base di rect vale %f\n', distanzaL2tipo1( x, approx_rect, t)^2 );
fprintf('Per la base di tri vale %f\n', distanzaL2tipo1( x, approx_tri, t)^2 );
fprintf('Per la base di tri ortogonalizzata vale %f\n', distanzaL2tipo1( x, approx_tri_orto, t)^2 );
fprintf('Per la base binormale alla base di tri vale %f\n\n', distanzaL2tipo1( x, approx_tri_bio, t)^2 );

return;
