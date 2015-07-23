warning off
if (exist('num_c')==1 & exist('den_c')==1 & exist('num') & exist('den') & exist('T'))
	if (size(num_c,1)==0|size(den_c,1)==0|size(num,1)==0|size(den,1)==0|size(T)~=[1 1])
 	  fprintf('dati non inseriti correttamente\n');
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
		grafico(1,0,num_cl,den_cl,T);
		clear num_cl diff d n 	den_cl
	end;
else 
       fprintf('\n');
       fprintf('il sistema e/o il controllore non sono stati inseriti\n');
end;
