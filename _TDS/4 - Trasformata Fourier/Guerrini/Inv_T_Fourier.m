function x = Inv_T_Fourier(X,f,t)
%INV_TRASF_FOURIER Calcola la trasformata di Fourier inversa

df = f(2)-f(1);
x = zeros(size(t));

for k = 1:length(t)
    x(k) = integrale(X.*exp(j*2*pi*t(k)*f),df);
end
