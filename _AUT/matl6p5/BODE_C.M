warning off
if ~(exist('num_c')) 
		clc;
 		fprintf('Il sistema di controllo non è stato inserito\n');
elseif isempty(find(num_c~=0)) | size(num_c,1)==0
		clc;
 		fprintf('Il sistema di controllo non è stato inserito\n');
else 
		grafico(1,0,num_c,den_c,0);
end;

