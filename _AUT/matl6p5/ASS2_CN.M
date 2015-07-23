warning off
again = 1;
num_c=0;K=0;D=0;I=0;
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
	  fprintf('\n1. Inserimento del PID: K+I/s+Ds');
	  fprintf('\n2. Esci\n');
	  scelta = input('Scelta:  ');
	
	if scelta == 1  
	
		  flag = 1;
		  while flag == 1
			fprintf('\nAzione proporzionale\n');
		        K= input('costante di proporzionalità:  ');
			if size(K,1) == 1 & size(K,2) == 1 
				if imag(K)==0
			        	flag = 0;
			        end
			end
		  end


		  flag = 1;
		  while flag == 1
			fprintf('\nAzione integrale\n');
	  		I = input('costante azione integrale:  ');
	    		if size(I,1) == 1 & size(I,2) == 1 
				if imag(I)==0
			        	flag = 0;
			        end
			end        
		  end

		  flag = 1;
	  	  while flag == 1
			fprintf('\nAzione derivativa\n');
		  	D= input('costante azione derivativa:  ');
			if size(D,1) == 1 & size(D,2) == 1 
				if imag(D)==0
			        	flag = 0;
			        end
			end		 
	  	  end

		  if I==0
			num_c=[D K]; den_c=1; 
		  else
		  	num_c=[D K I]; den_c=[1 0]; 
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
	rden_c=roots(den_c);
	rnum_c=roots(num_c);
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
		num_c=0;K=0;D=0;I=0;
		den_c=1;
	end;
   end;

end; %while again

end %secondo else

end %primo else

clear Ti Td HF Kp  rden_c rden rnum_c rnum rnum_inst rnum_c_inst rden_inst rden_c_inst sempl_inst z p again flag k scelta  zsup psup trova

return;
