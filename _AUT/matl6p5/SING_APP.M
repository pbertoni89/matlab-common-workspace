%updated 28/4/2004
warning off
format compact
format short g
if exist('num_appr')
	if isempty(find(num_appr~=0)) | size(num_appr,1)==0
 	  clc;
	  fprintf('Il sistema approssimante non è stato inserito\n');
	else	
        zeri=roots(num_appr)';
		zeri=zeri(:);
        zeri=roots(num)';
		zeri=zeri(:);
        if ~isempty(zeri)
            zeri
        end
		poli=roots(den_appr)';
		poli=poli(:);
                if ~isempty(poli)
            poli
        end
		x_n=find(num_appr~=0);x_d=find(den_appr~=0);
		guadagno=num_appr(x_n(size(x_n,1),size(x_n,2)))/den_appr(x_d(size(x_d,1),size(x_d,2)))
		ritardo=T_appr
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
else clc;
	fprintf('Il sistema approssimante non è stato inserito\n');
end;
clear poli zeri guadagno man ritardo guadagno x_n x_d
return
