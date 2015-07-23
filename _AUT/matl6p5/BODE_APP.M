warning off
if ~(exist('num_appr')) 
		clc;
 		fprintf('Il sistema approssimante non è stato inserito\n');
elseif isempty(find(num_appr~=0)) | size(num_appr,1)==0
		clc;
 		fprintf('Il sistema approssimante non è stato inserito\n');
else 
		grafico(1,0,num_appr,den_appr,T_appr);
end;


