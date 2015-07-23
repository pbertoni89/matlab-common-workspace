%finestro il segnale da -10 a +10

function y = finestra_n(x,n)

    y=zeros(1,length(n));
    p=find(n==0);

    for i=(p-10):(p+10)
        y(i)=x(i+10);
    end