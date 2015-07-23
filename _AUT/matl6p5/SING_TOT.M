%updated 28/4/2004
warning off
format compact
format short g
if (~exist('num_c') | ~exist('num'))
	clc;
	fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
elseif isempty(find(num_c~=0)) | size(num_c,1)==0 | isempty(find(num~=0)) | size(num,1)==0 
 	clc;
	fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
else
	num_tot=conv(num,num_c);
	den_tot=conv(den,den_c);
	zeri=roots(num_tot)';
	zeri=zeri(:);
    if ~isempty(zeri)
        zeri
    end
    poli=roots(den_tot)';
	poli=poli(:);
    if ~isempty(poli)
        poli
    end
	x_n=find(num_tot~=0);x_d=find(den_tot~=0);
	guadagno=num_tot(x_n(size(x_n,1),size(x_n,2)))/den_tot(x_d(size(x_d,1),size(x_d,2)))
	if ~isempty(poli)
		figure;
		man=gcf;
		set(man,'numbertitle','off');
		set(man,'name','Singolarità');
		pzmap(poli,zeri);
		%grid
		title('poli x e zeri o');
		xlabel('asse reale'); ylabel('asse immaginario');
	end;
end;
clear poli zeri guadagno num_tot den_tot man x_n x_d
return
