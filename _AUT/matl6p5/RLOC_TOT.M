warning off
if ~(exist('num_c'))| ~(exist('num')) 
		clc;
 		fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
elseif sum(num_c==0)|sum(num==0) 
		clc;
 		fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
else 
		num_tot=conv(num,num_c);
		den_tot=conv(den,den_c);
		grafico(3,0,num_tot,den_tot,T)
		clear num_tot den_tot		
end

