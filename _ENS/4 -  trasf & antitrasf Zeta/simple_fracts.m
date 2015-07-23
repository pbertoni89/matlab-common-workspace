function [ seq, segnale ] = simple_fracts( num_mins, den, n )
%[ seq, segnale ] = simple_fracts( num_mins, den, n ) 
%              Given the polynomials corresponding to a transfer function with single poles, 
%              given n the axis of the samples,
%                   It returns the sequence and the subsequences which corresponds to H(z).

    % basi di finestra IIR per segnali ricostruiti
    caus = step(n);                                    % u(n)
    anti = my_rotate( my_shift( step(n),n,1), n );     % u(-n-1)
    segnale = zeros(1,length(n));                      % segnale x(n) FINALE

    [ fracts Hupoles k ] = residue(num_mins,den); % RESIDUI IN Z- !
    lupoles = length(Hupoles);

    rocs = 0:lupoles;  % #rocs = #Hupoles + 1
    lrocs = length(rocs);

    % presento possibili ROC
    fprintf('Trasformata propria a poli singoli. Ho isolato %d Regioni di Convergenza.\n\n', lrocs);
    fprintf(' 1)  |z| < %.2f \n ', Hupoles(1)); % regione più interna
    for i = 2:lupoles
     fprintf('%d) %.2f < |z| < %.2f \n ', i, Hupoles(i-1), Hupoles(i));  % corone circolari
    end
    fprintf('%d)  |z| > %.2f \n ', lrocs , Hupoles(lupoles) ); % regione più esterna

    % richiesta input ROC
    fprintf('Scegliere una regione dove trasformare. [1... %d]\n\n ', lrocs);
    roc = input('');
    while( roc<1 || roc>lrocs )
     fprintf('Valore non ammesso!\n'); 
     roc = input('');
    end


   % contiene in righe le sequenze che andranno a costituire il segnale
   seq = zeros( lupoles, length(n) ); 

    if(roc==1)         % cerchio più interno  0 < |z| < p1
        for j = 1 : lupoles
            seq(j,:) = fracts(j) * (-1) * (( Hupoles(j) ).^n) .* anti;
        end
    elseif(roc==lrocs) % cerchio esterno  pn < |z| < inf
        for j = 1 : lupoles
            seq(j,:) = fracts(j) * (+1) * (( Hupoles(j) ).^n) .* caus;
        end
    else               % corona intermedia  pi < |z| < pi+1
        for j = 1 : lupoles
            if Hupoles(j) <= Hupoles(roc-1)
                seq(j,:) = fracts(j) * (+1) * (( Hupoles(j) ).^n) .* caus;
            else
                seq(j,:) = fracts(j) * (-1) * (( Hupoles(j) ).^n) .* anti;
            end
        end
    end

    for i = 1 : lupoles
        segnale = segnale + seq(i,:);
    end


end

