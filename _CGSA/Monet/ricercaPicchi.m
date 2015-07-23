%ricerca i picchi nella matrice delle FOM
function [ picchi ] = ricercaPicchi(rig, col, FOM, limiteStazioni)

picchi = [];
r=rig;
c=col;

I = 1;
for J = 2 : c - 1 %bordo sopra
    if (FOM(I,J)>FOM(I+1,J)) && (FOM(I,J)>FOM(I+1,J-1)) && ...
        (FOM(I,J)>FOM(I+1,J+1)) && (FOM(I,J)>FOM(I,J-1)) && (FOM(I,J)>FOM(I,J+1))
            picchi = [picchi;I,J,FOM(I,J)];
            if length(picchi) == limiteStazioni
                break;
            end
    end
end
I = r;
for J = 2 : c - 1 %bordo sotto
    if (FOM(I,J)>FOM(I-1,J)) && (FOM(I,J)>FOM(I-1,J-1)) && ...
        (FOM(I,J)>FOM(I-1,J+1)) && (FOM(I,J)>FOM(I,J-1)) && (FOM(I,J)>FOM(I,J+1))
            picchi = [picchi;I,J,FOM(I,J)];
            if length(picchi) == limiteStazioni
                break;
            end
    end
end
J = 1;
for I = 2 : r - 1 %bordo sinistra
    if (FOM(I,J)>FOM(I,J+1)) && (FOM(I,J)>FOM(I-1,J)) && ...
        (FOM(I,J)>FOM(I+1,J)) && (FOM(I,J)>FOM(I-1,J+1)) && (FOM(I,J)>FOM(I+1,J+1))
            picchi = [picchi;I,J,FOM(I,J)];
            if length(picchi) == limiteStazioni
                break;
            end
    end
end
J = c;
for I = 2 : r - 1 %bordo destra
    if (FOM(I,J)>FOM(I,J-1)) && (FOM(I,J)>FOM(I-1,J-1)) && ...
        (FOM(I,J)>FOM(I+1,J-1)) && (FOM(I,J)>FOM(I-1,J)) && (FOM(I,J)>FOM(I+1,J))
            picchi = [picchi;I,J,FOM(I,J)];
            if length(picchi) == limiteStazioni
                break;
            end
    end
end
%spigoli della FOM
if (FOM(1,1)>FOM(1,2)) && (FOM(1,1)>FOM(2,2)) && (FOM(1,1)>FOM(2,1))
    picchi = [picchi;I,J,FOM(I,J)];
    if length(picchi) == limiteStazioni
        return;
    end
end
if (FOM(1,c)>FOM(1,c-1)) && (FOM(1,c)>FOM(2,c-1)) && (FOM(1,c)>FOM(2,c))
    picchi = [picchi;I,J,FOM(I,J)];
    if length(picchi) == limiteStazioni
    	return;
    end
end
if (FOM(r,1)>FOM(r,2)) && (FOM(r,1)>FOM(r-1,1)) && (FOM(r,1)>FOM(r-1,2))
    picchi = [picchi;I,J,FOM(I,J)];
    if length(picchi) == limiteStazioni
        return;
    end
end
if (FOM(r,c)>FOM(r-1,c)) && (FOM(r,c)>FOM(r,c-1)) && (FOM(r,c)>FOM(r-1,c-1))
    picchi = [picchi;I,J,FOM(I,J)];
    if length(picchi) == limiteStazioni
    	return;
    end
end
%centro della FOM
for I = 2 : r - 1
    for J = 2 : c - 1
        if (FOM(I,J)>FOM(I+1,J)) && (FOM(I,J)>FOM(I-1,J)) && (FOM(I,J)>FOM(I+1,J-1)) && ...
         (FOM(I,J)>FOM(I-1,J-1)) && (FOM(I,J)>FOM(I+1,J+1)) && (FOM(I,J)>FOM(I-1,J+1)) && ...
         (FOM(I,J)>FOM(I,J-1)) && (FOM(I,J)>FOM(I,J+1))
            picchi = [picchi;I,J,FOM(I,J)];
            if length(picchi) == limiteStazioni
                break;
            end
        end
    end
end
end


