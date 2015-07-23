function Nnew = handleN( Nold, med_p, var_p )
%HANDLEN Generates a new U vc with mean and variance as specified.

    medNold = mean(Nold);
    
    Nnew = Nold * sqrt(var_p) + ( med_p - medNold );

end
