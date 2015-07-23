% Patrizio 01 marzo 2011


which patrizio;

clear; clc;     % pulizie

%1  generare un vettore COLONNA t2 che va da 0 a 2 con passo 0.1

    t2= 0:.1:2;     % vect riga implicita

    t2 = t2';       % trasposta

    %disp(t2);              % visualizzo senza uguale

    save wspace;

%2  generare una matrice E quadrata 4x4 con ogni elemento pari a -1
    load wspace; clc;

    E= ones(4,4).*(-1);  %ELSE  E= zeros(4,4)-1  % punto-per

    E
    
    save wspace; pause;

%3  aggiungere una quinta colonna alla matrice E tutta nulla
    
    ADD= zeros(4,1);
    
    E= [E;ADD']' ; % aggiungo la riga "colonna trasposta", e traspongo tutto
            
    E
    
    save wspace; pause;
    
%4  definire la matrice F come la seconda e la terza riga di E
    
    F= [ E(2,:) ; E(3,:)]; 
    
    F
    
    save wspace; pause;
    
%5   cancellare da F la prima colonna.

    F(:,1)= [] ;

    F
    
%RMB    parentesi quadre: aggiungere elementi/righe/colonne
%       parentesi tonde:
    
    
return;         % termina script