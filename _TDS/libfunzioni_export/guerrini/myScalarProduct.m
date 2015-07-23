function A = myScalarProduct(x,y,dt)

A = integrale(x.*conj(y),dt);