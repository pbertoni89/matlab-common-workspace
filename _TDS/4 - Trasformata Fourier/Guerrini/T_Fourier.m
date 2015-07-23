function X = T_Fourier(x,t,f)
%TRASF_FOURIER Calcola la trasformata di Fourier 

dt = t(2)-t(1);
X = zeros(size(f));

for k = 1:length(f)
    X(k) = integrale(x.*exp(-1i*2*pi*f(k)*t),dt);
end
