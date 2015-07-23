% funzione espansione
% espando la sequenza di una quantità I

function y = espansione(x,n,I)

    y=zeros(1,length(n));
    p=find(n==0);

    c=0;
    y(p)=x(p);
    
    for i= 1:floor( (length(n)-p) /I )
        y(I*i+p)=x(i+p);
        c=c+1;
    end
    
    for j=1:c
        l=p-j*I;
        y(l)=x(p-j);
    end