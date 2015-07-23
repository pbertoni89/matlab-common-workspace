clear all; close all; clc;

quota=[276 201 323 214 218 333 262 930 307 449]';
xutm=[36525 45227 57442 70737 69737 70477 83987 105737 107207 129237]';
yutm=[24498 3524 3139 7504 39479 59794 39204 53954 43104 48904]';
pioggia=[1615 1547 1565 1355 1408 1462 1112 1008 1095 869]';

%% 1: 
fprintf('pioggia funzione lineare della quota\n');
	M=[quota,ones(length(quota),1)];

theta=(M'*M)\(M')*pioggia;
pioggia_mod=theta(1)*quota+theta(2); %modello
 
pioggia_mis_norm=pioggia-mean(pioggia); % misura
pioggia_mod_norm=pioggia_mod-mean(pioggia_mod);

num=sum(pioggia_mis_norm.*pioggia_mod_norm);
den=sqrt(sum(pioggia_mis_norm.^2)*sum(pioggia_mod_norm.^2));
corr=num/den
corr1=corrcoef(pioggia,pioggia_mod)
emedio=1/length(quota)*sum(pioggia_mod-pioggia)
emedio_abs=1/length(quota)*sum(abs(pioggia_mod-pioggia))
vars=var(pioggia_mod)/var(pioggia)

figure(1); 
plot(1:length(quota),pioggia,1:length(quota),pioggia_mod,'r');
fprintf('\n------------------------------------------------------------------\n');

%% 2: 
fprintf('pioggia funzione lineare delle coordinate piane\n');
	M=[xutm yutm ones(length(xutm),1)];

theta=(M'*M)\(M')*pioggia;
pioggia_mod=theta(1)*xutm+theta(2)*yutm+theta(3);

pioggia_mis_norm=pioggia-mean(pioggia);
pioggia_mod_norm=pioggia_mod-mean(pioggia_mod);

num=sum(pioggia_mis_norm.*pioggia_mod_norm);
den=sqrt(sum(pioggia_mis_norm.^2)*sum(pioggia_mod_norm.^2));
corr=num/den
corr1=corrcoef(pioggia,pioggia_mod);
emedio=1/length(quota)*sum(pioggia_mod-pioggia)
emedio_abs=1/length(quota)*sum(abs(pioggia_mod-pioggia))
vars=var(pioggia_mod)/var(pioggia)

figure(2); 
plot(1:length(quota),pioggia,1:length(quota),pioggia_mod,'r');
fprintf('\n------------------------------------------------------------------\n');

%% 3: 
fprintf('pioggia funzione lineare di tutte le coordinate spaziali\n');
	M=[xutm yutm quota ones(length(xutm),1)];

if rank(M)<4
	disp('misure linearmente dipendenti!');
end
theta=(M'*M)\(M')*pioggia;
pioggia_mod=theta(1)*xutm+theta(2)*yutm+theta(3)*quota+theta(4);

pioggia_mis_norm=pioggia-mean(pioggia);
pioggia_mod_norm=pioggia_mod-mean(pioggia_mod);

num=sum(pioggia_mis_norm.*pioggia_mod_norm);
den=sqrt(sum(pioggia_mis_norm.^2)*sum(pioggia_mod_norm.^2));
corr=num/den
corr1=corrcoef(pioggia,pioggia_mod);
emedio=1/length(quota)*sum(pioggia_mod-pioggia)
emedio_abs=1/length(quota)*sum(abs(pioggia_mod-pioggia))
vars=var(pioggia_mod)/var(pioggia)

figure(3); 
plot(1:length(quota),pioggia,1:length(quota),pioggia_mod,'r');
fprintf('\n------------------------------------------------------------------\n');

%% 4: 
fprintf('pioggia funzione quadratica della quota\n');
M=[quota.^2 quota ones(length(xutm),1)];

theta=(M'*M)\(M')*pioggia;
pioggia_mod=theta(1)*quota.^2+theta(2)*quota+theta(3);

pioggia_mis_norm=pioggia-mean(pioggia);
pioggia_mod_norm=pioggia_mod-mean(pioggia_mod);

num=sum(pioggia_mis_norm.*pioggia_mod_norm);
den=sqrt(sum(pioggia_mis_norm.^2)*sum(pioggia_mod_norm.^2));
corr=num/den
corr1=corrcoef(pioggia,pioggia_mod);
emedio=1/length(quota)*sum(pioggia_mod-pioggia)
emedio_abs=1/length(quota)*sum(abs(pioggia_mod-pioggia))
vars=var(pioggia_mod)/var(pioggia)

figure(4); 
plot(1:length(quota),pioggia,1:length(quota),pioggia_mod,'r');
fprintf('\n------------------------------------------------------------------\n');

%% 5:
fprintf('pioggia funzione esponenziale della quota\n');
M=[quota ones(length(xutm),1)];
log_pioggia=log(pioggia);

theta=(M'*M)\(M')*log_pioggia;
%calcolo parametro iniziale, parto da parametro stimato 'theta(2)'
a=exp(theta(2));
pioggia_mod=a*exp((theta(1)*quota));
%perchè l'ordine sembra invertito? perchè logP = log(a) + b*z
% => b fa la parte del coefficiente angolare, log(a) dell'offset!

corr1=corrcoef(pioggia,pioggia_mod);
% giusto per mostrare un altro modo di ottenere correlazione
	pioggia_mis_norm=pioggia-mean(pioggia);
	pioggia_mod_norm=pioggia_mod-mean(pioggia_mod);
	num=sum(pioggia_mis_norm.*pioggia_mod_norm);
	den=sqrt(sum(pioggia_mis_norm.^2)*sum(pioggia_mod_norm.^2));
corr=num/den

emedio = sum(pioggia_mod-pioggia)/length(quota)
emedio_abs = sum(abs(pioggia_mod-pioggia))/length(quota)
vars = var(pioggia_mod)/var(pioggia)

figure(5); 
plot(1:length(quota),pioggia,1:length(quota),pioggia_mod,'r');