%funzione che effettua la ricerca di un cluster
function [vettore,A,clusterSoglia] = cercaCluster(A,r,c,vettore,valoreSoglia,clusterSoglia)
    [rig,col]=size(A);
   
    if A(r,c) >= valoreSoglia 
        vettore = [vettore;[r,c]];
        clusterSoglia = [clusterSoglia;A(r,c)];
        A(r,c) = 0;
        if (r-1) > 0
            [vettore,A,clusterSoglia]=cercaCluster( A,r-1,c,vettore,valoreSoglia,clusterSoglia );
        end
        if (c+1) <= col
            [vettore,A,clusterSoglia]=cercaCluster( A,r,c+1,vettore,valoreSoglia,clusterSoglia );
        end
        if (r+1) <= rig
            [vettore,A,clusterSoglia]=cercaCluster( A,r+1,c,vettore,valoreSoglia,clusterSoglia );
        end
        if (c-1) > 0
            [vettore,A,clusterSoglia]=cercaCluster( A,r,c-1,vettore,valoreSoglia,clusterSoglia );
        end
        
    end

end

