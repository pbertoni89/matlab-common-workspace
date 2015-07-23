function A = myDistance(x,y,dt)

A = sqrt(integrale(abs(x-y).^2,dt));