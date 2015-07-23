function xq = myQuant(x,bits,shift)

D = max(x)-min(x); % dinamica
% inizializzo xq al primo valore di ricostruzione
xq = ones(size(x)) * min(x) + (1+shift) *D /2^(bits+1); 
xres = x-min(x); % residuo
for b = 1:bits % bisezione, MSB->LSB
    thisbit = (xres> D/2^b);
    xq = xq + thisbit * D *2^(-b);
    xres = xres - thisbit * D/2^b;
end

