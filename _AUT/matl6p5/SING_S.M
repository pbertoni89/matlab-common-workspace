%updated 28/4/2004
warning off
format compact
format short g
if exist('num')
	if isempty(find(num~=0)) | size(num,1)==0 
		clc;
		fprintf('Il sistema non è stato inserito\n');
	else	
		zeri=roots(num)';
		zeri=zeri(:);
        if ~isempty(zeri)
            zeri
        end
        poli=roots(den)';
		poli=poli(:);
        if ~isempty(poli)
            poli
        end
		x_n=find(num~=0);x_d=find(den~=0);
		guadagno=num(x_n(size(x_n,1),size(x_n,2)))/den(x_d(size(x_d,1),size(x_d,2)))
		ritardo=T
		if ~isempty(poli)	
			figure;
            man=gcf;
			set(man,'numbertitle','off');
			set(man,'name','Singolarità');
			pzmap(poli,zeri);
			%grid;
			title('poli x e zeri o');
			xlabel('asse reale'); ylabel('asse immaginario');
		end;
	end
else
	clc;
	fprintf('Il sistema non è stato inserito\n');
end

clear poli zeri man guadagno ritardo x_n x_d
return
