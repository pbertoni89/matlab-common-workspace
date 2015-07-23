
which secondo;

load wspace;

%------------------------------------------------------------------------
%Siano:  

    %A viene caricata dal wspace

    B = zeros(1,3)+2; % inizializzazione con 0
%------------------------------------------------------------------------

% 1) Moltiplicare riga per colonna il vettore B con la terza colonna di A e metterlo in x

    x = B*A(:,3);

%------------------------------------------------------------------------

% 2) Visualizzare la seguente riga: "x vale : " seguito dal valore di x (usare printf)

    fprintf('     x vale %d\n\n', x);

%------------------------------------------------------------------------

% 3) Creare il vettore colonna v definito da x elevato alla seconda riga di A; visualizzare con disp

    v = x.^(A(2,:)); disp(v);
%------------------------------------------------------------------------

% 4) Creare v1, moltiplicando B e v elemento per elemento, visualizzandolo senza punto e virgola

    v1 = B.*v
