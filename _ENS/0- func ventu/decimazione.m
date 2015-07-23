% funzione decimazione
% comprimo la sequenza di una quantità D

function y = decimazione(x,n,D)
    y=zeros(1,length(n));
    p=find(n==0);
    y(p)=x(p);
    c=0;
    for i=1:floor((length(n)-p)/D)
        y(i+p)=x(D*i+p);
        c=c+1;
    end
    for j=1:c
        y(p-j)=x(p-D*j);
    end