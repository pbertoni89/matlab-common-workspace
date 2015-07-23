clear all;
close all;

% Asse temporale
dt = 0.01;
t = -10:dt:10;
tau = t;

% Asse delle frequenze
df = 0.01;
f = -15:df:15;


% ***************
% * ESERCIZIO 2 *
% ***************


%% Punto 1

fprintf('\n*** Punto 1 ***\n\n');

x4 = 3*mysinc(2*t);
y4 = 1j*tri(t+1);
%y4 = tri(t+1);

crosscorrlinxy = zeros(size(tau));
crosscorrlinyx = zeros(size(tau));
for k = 1:length(tau)
    crosscorrlinxy(k) = myScalarProduct(myshift(y4,-tau(k)/dt),x4,dt);
    crosscorrlinyx(k) = myScalarProduct(myshift(x4,-tau(k)/dt),y4,dt);
end

figure(1), plot(tau,real(crosscorrlinxy)), hold on
plot(tau,imag(crosscorrlinxy),'r--'), title('$$\varphi_{xy}(\tau)$$','Interpreter','latex')
figure(2), plot(tau,real(crosscorrlinyx)), hold on
plot(tau,imag(crosscorrlinyx),'r--'), title('$$\varphi_{yx}(\tau)$$','Interpreter','latex')

delay = 3;
tindex = find(t==0);
tauindexdelay = find(tau==delay);
fprintf('|phi_xy(0)|&lt;=nx*ny: %.3f&lt;=%.3f*%.3f=%.3f\n',...
    abs(crosscorrlinxy(tindex)),myNorm(x4,dt),myNorm(y4,dt),myNorm(x4,dt)*myNorm(y4,dt));
fprintf('d^2(x,y_delay)=nx+ny-2Re(phi_xy(%.3f)): %.3f&lt;=%.3f+%.3f%+.3f=%.3f\n',...
    delay,myDistance(x4,myshift(y4,delay/dt),dt),myNorm(x4,dt),myNorm(y4,dt),2*real(crosscorrlinxy(tauindexdelay)),...
    myNorm(x4,dt)+myNorm(y4,dt)-2*real(crosscorrlinxy(tauindexdelay)));


%% Punto 2

fprintf('\n*** Punto 2 ***\n\n');

xp = rect(t-1/2)-rect(t-3/2);

autocorrlinx = zeros(size(tau));
for k = 1:length(tau)
    autocorrlinx(k) = myScalarProduct(myshift(xp,-tau(k)/dt),xp,dt);
end

figure(3), plot(tau,real(autocorrlinx)), hold on
plot(tau,imag(autocorrlinx),'r--'), title('$$\varphi_{x_p}(\tau)$$','Interpreter','latex')

Phix = T_Fourier(autocorrlinx,t,f);
figure(4), plot(f,real(Phix)), hold on
plot(f,imag(Phix),'r--'), title('$$\Phi_{x_p}(f)$$','Interpreter','latex')

fprintf('phi_x(0)=int(Phi(f))=nx^2: %.3f=%.3f=%.3f\n',...
    autocorrlinx(tindex),integrale(Phix,df),myNorm(xp,dt)^2);

pause;
%% Punto 3

fprintf('\n*** Punto 3 ***\n\n');

xT = zeros(size(t));
T = 2;
for n = floor(min(t)/T):ceil(max(t)/T)
    xT = xT+myshift(xp,n*T/dt);
end

autocorrcircx = zeros(size(tau));
for k = 1:length(tau)
    autocorrcircx(k) = 1/T*integrale(conj(xT).*mycircshift(xT,-tau(k)/dt),dt);
end

figure(5), plot(tau,real(autocorrcircx)), hold on
plot(tau,imag(autocorrcircx),'r--'), title('$$\overline{\varphi_{x_p}}(\tau)$$','Interpreter','latex');

pause;
return;