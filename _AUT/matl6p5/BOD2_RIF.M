warning off
if ~exist('T')
	clc;
	fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
else 
	if T~=0 
		clc;
		fprintf('Analisi in anello chiuso non disponibile per sistemi che presentano ritardo\n');
	else 
		if ~(exist('num_c'))| ~(exist('num')) 
			clc;
	 		fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
		elseif isempty(find(num_c~=0))| size(num_c,1)==0 | isempty(find(num~=0)) | size(num,1)==0  
			clc;
 			fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
		else 
			num_cl=conv(num,num_c);
			diff=size(conv(den,den_c),2)-size(conv(num,num_c),2);
			d=conv(den,den_c); n=conv(num,num_c);
			if diff>0 
				d=conv(den,den_c);
				n=[zeros(1,diff) n];
			elseif diff<0 n=conv(num,num_c); d=[zeros(1,diff) d];
			end;
			den_cl=d+n;
			grafico(1,0,num_cl,den_cl,0);
			num_cl;
			den_cl;
		end;	
	end;
end;
clear num_cl den_cl d n diff
return	
