%definizione dei vettori x1,x2 ed il vettore delle uscite y
x1=[3 2 1 3]';
x2=[5 2 2 3]';
y=[7 10;4 5;2 3;6 6];

%definizione della Matrice M
M=[x1 x2];  

% Calcolo del vettore contenente i parametri del modello (t)
t = (inv(M'*M))*M'* y;

%coefficienti delle due curve
a=t(1,1)
b=t(2,1)
c=t(1,2)
d=t(2,2)

