%pioggia

z = [276 201 323 214 218 333 262 930 307 449]';
x = [36525 45227 57442 70737 69737 70477 83987 105737 107207 129237]';
y = [24498 3524 3139 7504 39479 59794 39204 53954 43104 48904]';
p = [1615 1547 1565 1355 1408 1462 1112 1008 1095 869]';


% az+b

%definizione della matrice M
M=[z ones(10,1)];  

% Calcolo del vettore contenente i parametri del modello (v)
v = (inv(M'*M))*M'* p;

%coefficienti della retta
a=v(1)
b=v(2)


%% ax + by +c

M2=[x y ones(10,1)];  

% Calcolo del vettore contenente i parametri del modello (v)
v2 = (inv(M2'*M2))*M2'* p;

%coefficienti della retta
a2=v2(1)
b2=v2(2)
c2=v2(3)



%% =ax+by+cz+d

M3=[x y z ones(10,1)];  

% Calcolo del vettore contenente i parametri del modello (v)
v3 = (inv(M3'*M3))*M3'* p;

%coefficienti della retta
a3=v3(1)
b3=v3(2)
c3=v3(3)
d3=v3(4)
