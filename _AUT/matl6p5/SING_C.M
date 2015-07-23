%updated 28/4/2004
warning off
format compact
format short g
if exist('num_c')
	if isempty(find(num_c~=0)) | size(num_c,1)==0 
 	  	clc;
		fprintf('Il sistema di controllo non è stato inserito\n');
	else 
		zeri=roots(num_c)';
		zeri=zeri(:);
        if ~isempty(zeri)
            zeri
        end
		poli=roots(den_c)';
		poli=poli(:);
        if ~isempty(poli)
            poli
        end
		x_n=find(num_c~=0);x_d=find(den_c~=0);
		guadagno=num_c(x_n(size(x_n,1),size(x_n,2)))/den_c(x_d(size(x_d,1),size(x_d,2)))
		if ~isempty(poli)
			figure;
			man=gcf;
			set(man,'numbertitle','off');
			set(man,'name','Singolarità');
			pzmap(poli,zeri);
%			grid
			title('poli x e zeri o');
			xlabel('asse reale'); ylabel('asse immaginario');
		end;
	end
else 
	clc;
	fprintf('Il sistema di controllo non è stato inserito\n');
end;
clear poli zeri man x_n x_d guadagno
return
