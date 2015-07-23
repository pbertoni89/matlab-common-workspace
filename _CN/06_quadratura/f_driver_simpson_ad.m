clear all; close all; clc; format shorte
hmin = 1.e-3;

a = 0;
b = 1;
tol = 1.e-3;

f = @(x) 1./((x-.3).^2+.01) + 1./((x-.9).^2+.04)-6;

[ Js n ] = simpson_ad(f,a,b,tol,hmin);
n = unique(n); % clean doppioni
nn = diff(n); % serie delle differenze
steps = unique(nn);

[Js_mlab var1 ] = quad(f,a,b,tol); % aggiungere trace =! 1
Js_mlab;
Js_lbto = quadl(f,a,b);

x_ex = linspace(a,b,1000); y_ex = f(x_ex); 
figure(1);
plot(x_ex,y_ex,'b'); hold on;
plot(n, zeros(1,length(n)), '+r');

z = zeros(1,3); o = ones(1,3);
for s = 1:length(steps)
	encore = 1;
	while encore==1
		C = round(rand(1,3));
		if ~(isequal(C,z) || isequal(C,o))
			encore = 0;
		end
	end
	idx = find(nn==steps(s)); ntocol = n(idx); % n da colorare
	nspace = linspace(ntocol(1),ntocol(end),length(ntocol));
	handlecol = area(ntocol,f(nspace));
	set(handlecol(1), 'FaceColor', C);
end

%% 2
a = 0;
b = 2;
tol = 1.e-6;

f = @(x) 1./(x.^3-2*x-5);

[ Js n ] = simpson_ad(f,a,b,tol,hmin);
Js
n = unique(n);
Js_mlab = quad(f,a,b,tol)
Js_lbto = quadl(f,a,b)

x_ex = linspace(a,b,1000); figure(2);
plot(x_ex,f(x_ex),'b'); hold on;
plot(n, zeros(1,length(n)), '+r');
% purtroppo f(iv)(2) = ?284544 molto grande in modulo 
%	=> tanti steps verso la fine. Il risultato però è valido

format