%% S[.]= x(t)*rect((t-1)/2)

function back = S1( t, x )

 tau=t;
 back= zeros(1,length(t));

for i=1:length(t)
   y= my_rect( (t(i)-tau+1)/2 );
   back(i)= riemannInt(tau, tau(1), tau(length(tau)), x.*y );    
end
    
end

