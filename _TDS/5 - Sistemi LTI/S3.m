%% S[.] = x(t/2)

function back = S3(t, m )  % dove m è il coefficiente di cambio scala

 tau= t;

 for i=1:length(t)
    tau(i)= (1/m)*t(i);
     
 end
  
 back= tau;
    
end
