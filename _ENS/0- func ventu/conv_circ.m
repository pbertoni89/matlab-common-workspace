% funzione convoluzione circolare

function z= conv_circ(x,Tx,y,Ty,n)
    z=zeros(1,length(n));
    
    % CALCOLO DEL mcm
    if Tx>Ty m=Tx;
    else m=Ty;
    end
    T=Tx*Ty;
    for i=m:Tx*Ty
        if(mod(i,Tx)==0 && mod(i,Ty)==0) 
            T=i;
        end
    end
    
    % CALCOLO DELLA CONVOLUZIONE
    p=find(n==0);
    for k=p:p+T
        z(k)=sum(x.*shift(ribalta(y,n),n,n(k)));
    end
    
    
    
    
    
    
    