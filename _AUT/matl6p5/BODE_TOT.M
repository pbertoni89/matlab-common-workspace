warning off
if ~(exist('num_c'))| ~(exist('num')) 
		clc;
 		fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
elseif isempty(find(num~=0)) | size(num,1)==0 | isempty(find(num_c~=0)) | size(num_c,1)==0
		clc;
 		fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
else 
		num_tot=conv(num,num_c);
		den_tot=conv(den,den_c);
		grafico(1,0,num_tot,den_tot,T);
		clear num_tot den_tot
end;

