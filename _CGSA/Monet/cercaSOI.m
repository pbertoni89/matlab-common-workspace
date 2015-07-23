%funzione che effettua la ricerca della SOI
function [soi,correlazioni] = cercaSOI(r,c,soi,correlazioni,errOss,nScenari,minimaVarSpieg,rig,col)

Zalfa=1.96;
R=correlazioni(r,c);

Ro = sqrt((minimaVarSpieg)*(1 + errOss)/100);
Z=0.5*((nScenari - 3)^0.5)*log(((1 + R)*(1 - Ro))/((1 - R)*(1 + Ro)));

if(Z>Zalfa)
    soi = [soi;[r,c]];
    correlazioni(r,c) = 0;

    if (r-1) > 0
        [soi,correlazioni]=cercaSOI(r-1,c,soi,correlazioni,errOss,nScenari,minimaVarSpieg,rig,col );
    end
    if (c+1) <= col
        [soi,correlazioni]=cercaSOI(r,c+1,soi,correlazioni,errOss,nScenari,minimaVarSpieg,rig,col);
    end
    if (r+1) <= rig
        [soi,correlazioni]=cercaSOI(r+1,c,soi,correlazioni,errOss,nScenari,minimaVarSpieg,rig,col );
    end
    if (c-1) > 0
        [soi,correlazioni]=cercaSOI(r,c-1,soi,correlazioni,errOss,nScenari,minimaVarSpieg,rig,col );
    end
    if ((r-1)>0 && (c+1)<=col)
        [soi,correlazioni]=cercaSOI(r-1,c+1,soi,correlazioni,errOss,nScenari,minimaVarSpieg,rig,col );
    end
    if ((r-1)>0 && (c-1)>0)
        [soi,correlazioni]=cercaSOI(r-1,c-1,soi,correlazioni,errOss,nScenari,minimaVarSpieg,rig,col );
    end
    if ((r+1)<=rig && (c+1)<=col)
        [soi,correlazioni]=cercaSOI(r+1,c+1,soi,correlazioni,errOss,nScenari,minimaVarSpieg,rig,col );
    end
    if ((r+1)<=rig && (c-1)>0)
        [soi,correlazioni]=cercaSOI(r+1,c-1,soi,correlazioni,errOss,nScenari,minimaVarSpieg,rig,col );
    end
end

end

