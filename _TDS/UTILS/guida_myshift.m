
%% CONVOLUZIONE CON UN PETTINE D IMPULSI

x(t);

deltaT(t);

xT = zeros(size(t));
T = 2; % passo

for n = floor(min(t)/T):ceil(max(t)/T)
    
    xT = xT + myshift(xp,n*T/dt);

end

%% Convoluzione

y = zeros(1,length(t));
    for k = 1:length(t)
        y(k) = integrale(h .* myshift( fliplr(x), t(k)/dt), dt);
    end

%% correlazione Lineare.

phi_xy = zeros(1,length(t));
for k = 1:length(tau)
    phi_xy(k) = myScalarProduct( myshift( y,-t(k)/dt), x, dt); % giusto:     x*(t) . y(t+tau)
end
    
%% correlazione Circolare => di Potenza

xp = rect(t-1/2)-rect(t-3/2);

T = 2;
for n = floor(min(t)/T):ceil(max(t)/T)
    xT = xT+myshift(xp,n*T/dt);
end

phi_circ_xy = zeros(1,length(t));
for k = 1:length(t)
    phi_circ_xy(k) = (1/T)*integrale( conj(xT) .* mycircshift(xT,-t(k)/dt),dt);
end

% esempio: processo PAM
for k=1:length(t)
    phi_x(k) = (1/14)* integrale( conj(x) .* myshift( x, t(k)/dt), dt); 
end

% ho diviso per l'ampiezza del supporto!

