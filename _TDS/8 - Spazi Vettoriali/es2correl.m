
which es2correl;

clear; close all;

dt=.01; df=dt;
t= -10:dt:10;
f= -10:df:10;

x4= 3*my_sinc(2*t);    y4= tri(t+1);    y4j= 1i*y4;

xp= my_rect(t-.5) - my_rect(t-1.5);

%% i)

phi_y4x4 = zeros(size(t)); 
phi_y4jx4 = phi_y4x4;


xDIV= sin(2*pi*2*t);
yDIV= sin(2*pi*5*t);    phiDIV = zeros(size(t));

for k = 1:length(t)
    
    phiDIV = integrale( conj(yDIV) .* myshift( xDIV , t(k)/dt), dt); 
    phi_y4x4(k) = integrale( conj(y4) .* myshift( x4 , t(k)/dt), dt);  % non faccio fliplr E coniugo x(t)
    phi_y4jx4(k) = integrale( conj(y4j) .* myshift( x4 , t(k)/dt), dt);  % non faccio fliplr E coniugo x(t)
end

phi_11 = zeros(1,length(t));
for k = 1:length(t)
    phi_y4x4(k) = myScalarProduct( myshift( x4,-t(k)/dt), y4, dt);  % myscalarproduct( x, y, dt)  X trasla  Y coniugato
end

figure('name','Cross-correlazione yx tra x=3sinc(2t) e y');
subplot(1,2,1); hold on; plot( t, imag(phi_11), 'b'); plot( t, imag(phi_y4jx4), 'g'); title('y = tri(t+1)'); grid on; axis( [-5 5 -1.5 1.5] )
subplot(1,2,2); hold on;
    plot( t, real(phi_y4jx4), 'b'); plot( t, imag(phi_y4jx4), 'r');
    title('y = j.tri(t+1)'); grid on; axis( [-5 5 -1.5 1.5] ); hold off;

fprintf(' x= 3sinc(2t)   y= tri(t+1) \n');    
fprintf('Dimostro che |phi_xy(0)| <= ||x||.||y||  infatti %f <= %f \n',...
    abs( phi_y4x4( floor(length(t)*0.5)) ), normaL2tipo1(x4,t)*normaL2tipo1(y4,t) );

fprintf('****\n Adesso x= 3sinc(2t)   y= j.tri(t+1) \n');
fprintf('Dimostro che |phi_xyj(0)| <= ||x||.||y||  infatti %f <= %f \n',...
    abs( phi_y4jx4( floor(length(t)*0.5)) ), normaL2tipo1(x4,t)*normaL2tipo1(y4j,t) );

%% ii)

phi_xpxp = zeros(size(t)); 

for k = 1:length(t)
    phi_xpxp(k) = integrale( xp .* myshift( conj(xp) , t(k)/dt), dt);  % non faccio fliplr E coniugo xp(t)
end

PHI_xpxp = fourierTrasf( phi_xpxp, t, f);

figure('name','Autocorrelazione e densità spettrale di x(t)= rect(t-1/2) - rect(t-3/2)');
subplot(1,3,1); plot( t, xp, 'b'); title('rect(t-1/2)-rect(t-3/2)'); grid on;  axis( [-5 5 -1.5 2.5] );
subplot(1,3,2); hold on; plot( t, real(phi_xpxp), 'b'); plot( t, imag(phi_xpxp), 'r'); hold off; title('Auto-correlazione'); grid on; axis( [-5 5 -1.5 2.5] )
subplot(1,3,3); hold on; plot( f, real(PHI_xpxp), 'b'); plot( f, imag(PHI_xpxp), 'r'); hold off; title('Densità spettrale'); grid on; axis( [-5 5 -.5 2.5] )

%% iii)

xT = zeros(size(t));
T = 2;

for n = floor(min(t)/T):ceil(max(t)/T)
    xT = xT + myshift(xp,n*T/dt);
end

phi_xTxT= zeros(size(t));

for k = 1:length(t)
    %phi_xTxT(k)= (1/T)*riemannInt(t, 0, T, conj(xT) .* mycircshift(xT, t(k)/dt ) )
    phi_xTxT(k)= (1/T)*integrale( conj(xT) .* mycircshift(xT, -t(k)/dt),dt); % perfettamente equivalenti!
end

PHI_xTxT= fourierTrasf(phi_xTxT, t, f);

figure('name','Autocorrelazione circolare dell onda quadra');
subplot(1,3,1); plot( t, xT, 'r'); title('rect(t-1/2)-rect(t-3/2)'); grid on;  axis( [0 7 -2 2] );
subplot(1,3,2); hold on; plot( t, real(phi_xTxT), 'b'); plot( t, imag(phi_xTxT), 'r'); hold off; title('Auto-correlazione circolare'); grid on; %axis( [-5 5 -2.5 2.5] )
subplot(1,3,3); hold on; plot( f, real(PHI_xTxT), 'b'); plot( f, imag(PHI_xTxT), 'r'); hold off; title('Densità spettrale'); grid on; %axis( [-8 8 -2 9] )

return;