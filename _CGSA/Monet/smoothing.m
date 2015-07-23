%Regolarizza la FOM, riducendo le piccole fluttuazioni
function [ smoothFOM ] = smoothing(rig, col, FOM )
r=rig;
c=col;
smoothFOM = [];
  for I = 2 : r-1
     for J = 2 : c-1 
        smoothFOM(I,J) = (4*FOM(I,J) + FOM(I-1,J) + FOM(I+1,J) + FOM(I,J+1) + FOM(I,J-1))/8;
     end
  end
    
    
  for I = 2 : r-1
    smoothFOM(I,1) = (4*FOM(I,1) + FOM(I-1,1) + FOM(I+1,1))/6;
    smoothFOM(I,c) = (4*FOM(I,c) + FOM(I-1,c) + FOM(I+1,c))/6;
  end
  for J = 2 : c-1 
    smoothFOM(1,J) = (4*FOM(1,J) + FOM(1,J-1) + FOM(1,J+1))/6;
    smoothFOM(r,J) = (4*FOM(r,J) + FOM(r,J-1) + FOM(r,J+1))/6;
  end
  smoothFOM(1,1) = (4*FOM(1,1) + FOM(1,2) + FOM(2,1) + FOM(2,2))/7;
  smoothFOM(r,1) = (4*FOM(r,1) + FOM(r,2) + FOM(r-1,1) + FOM(r-1,2))/7;
  smoothFOM(1,c) = (4*FOM(1,c) + FOM(2,c) + FOM(1,c-1) + FOM(2,c-1))/7;
  smoothFOM(r,c) = (4*FOM(r,c) + FOM(r-1,c) + FOM(r,c-1) + FOM(r-1,c-1))/7;
end

