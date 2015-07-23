warning off
again = 1; 
num_c=0; den_c=1;
num=0; den=1; T=0;
while again == 1
  clc;
  fprintf('\n');
  fprintf('Inserimento del sistema:\n');
  fprintf('\n1. zeri-poli-guadagno-ritardo');
  fprintf('\n2. numeratore-denominatore-ritardo');
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
  [num,den] = zp2tf(z,p,k);
  x_n=find(num~=0);x_d=find(den~=0);
  if sign(num(x_n(size(x_n,1),size(x_n,2)))*den(x_d(size(x_d,1),size(x_d,2))))~=sign(k)
	num=-num;
  end
   flag=1;	
   while flag == 1
      T= input('Inserisci il ritardo(>=0)  ');
      if (T>=0 & size(T)==[1 1] & isempty(find(imag(T)~=0)))
       flag = 0;
      end
   end  

   [num,den]=simplify(num,den);

   elseif scelta==2

    flag = 1;
    while flag == 1
      num = input('Inserisci il numeratore della funzione di trasferimento:  ');
      if size(num,1) == 1 & size(num,2)>0 & sum(num~=0)
        flag = 0;
      end
      if ~isempty(num) & ~isempty(find(imag(num)~=0)) 
	flag=1;	
	fprintf('\nIl polinomio introdotto deve essere a coefficienti reali\n');
      end
    end

    flag = 1;
    while flag == 1
      den = input('Inserisci il denominatore della funzione di trasferimento:  ');
      if size(den,1) ==1 & isempty(find(imag(den)~=0)) & sum(den~=0)
	if sum(den~=0)~=0 & size(roots(den),1) >= size(roots(num),1)
           flag = 0;
	end
      end
      if ~isempty(den) & ~isempty(find(imag(den)~=0)) 
	flag=1;	
	fprintf('\nIl polinomio introdotto deve essere a coefficienti reali\n');
      end
    end 
 
   flag=1;	
   while flag == 1
      T= input('Inserisci il ritardo(>=0)  ');
      if (T>=0 & size(T)==[1 1] & isempty(find(imag(T)~=0)))
       flag = 0;
      end
   end  
   
  [num,den]=simplify(num,den);

  else
    fprintf('\n'); 
    if isempty(find(num~=0)) | size(num,1)==0
	clc;
	fprintf('Il sistema non è stato inserito\n');
    end;
    again=0;    
  end;
  if ~isempty(find(num~=0)) 
	sempl_inst=0;
	if scelta==1 
		rden=p;
		rnum=z; 
	else
		rden=roots(den);
		rnum=roots(num);
	end
	rnum_inst=rnum(find(real(rnum)>=0));
	rden_inst=rden(find(real(rden)>=0));
	if (~isempty(rnum_inst) & ~isempty(rden_inst))
		rden_inst=rden_inst(:)';
		rnum_inst=rnum_inst(:)';
		for k=1:size(rnum_inst,2)
			sempl_inst=sempl_inst+sum(rnum_inst(k)==rden_inst);
		end
	end

	if sempl_inst~=0 
		again=1;  
		clc;
		fprintf('Semplificazioni tra poli e zeri instabili\n')
		fprintf('premere un tasto per continuare\n');
		pause;
		num=0;
		den=1;
		T=0;
	end;
   end;

end; %while again

clear x_n x_d rden rnum rnum_inst rden_inst sempl_inst z p again flag k scelta  zsup psup trova

return;


