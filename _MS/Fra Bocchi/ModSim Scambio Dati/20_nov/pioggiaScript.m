clear all;

quota=[276 201 323 214 218 333 262 930 307 449]';
xutm=[36525 45227 57442 70737 69737 70477 83987 105737 107207 129237]';
yutm=[24498 3524 3139 7504 39479 59794 39204 53954 43104 48904]';
pioggia=[1615 1547 1565 1355 1408 1462 1112 1008 1095 869]';

% Primo caso: pioggia funzione lineare della quota
M=[quota,ones(length(quota),1)]

theta=inv(M'*M)*M'*pioggia;
pioggia_mod=theta(1)*quota+theta(2);
 
pioggia_mis_norm=pioggia-mean(pioggia);
pioggia_mod_norm=pioggia_mod-mean(pioggia_mod);

num=sum(pioggia_mis_norm.*pioggia_mod_norm);
den=sqrt(sum(pioggia_mis_norm.^2)*sum(pioggia_mod_norm.^2));
corr=num/den
corr1=corrcoef(pioggia,pioggia_mod)
emedio=1/length(quota)*sum(pioggia_mod-pioggia)
emedio_abs=1/length(quota)*sum(abs(pioggia_mod-pioggia))
vars=var(pioggia_mod)/var(pioggia)
pause

% Secondo caso: pioggia funzione lineare delle coordinate piane
M=[xutm yutm ones(length(xutm),1)]
theta=inv(M'*M)*M'*pioggia;
pioggia_mod=theta(1)*xutm+theta(2)*yutm+theta(3);

pioggia_mis_norm=pioggia-mean(pioggia);
pioggia_mod_norm=pioggia_mod-mean(pioggia_mod);

num=sum(pioggia_mis_norm.*pioggia_mod_norm);
den=sqrt(sum(pioggia_mis_norm.^2)*sum(pioggia_mod_norm.^2));
corr=num/den;
corr1=corrcoef(pioggia,pioggia_mod)
emedio=1/length(quota)*sum(pioggia_mod-pioggia)
emedio_abs=1/length(quota)*sum(abs(pioggia_mod-pioggia))
vars=var(pioggia_mod)/var(pioggia)
pause

% Terzo caso: pioggia funzione lineare di tutte le coordinate spaziali
M=[xutm yutm quota ones(length(xutm),1)]
theta=inv(M'*M)*M'*pioggia;
pioggia_mod=theta(1)*xutm+theta(2)*yutm+theta(3)*quota+theta(4);

pioggia_mis_norm=pioggia-mean(pioggia);
pioggia_mod_norm=pioggia_mod-mean(pioggia_mod);

num=sum(pioggia_mis_norm.*pioggia_mod_norm);
den=sqrt(sum(pioggia_mis_norm.^2)*sum(pioggia_mod_norm.^2));
corr=num/den;
corr1=corrcoef(pioggia,pioggia_mod)
emedio=1/length(quota)*sum(pioggia_mod-pioggia)
emedio_abs=1/length(quota)*sum(abs(pioggia_mod-pioggia))
vars=var(pioggia_mod)/var(pioggia)
pause

% Quarto caso: pioggia funzione quadratica della quota
M=[quota.^2 quota ones(length(xutm),1)]
theta=inv(M'*M)*M'*pioggia;
pioggia_mod=theta(1)*quota.^2+theta(2)*quota+theta(3);

pioggia_mis_norm=pioggia-mean(pioggia);
pioggia_mod_norm=pioggia_mod-mean(pioggia_mod);

num=sum(pioggia_mis_norm.*pioggia_mod_norm);
den=sqrt(sum(pioggia_mis_norm.^2)*sum(pioggia_mod_norm.^2));
corr=num/den;
corr1=corrcoef(pioggia,pioggia_mod)
emedio=1/length(quota)*sum(pioggia_mod-pioggia)
emedio_abs=1/length(quota)*sum(abs(pioggia_mod-pioggia))
vars=var(pioggia_mod)/var(pioggia)
pause

% Quinto caso: pioggia funzione esponenziale della quota
M=[quota ones(length(xutm),1)]
log_pioggia=log(pioggia);
theta=inv(M'*M)*M'*log_pioggia;
%calcolo parametro iniziale a partire da parametro stimato 'theta(2)'
thetha(2)=exp(theta(2));
pioggia_mod=thetha(2)*exp((theta(1)*quota));

pioggia_mis_norm=pioggia-mean(pioggia);
pioggia_mod_norm=pioggia_mod-mean(pioggia_mod);

num=sum(pioggia_mis_norm.*pioggia_mod_norm);
den=sqrt(sum(pioggia_mis_norm.^2)*sum(pioggia_mod_norm.^2));
corr=num/den;
corr1=corrcoef(pioggia,pioggia_mod)
emedio=1/length(quota)*sum(pioggia_mod-pioggia)
emedio_abs=1/length(quota)*sum(abs(pioggia_mod-pioggia))
vars=var(pioggia_mod)/var(pioggia)

