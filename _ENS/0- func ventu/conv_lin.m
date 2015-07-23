% funzione convoluzione lineare

function z = conv_lin(x,y,n)
    z=zeros(1,length(n));
    for k=1:length(n)
        z(k)=sum(x.*shift(ribalta(y,n),n,n(k)));
    end