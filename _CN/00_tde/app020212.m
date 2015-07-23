%% 1
clear all; clc, close all

%1
N = 5:5:100; KA = [];
for n = N
	h = 1/n; e = ones(n-1,1);
	A = spdiags([-e/(h^2),2*e/(h^2),-e/(h^2)],[-1 0 1],n-1,n-1);
	KA = [KA condest(A)];
end

plot(N,KA),title('cond(A)');

%2
P = 1:4;
for p = P
	ratio = KA./(N.^p);
	%figure,plot(N,ratio),title(['p=',num2str(p)]);
end
% appare chiaro che la dipendenza è quadratica!!
p = 2
ratio = KA./(N.^p);
figure,plot(N,ratio),title(['p=',num2str(p)]);
C = mean(ratio(15:20))

%3
n = 50; h = 1/n; x = h*(1:n-1); b = sin(pi*x)';
A = spdiags([-e/(h^2),2*e/(h^2),-e/(h^2)],[-1 0 1],n-1,n-1);
R = cholinc(A,1.e-2); % fattorizzazione incompleta
% A è SDP: posso usare grad conj.
% A è sparsa: i metodi iterativi sono più efficienti
u = pcg(A,b,1.e-8,100,R,R',rand(n-1,1));
figure, plot(x,u), xlabel('x'), ylabel('u')

%% 2
clear all; clc, close all

x = linspace(-1,1,1000);

f = @(x) exp(x)-2./(1+x.^2);
phi = @(x) log(2./(1+x.^2));

figure(1);
plot(x,x,'y',x,f(x),'g',x,phi(x),'r'); axis tight, grid on

tol = 1e-6; nmax = 100;
x0 = 1.5;
[alph nit errhist] = ptofisso(phi, x0, tol, nmax);
hold on, plot(alph,f(alph),'ok'), legend('x','f','\phi','alpha')

figure(2);
semilogy((1:nit),errhist,'r'), grid on, legend('Err_{\phi}');

dphi = @(x) -2*x./(1+x.^2); % phi appartiene a C1
if abs(dphi(alph)) < 1
	disp('phi converge linearmente alla radice per Ostrovskij')
else
	disp('phi non rispetta Ostrovskij e la cvg non è garantita')
end

%% 3
clear all; clc, close all
L = -10;
dy  = @(t,y) exp(t)+L*y;
yex = @(t)	 exp(L*t)+exp(t)/11;
t0 = 0; T  = 1; y0 = 12/11;

H = [ .5 .1 .05 .01 .005 .001 ];
conv = zeros(1,length(H));

for i=1:length(H)
	n = ceil((T-t0)/H(i));
	[ t y ] = schema(dy,[t0 T],y0,n); yEx = yex(t);
	
	if H(i) == .01
		plot(t,y,'r',t,yEx,'g'), title(['h=',num2str(H(i))])
		legend('y_{schema}','y_{exact}')
	end
	
	conv(i) = max(abs(y-yEx));
end

figure
loglog(H, H.^1,'r');  hold on;
loglog(H, H.^2,'g'), loglog(H, H.^3,'b'), loglog(H, H.^4,'y');
loglog(H,conv,'k'); 
legend('h^1','h^2','h^3','h^4','Err');
% la convergenza è d'ordine 3.

% 3 assoluta stabilità
% la gervasio non ci ha dato una descrizione analitica del metodo,
% sebbene volendo essa è implementata in schema.m.
% perciò non faremo le considerazioni da farsi sui multistep,
% ma compiremo solo uno studio superficiale sperimentale.
dy  = @(t,y) L*y;
y0 = 1;
yex = @(t)	 y0*exp(L*t);
t0 = 0; T  = 100;

H = [.5 .1 .075 .06 .054 .051 .05 ];

for i=1:length(H)
	n = ceil((T-t0)/H(i));
	[ t y ] = schema(dy,[t0 T],y0,n); yEx = yex(t);
	
	figure
	plot(t,y,'r',t,yEx,'g'), title(['h=',num2str(H(i))])
	legend('y_{schema}','y_{exact}')
end
% sperimentalmente, e solo sperimentalmente, per il problema vale
H0 = .054