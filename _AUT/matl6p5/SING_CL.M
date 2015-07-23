%updated 28/4/2004
warning off
format compact
format short g
if ~exist('T')
	clc;
	fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
else 
	if T~=0 
		clc;
		fprintf('Analisi in anello chiuso non disponibile per sistemi che presentano ritardo\n');
	else 
		if (~exist('num_c')==1 | ~exist('num'))
			clc;
			fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
		elseif isempty(find(num_c~=0)) | size(num_c,1)==0 | isempty(find(num~=0)) | size(num,1)==0 
			clc;
			fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
		else 	
			num_cl=1;
			diff=size(conv(den,den_c),2)-size(conv(num,num_c),2);
			d=conv(den,den_c); n=conv(num,num_c);
			if diff>0 
				d=conv(den,den_c);
				n=[zeros(1,diff) n];
			elseif diff<0 n=conv(num,num_c); d=[zeros(1,diff) d];
			end;
			den_cl=d+n;
			poli=roots(den_cl)';
            poli=poli(:);
   			zeri=roots(num_cl);
			zeri=zeri(:);
            if ~isempty(zeri)
                zeri
            end
            if ~isempty(poli)
                poli
            end

			if ~isempty(poli)
				figure;
				man=gcf;
				set(man,'numbertitle','off');
				set(man,'name','Poli');
				pzmap(poli,zeri);
%				grid
				xlabel('asse reale'); ylabel('asse immaginario');
				title('Poli della f.d.t. in anello chiuso ');
			end;
		end;
	end;
end;
clear poli zeri num_cl den_cl man diff d n 
return
