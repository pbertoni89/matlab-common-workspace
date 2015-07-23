%% 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear all; close all; clc;
xa = -2; xb = 2; 
xext = linspace(xa,xb,1000);

f = @(x) exp(-x.^2); % f appartiene a classe C4(-2,2)
yext = f(xext);

fs = sym(f); d2fs = diff(diff(fs));
d4fs = diff(diff(d2fs));

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% SPLINE
d4f = matlabFunction(d4fs); maxd4f = max(d4f(xext));
C = 5/384;
tol = 1.e-6;

Hmax = (tol/(C*maxd4f))^(1/4);
n = ceil((xb-xa)/Hmax) % punti di interpolazione per la spline

x = linspace(xa,xb,n+1);
y = f(x);
yspl = spline(x,y,xext);

errmax_s = max(abs(yext-yspl));
if errmax_s < tol
	fprintf('Spline: err = %d < %d accettabile (CVD)\n', ...
		errmax_s, tol);
else
	fprintf('Spline: err = %d > %d NON OK.rivedere calcoli\n', ...
		errmax_s, tol);
end

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% IGL
errIGL = []; N = 2:90; H = (xb-xa)./N; figure
for n = N
	x = linspace(xa,xb,n+1);
	y = f(x);
	a = vander(x)\y';
	yigl = polyval(a,xext);
	errIGL = [ errIGL max(abs(yext-yigl)) ];
	
	if mod(n,10) == 0, subplot(3,3,n/10)
		plot(xext,yext,'b',xext,yigl,'r',x,y,'ok'), end
end
figure
loglog(H,H,'b',H,H.^2,'g',H,errIGL,'r'),legend('h','h^2','er_{IGL}')
% si ha una divergenza dell'errore per la propagazione degli errori 
% di roundoff. difatti con IGL su nodi EQUISPAZ non si hanno cond

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ICL (non richiesto dal TE, è legacy di esercizio

% d2f = matlabFunction(d2fs); maxd2f = max(d2f(xext)); 
% C = 5/384; % non lo sappiamo!!
% tol = 1.e-6;  %C=1; a caso proprio
% 
% Hmax = (tol/(C*maxd2f))^(1/2);
% n = ceil((xb-xa)/Hmax) % punti di interpolazione per la spline

x = linspace(xa,xb,n+1);
y = f(x);
yicl = interp1(x,y,xext);

errmax_icl = max(abs(yext-yicl));
% if errmax_icl < tol
% 	fprintf('ICL: errore = %d < %d accettabile (CVD)\n', ...
% 		errmax_icl, tol);
% else
% 	fprintf('ICL: errore = %d > %d NON OK. rivedere calcoli\n', ...
% 		errmax_icl, tol);
% end %a meno di conoscere C, qui uscirà qualcosa di NON OK

%% 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear all; close all; clc;
a0 = zeros(2); a1 = ones(2)*1001;
A = [ a1 [0 0;1 0] a0; [0 1;0 0] a1 [0 0;1 0]; a0 [0 1; 0 0] a1];
b = ones(6,1)*2003; b(1) = 2002; b(6) = 2002;
xex = ones(6,1);
% sulla diagonale non ci devono essere zeri. possiamo sperare sia
% possibile usare MEG senza pivotare
% det(A) ~ 1.e6 e rank(A) = 6, perciò MEG termina senza pivoting.

xbslash = A\b; errL2 = norm(xbslash-xex); K = cond(A);
fprintf('if %d <= %d %d = %d\n', errL2, K, eps, K*eps);
if errL2 <= K*eps
	disp('frontale: ok teoria sulla stima a priori')
else
	disp('something went wrong')
end
% è possibile usare il gradiente coniugato, sebbene non sia garantito
% di raggiungere cvg in 6 passi siccome A non è SDP
x0 = rand(6,1);
[xcg,flag, ~,nit,~] = pcg(A,b,1.e-8,50,[],[],x0)  %sufficiente 1.e-8

errL2 = norm(xcg-xex); K = cond(A);
fprintf('if %d <= %d %d = %d\n', errL2, K, eps, K*eps);
if errL2 <= K*eps
	disp('CG: ok teoria sulla stima a priori')
else
	disp('something went wrong')
end
% siamo prossimi alla soluzione ma non rispettiamo la stima a priori.
% provo a utilizzare bicg, che non richiede A SDP. precondiziono.
[Lt, Ut] = luinc(sparse(A),1.e-5);
[xbicg,flag, ~,nit,~] = bicg(A,b,1.e-8,50,Lt,Ut,x0)

errL2 = norm(xbicg-xex); K = cond(A);
fprintf('if %d <= %d %d = %d\n', errL2, K, eps, K*eps);
if errL2 <= K*eps
	disp('BICG: ok teoria sulla stima a priori') % =)
else
	disp('something went wrong')
end

%% 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear all; close all; clc;

dy  = @(t,y) y./t + (3*t)./(1+t.^2);
yex = @(t)	 3*t.*atan(t);
t0 = 1; T  = 5; y0 = pi*3/4;

H = [ 5 4 3 2 1 .5 .1 .05 .01 ]; N = ceil((T-t0)./H);
conv = zeros(1,length(H));

for i=1:length(H)
	[ t y ] =  schema1(dy, [t0 T], y0, N(i));
	
	subplot(3,3,i), plot(t,y,'r'), hold on, yEx = yex(t);
	plot(t,yEx,'g'), title(['h=',num2str(H(i))])
	if i==length(H), legend('multi2','y_{exact}'), end
	
	conv(i) = max(abs(y-yEx));
end

figure
loglog(H, H.^1,'r',H, H.^2,'g',H, H.^3,'b',H, H.^4,'y',H,conv,'k')
legend('h^1','h^2','h^3','h^4','conv')
% la cvg è del quarto ordine. è assurdo: soluzione buona con N=1 !

% 3
% assoluta stabilità: il metodo è di tipo ignoto, non conosciamo 
% regole o forme chiuse per disegnarne la regione di a.stab.
% procediamo appunto sperimentalmente
p = 4; Lambda = [ -1 -2 -4 ];

H = [ 10 5 2.6 2 1 .1 .01]
T = 100; y0=1;

for i=1:length(H)
	n = ceil((T-t0)/H(i)); figure('name',['h=',num2str(H(i))])
	for j=1:length(Lambda)
		dy = @(t,y) Lambda(j)*y;  
		yex = @(t) y0*exp(Lambda(j)*t);
		[ t y ] =  schema1(dy, [t0 T], y0, n);
		subplot(3,1,j), plot(t,y,'r'), hold on, yEx = yex(t);
		plot(t,yEx,'g'), title(['L=',num2str(Lambda(j))])
		fprintf('h*L = %d * %d = %d\n',H(i),Lambda(j),H(i)*Lambda(j))
	end
end
% ipotesi: vi è un baco in schema1 perchè le soluzioni non devono 
% partire da (1,1).
% osservo che da h*lambda <= -4 si diverge; >= -2 abs.stab.
% cerco di raffinare il gap -4,-2) introducendo degli h tra 1 e 5
% a hlambda = -3 si diverge;	=-2.6 si cvg a fatica.
