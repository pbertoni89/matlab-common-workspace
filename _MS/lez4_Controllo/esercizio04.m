%dx=Ax+B*(K(xeq-x)+ueq) --> dx=(A-B*K)*x +B*(K*xeq+ueq)
%A_new=A-BK
%B_new=B(-Kxeq+ueq)

%dx=A_new*x+B_new*u

%in matlab per calcolare K bisogna fare K_vero=-K_calcolato_da_matlab

%ora gli autovalori di A_new dovrebbero essere [L1 L2]
%per quali K questo avviene?
%problema di algebra risolvibile

%A+B*K=2x2+2x1*1x2
%K deve essere una matrice 1x2 per far quadrare tutto

%A_new=A+[k1 k2; 0 0]; --> A_new=[2+k1 3+k2;4 1 ]

%dobbiamo ora calcolare gli autovalori... det(A-lambdaI)=0
eig(A_new)

%oppure matematicamente...
%(L-2-k1)*(L-1)-(3-k2)*(-4)=0 => voglio che le soluzioni siano L1 e L2 da
%L^2 + (-2-k1-1)*L +(2+k1-12-4*k2)=0

%polinomio desiderato
%(L-L1)*(L-L2)=0
%L^2+(-L1-L2)*L+L1*L2=0

% da cui:
%1=1
%(-2-k1-1)=(-L1-L2)
%L1*L2=(2+k1-12-4*k2)
%e risolviamo il sistema tramite A\b ;)

%k1=-3+L1+L2
%k2=(2+k1-L2-L1*L2)/4

%per verifica facciamo eig(A_new)







