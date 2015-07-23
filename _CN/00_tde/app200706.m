%% 1
clear all; close all; clc;
% nel tde si chiede di usare itermeth.m : è la nostra gsjac

% come vedere se è buono? deve:
%   rispettare la relazione tra B e g
%	avere raggio spettrale meno che unitario

clear all; close all; clc;

tol8  = 1.e-8; tol14 = 1.e-14;
nmax = 500; n = 4; prove = 30;

A = [.5 0 0 -1; 0 1 -1/3 0; 0 -.25 1 0; -1 0 0 4/5];
b = ones(n,1);
xex = A\b;
B = eye(n)-A;
g = b;

% c sufficienti
if is_dds(A)==1
	disp('A è DDS e questo assicura convergenza di J-GS.');
end
if is_sdp(A)==1
	disp('A è SDP e questo assicura convergenza di GS.');
end
% c necessarie
if xex == B*xex+g;
	disp('relazione di consistenza verificata per metodo X');
	if max(abs(eig(B))) < 1
		disp('convergenza alla soluzione per metodo X');
	else
		disp('convergenza NON alla soluzione per metodo X');
	end
else
	disp('relazione di consistenza NON verificata per metodo X');
end

figure(1);	
for i = 1:prove
	x0 = rand(4,1);

	[xJ niterJ ERRJ rhoJ]    = gsjac(A, b, x0, tol8, nmax, 'J');
	[xGS niterGS ERRGS rhoGS] = gsjac(A, b, x0, tol8, nmax, 'GS');

	semilogy((1:niterJ),ERRJ,'r',(1:niterGS),ERRGS,'b'); hold on;
end
grid on, legend('J', 'GS'), title('Errore'), rhoJ, rhoGS

xex = A\b;
disp('Jacobi tol8');
[ x nit ] =  gsjac(A, b, x0, tol8, nmax, 'J');
errrel = norm(xex-x)/norm(xex), nit
disp('GaussSiedel tol8');
[ x nit ] =  gsjac(A, b, x0, tol8, nmax, 'GS');
errrel = norm(xex-x)/norm(xex), nit

% Permutiamo
pause, clc
% la NON convergenza è dimostrata anche 

% una permutazione di A restituisce una matrice DDS
% (cioè a dominanza diagonale stretta)
% ovviamente occore permutare anche b
A = [A(4,:); A(2,:); A(3,:); A(1,:)];
% b = [b(4); b(2); b(3); b(1)];   UNUSEFUL; b è ones.

B = eye(n)-A;
g = b;
xex = A\b;

% c sufficienti
if is_dds(A)==1
	disp('A è DDS e questo assicura convergenza di J-GS.');
end
if is_sdp(A)==1
	disp('A è SDP e questo assicura convergenza di GS.');
end
% c necessarie
if xex == B*xex+g;
	disp('relazione di consistenza verificata per metodo X');
	if max(abs(eig(B))) < 1
		disp('convergenza alla soluzione  per metodo X');
	else
		disp('convergenza NON alla soluzione per metodo X');
	end
else
	disp('relazione di consistenza NON verificata per metodo X');
end

figure(2);	
for i = 1:prove
	x0 = rand(4,1);

	[xJ niterJ ERRJ rhoJ]    = gsjac(A, b, x0, tol8, nmax, 'J');
	[xGS niterGS ERRGS rhoGS] = gsjac(A, b, x0, tol8, nmax, 'GS');

	semilogy((1:niterJ),ERRJ,'r',(1:niterGS),ERRGS,'b'); hold on;
end
grid on,  legend('J', 'GS'),  title('Errore'), rhoJ, rhoGS

disp('Jacobi tol8')
[ x nit ] =  gsjac(A, b, x0, tol8, nmax, 'J');
errrel = norm(xex-x)/norm(xex), nit
disp('GaussSiedel tol8')
[ x nit ] =  gsjac(A, b, x0, tol8, nmax, 'GS');
errrel = norm(xex-x)/norm(xex), nit

%% 2
clear all; close all; clc;

%1
a = 0;
b = 2;
M = 1000;
tol = 1.e-6;
Iex = 319/48-47*sqrt(2)/12;
f = @(x) abs(x.*(x-sqrt(2)).*(2*x-1));
% non vi sono forme chiuse per determinare l'errore in questo caso:
% la f integranda non è assolutamente di classe C4

[ Js Jmy] = simpsonc(a,b,M,f);% n = unique(n);
err = abs(Js-Iex);
fprintf('simsponc ha usato %i nodi per un errore di %d\n',M,err)

[Js_mlab var1 ] = quad(f,a,b,tol); err = abs(Js_mlab-Iex);
fprintf('matlab ha usato %i nodi per un errore di %d\n',var1, err)

x_ex = linspace(a,b,1000); y_ex = f(x_ex); 
figure, plot(x_ex,y_ex,'b')
disp('____________________________________________________________')
%2 voglio integrare perfettamente (a meno di roundoff) polinomi p<=3
% sapendo che il metodo ha p=3, questo è possibilissimo.
% voglio inoltre sempre usare 3 intervalli
a = 0; b = 1; M = 3;
poly3 = @(x) 7*x.^3-8*x.^2+6*x.^1-5;
Poly3 = @(x) (7/4)*x.^4-(8/3)*x.^3+3*x.^2-5*x;
Iex = Poly3(b)-Poly3(a);

[ Js Jmy] = simpsonc(a,b,M,poly3);
err = abs(Js-Iex);
fprintf('Poly: simpsc ha usato %i nodi per un errore di %d\n',M,err)

[Js_mlab var1 ] = quad(poly3,a,b,1.e-16); err = abs(Js_mlab-Iex);
fprintf('matlab ha usato %i nodi per un errore di %d\n',var1, err)

x_ex = linspace(a,b,1000); y_ex = poly3(x_ex); 
figure, plot(x_ex,y_ex,'b')

%% 3
clear all; close all; clc;
%	attenzione: ogni volta che custom viene chiamata
%	viene chiamata anche EE, SOLO per un raffronto grafico.

%	uk dipende solo da ui con i<k => il metodo è esplicito
%	in particolare il metodo è multistep a DUE STEPS.
%	i suoi coefficienti sono 
%		a0 =  1/3 ; a1 =  2/3 
%		b0 = 11/6 ; b1 = -1/6
%	la teoria ci dice che
%	{ 1/3+2/3=1 and -0*(1/3)-1*(2/3)+11/6-1/6=1 => consistente
%	{ pigrec = @(r) r.^2  - (1/3)*r.^1 - (2/3)*r.^0;
%   fzero(pigrec,0) = -0.667 => zero stabile
%	però andiamo avanti ignorando le proprietà dei multistep
%	e applichiamo le definizioni rigorose.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%	per ZeroStabilità deve esistere un h piccolo sotto il quale 
%		ogni punto della soluzione non perturbata differisce dal
%		rispettivo punto della perturbata per un infinitesimo.
%	inoltre, uno schema consistente è convergente sse è 0stabile.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%	uno schema consistente è tale per cui con h infinitesimi si ha
%		max ( yn - un  / h  ) vale zero, tra tutti gli n.
%		=> occorre risolvere l'ODE in via analitica per avere y.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%	infine la convergenza implica che esista una funzione c(h) molto
%		piccola in valori tale che | yn - un | < c(h) per ogni punto.
%		=> occorre risolvere l'ODE in via analitica per avere y.

dy = @(t,y) -(y-3).^2;
f = @(t) 3+1./(t+1);
t0 = 0; T  = 5; 
y0 = 4; % y1 MANCA

H = [1 .5 .1 .05 .01 .005 .001 .0005 ];
N = ceil((T-t0)./H);

cons = zeros(1,length(H)); % lista per le consistenze
conv = cons; % lista per le convergenze


% RK4 inside
order = 4; % verrà cambiato in seguito. intanto attiva RK4 per u1

for i=1:length(H)
	[ t_ee y_ee ] =  eul_expl(dy, [t0 T], y0, N(i));
	[ t_cm y_cm ] =  custom_multi(dy, [t0 T], y0, N(i), order);

	figure(1); subplot(3,3,i);
	plot(t_cm,y_cm,'r'); hold on;
	plot(t_ee,y_ee,'g'); title(['h=',num2str(H(i))])
	if i==length(H), legend('EE','CM'), end
	
	t = linspace(t0,T,N(i)+1);
	y = f(t);
	cons(i) = max((y-y_cm)/H(i));
	conv(i) = max(abs(y-y_cm));
end

figure(2);
plot(H,cons,'b'), title('consistenza'), xlabel('h')
% si ha consistenza, il valore asintotico è zero.

figure(3);
loglog(H, H.^1,'r');  hold on;
loglog(H, H.^2,'g'), loglog(H, H.^3,'b'), loglog(H, H.^4,'y');
loglog(H,conv,'k'); 
legend('h^1','h^2','h^3','h^4','conv');
% si ha una convergenza (del second'ordine)

% pertanto si ha zerostabilità.

% Ora si provi a modificare il corpo della function custom,
% calcolando u1 con un metodo meno accurato (di ordine minore).
% invece di rk4 useremo eulero esplicito.

% EE inside
order = 2;

for i=1:length(H)

	[ t_ee y_ee ] =  eul_expl(dy, [t0 T], y0, N(i));
	[ t_cm y_cm ] =  custom_multi(dy, [t0 T], y0, N(i), order);

	figure(4); subplot(3,3,i);
	plot(t_cm,y_cm,'r'); hold on;
	plot(t_ee,y_ee,'g'); title(['h=',num2str(H(i))])
	if i==length(H), legend('EE','CM'), end
	
	t = linspace(t0,T,N(i)+1);
	y = f(t);
	cons(i) = max((y-y_cm)/H(i));
	conv(i) = max(abs(y-y_cm));
end

figure(5);
plot(H,cons,'b'); title('cons');
% si ha consistenza, il valore asintotico è zero.

figure(6);
loglog(H, H.^1,'r');  hold on;
loglog(H, H.^2,'g'), loglog(H, H.^3,'b'), loglog(H, H.^4,'y');
loglog(H,conv,'k'); 
legend('h^1','h^2','h^3','h^4','conv');
% si ha una convergenza (del second'ordine)

% pertanto si ha zerostabilità.
% WRN, stavolta certi h uscivano dalla regione di stabilità di EE 
% (mentre prima evidentemente era sempre rispettata quella di RK4)
% si produceva quindi un u1 falso che chiaramente inficiava il resto
% del calcolo.

% SECONDO PROBLEMA ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%  ~~Regione di Stabilità ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
disp('secondo problema'); clear all; close all; clc;
% proviamo direttamente a tenere EE interno a custom.
% stavolta non ci interessa buttar giù tante simulazioni e tanti h,
% ma vorremmo calcolare da subito h0 come il peggior feasible.
%
% la root condition citata prima imponeva SCRIVERE
% r.^2 - (1/3)*r.^1 - (2/3)*r.^0 = 0
lambda = -36; N = 200;
theta = linspace(0,2*pi,N); r = exp(1i*theta);
% 200 punti cplx; angolo uniforme e modulo 1
num = 6*(r.^2 - r/3 - 2/3); den = 11*r-1; z = num./den; 
% z = h*lambda
% trovare l'intersezione h0
H = linspace(0,1.e-1,N); % un centinaio, chiaro.
retta = H*lambda;
eestab = r-1;

zr = -0.3256;
H0 = zr/lambda
%dst=abs(retta-z); H0 = retta(dst==min(dst)); addst= abs(diff(dst));
%figure(); plot(1:N,dst,'b'), hold on, plot(1:N-1,addst,'r');

figure()
plot(z,'c'); grid on; hold on;
plot(eestab,'g');
plot(retta,zeros(1,N),'r');
plot(zr,0,'ob');
legend('custom','EE','h\lambda','h_0 \lambda');

H = [ H0*1.e-1 5*H0*1.e-1 H0 5*H0*1.e0 H0*1.e1 ]'

dy = @(t,y) lambda*y; 
t0 = 0; T  = .5;
y0 = 1;
f = @(t) y0*exp(lambda*t);
order = 2; % provo tenendo il metodo stabile
N = ceil((T-t0)./H);

for i=1:length(H)
	[ t_ee y_ee ] =  eul_expl(dy, [t0 T], y0, N(i));
	[ t_cm y_cm ] =  custom_multi(dy, [t0 T], y0, N(i), order);

	figure(2); subplot(2,3,i);
	plot(t_cm,y_cm,'r'); hold on;
	plot(t_ee,y_ee,'g'); title(['h=',num2str(H(i))])
	if i==length(H), legend('EE','CM'), end
	
	t = linspace(t0,T,N(i)+1);
	y = f(t);
	cons(i) = max((y-y_cm)/H(i));
	conv(i) = max(abs(y-y_cm));
end

figure(3);
plot(H,cons,'b'); legend('cons');
% si ha consistenza, il valore asintotico è zero.

figure(4);
loglog(H, H.^1,'r');  hold on;
loglog(H, H.^2,'g'), loglog(H, H.^3,'b'), loglog(H, H.^4,'y');
loglog(H,conv,'k'); 
legend('h^1','h^2','h^3','h^4','conv');
% si ha una convergenza del second'ordine.

% pertanto si ha zerostabilità.
% attenzione, stavolta certi h ci portavano fuori dalla regione di
% stabilità. ma erano comunque sensibilmente grandi!