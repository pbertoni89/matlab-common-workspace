clear all; close all; clc;

x = [1 3 5 8 10]';
y = [3 5.66 11.84 17.67 21.65]';
%[x, I] = sort([276 201 323 214 218 333 262 307 ]); x = x';
%y = [1615 1547 1565 1355 1408 1462 1112 1095 ]';
%y = y(I);

xext = linspace(x(1), x(end), 50);

%% 1
v = ones(length(x),1);
A1 = [ x v ];
a1 = A1\y; 
%IMP IMP IMP IMP == (A1'*A1)\(A1')*y == polyfit(x,y,1)

% yr1 = polyval(a1,x); per disegnare retta bastano due punti
yr1_ext = polyval(a1,xext);

%% 2 (LS non lineari)
a2 = polyfit(x,y,2); % m = n degenera nell'interpolazione!!!!
					 % m > n => warning, e posto m = n
yr2_ext = polyval(a2,xext);

%% 3 (LS non lineari)
A3 = [ x.^3 x.^2 x v ];
a3 = A3\y;
yr3_ext = polyval(a3,xext);

%% 4 (LS non lineari)
A4 = [ x.^4 x.^3 x.^2 x v ];
a4 = A4\y;
yr4_ext = polyval(a4,xext);

%% plot finali
plot(xext, yr1_ext, 'b'); hold on;
plot(xext, yr2_ext, 'g');
plot(xext, yr3_ext, 'r');
plot(xext, yr4_ext, 'c');
plot(x,y,'bo');
legend('r_1^{ext}','r_2^{ext}','r_3^{ext}', ...
	   'r_4^{ext}','x_i,y_i')