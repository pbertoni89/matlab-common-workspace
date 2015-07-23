% VENTURINI NICOLA - 21|09|2011
% ESERCITAZIONE 1
% Elaborazione Numerica dei Segnali

close all; clear; 
n=-10:1:10;

% ESERCIZIO 1
% (i)
A=2;
figure(1);
x1=A*impulso(n);
stem(n,A*impulso(n),'r','filled','linewidth',4);

% (ii)
B=3;
hold on
stem(n,B*step(n),'b','filled');

% (iii)
C=4;
N=3;
x3=C*rectN(n,N);
stem(n,C*rectN(n,N),'g','filled');

% (iv)
a=0.8;
x4 = (a.^n).*step(n);
stem(n,x4,'k','filled');

% (v)
D=5;
fo=0.3;
stem(n,D*sin(2*pi*fo*n),'m');
grid on;
hold off;
pause;

% (vi)
x6=shift(x1,n,-4);
figure(2);
stem(n,x6,'c');

% (vii)
x7=ribalta(x3,n);
figure(3);
stem(n,x7,'k');

pause;
close all;

% (viii)
x8 = ribalta(shift(x4,n,-3),n);
figure(4);
stem(n, x8,'b');

% (ix)
I=3;
x9A=espansione(x8,n,I);
figure(5);
stem(n,x9A,'k');

D=2;
x9B=decimazione(x8,n,D);
figure(6);
stem(n,x9B,'b');
pause;
close all;

% ESERCIZIO 2
% (i)
n1=-20:20;
x=(x3')*ones(1,3);
x=x(:);
n2=1:length(x);

figure(7);
stem(n2,x,'k')

% (ii)

    A1=4;
    N1=5;
    r1=A1*rectN(n,N1);
        A2=3;
        N2=3;
        r2=A2*rectN(n,N2);
        
c1=conv(r1,r2);
figure(8);
stem(n1,c1,'k');

c1_fin=my_window(c1,n);
figure(9);
stem(n,c1_fin,'k');













