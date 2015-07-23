warning off
again = 1;
num_c=0;
den_c=1;
if ~(exist('num'))
	clc;
	fprintf('Inserire prima la f.d.t. del sistema\n');
else %primo else

if isempty(find(num~=0)) | size(num,1)==0 
	clc;
	fprintf('Inserire prima la f.d.t. del sistema\n');
else %secondo else

while again == 1
  clc;
  fprintf('\n');
  fprintf('Inserimento del controllore:\n');
  fprintf('\n1. zeri-poli-guadagno');
  fprintf('\n2. numeratore-denominatore');
  fprintf('\n3. esci\n');
  scelta = input('Scelta:  ');

  if scelta == 1  

    flag = 1;
	while flag == 1
	  z = input('Inserisci gli zeri del sistema:  ');
  	  if size(z,1) == 1 
          flag = 0;
	  end
	  if (isempty(z)) 
	  flag = 0;
	  end
	  if polreal(z)==0 
		flag=1; 
		fprintf('\nIl polinomio di cui gli zeri introdotti sono radici deve essere a coefficienti reali\n');
	  end
        end

    flag = 1;
    while flag == 1
	p = input('Inserisci i poli del sistema:  ');
	if size(p,2) >= size(z,2)
  	  if size(p,1) == 1 
          flag = 0;
	  end
	  if (isempty(p)) 
	  flag = 0;
	  end
	end
	if polreal(p)==0 
		flag=1; 
		fprintf('\nIl polinomio di cui i poli introdotti sono radici deve essere a coefficienti reali\n');
        end
    end
  flag = 1;
  while flag == 1
    k = input('Inserisci il guadagno del sistema:  ');
    if size(k,1) == 1 & size(k,2) == 1 
	if k ~= 0 & imag(k)==0
        flag = 0;
        end
    end        
  end

if ~isempty(z)
	zsup=z;
	trova=find(z==0);trova=trova(:)';
	if ~isempty(trova)	zsup(trova)=ones(1,size(trova,2)); end
	k=k/abs(det(diag(zsup)));
  end
  if ~isempty(p)
	psup=p;
	trova=find(p==0);trova=trova(:)';
	if ~isempty(trova)	psup(trova)=ones(1,size(trova,2)); end
  	k=k*abs(det(diag(psup)));
  end

  z=z(:);
  p=p(:);
  [num_c,den_c] = zp2tf(z,p,k);
  x_n=find(num_c~=0);x_d=find(den_c~=0);
  if sign(num_c(x_n(size(x_n,1),size(x_n,2)))*den_c(x_d(size(x_d,1),size(x_d,2))))~=sign(k)
	num_c=-num_c;
  end
  [num_c,den_c]=simplify(num_c,den_c);

  elseif scelta==2

    flag = 1;
    while flag == 1
      num_c = input('Inserisci il numeratore della funzione di trasferimento:  ');
      if size(num_c,1) == 1 & size(num_c,2)>0 & sum(num_c~=0)
        flag = 0;
      end
      if ~isempty(num_c) & ~isempty(find(imag(num_c)~=0)) 
	flag=1;	
	fprintf('\nIl polinomio introdotto deve essere a coefficienti reali\n');
      end
    end
    flag = 1;
    while flag == 1
      den_c = input('Inserisci il denominatore della funzione di trasferimento:  ');
      if size(den_c,1) ==1 & isempty(find(imag(den_c)~=0)) & sum(den~=0)
	if sum(den_c~=0) & size(roots(den_c),1) >= size(roots(num_c),1)
           flag = 0;
	end
      end
      if ~isempty(den_c) & ~isempty(find(imag(den_c)~=0)) 
	flag=1;	
	fprintf('\nIl polinomio introdotto deve essere a coefficienti reali\n');
      end

    end  

  [num_c,den_c]=simplify(num_c,den_c);
  else 
    	fprintf('\n');
    	if isempty(find(num_c~=0)) | size(num_c,1)==0
		clc;
      		fprintf('Il sistema di controllo non è stato inserito\n');
	end;
	again=0;
  end
  if ~isempty(find(num_c~=0))
	sempl_inst=0;
	if scelta==1 
		rden_c=p; rnum_c=z; 
	else
		rden_c=roots(den_c);
		rnum_c=roots(num_c);
	end
	rnum_c_inst=rnum_c(find(real(rnum_c)>=0));
	rden_c_inst=rden_c(find(real(rden_c)>=0));
	if (~isempty(rnum_c_inst) & ~isempty(rden_c_inst))
		rden_c_inst=rden_c_inst(:)';
		rnum_c_inst=rnum_c_inst(:)';
		for k=1:size(rnum_c_inst,2)
			sempl_inst=sempl_inst+sum(rnum_c_inst(k)==rden_c_inst);
		end
	end


	rnum=roots(num);
	rnum_inst=rnum(find(real(rnum)>=0));
	if (~isempty(rnum_inst) & ~isempty(rden_c_inst))
		rden_c_inst=rden_c_inst(:)';
		rnum_inst=rnum_inst(:)';
		for k=1:size(rnum_inst,2)
			sempl_inst=sempl_inst+sum(rnum_inst(k)==rden_c_inst);
		end
	end
	rden=roots(den);
	rden_inst=rden(find(real(rden)>=0));
	if (~isempty(rnum_c_inst) & ~isempty(rden_inst))
		rden_inst=rden_inst(:)';
		rnum_c_inst=rnum_c_inst(:)';
		for k=1:size(rnum_c_inst,2)
			sempl_inst=sempl_inst+sum(rnum_c_inst(k)==rden_inst);
		end
	end
	if sempl_inst~=0 
		again=1;  
		clc;
		fprintf('Semplificazioni tra poli e zeri instabili\n')
		fprintf('premere un tasto per continuare\n');
		pause;
		num_c=0;
		den_c=1;
	end;
   end;

end; %while again

end %secondo else

end %primo else

clear x_n x_d rden_c rden rnum_c rnum rnum_inst rnum_c_inst rden_inst rden_c_inst sempl_inst z p again flag k scelta  zsup psup trova

return;
