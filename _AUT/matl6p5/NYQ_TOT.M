warning off
if ~(exist('num_c'))| ~(exist('num')) 
   clc;
   fprintf('Il sistema e/o il controllore non sono stati inseriti\n');   
elseif isempty(find(num~=0)) | size(num,1)==0 | isempty(find(num_c~=0)) | size(num_c,1)==0
   clc;
   fprintf('Il sistema e/o il controllore non sono stati inseriti\n');
else 
   num_tot=conv(num,num_c);
   den_tot=conv(den,den_c);
   sys=tf(num_tot,den_tot);
   sys=minreal(sys);
   num_tot=cell2mat(get(sys,'num'));
   den_tot=cell2mat(get(sys,'den'));
   if  ~isempty(roots(num_tot)) | ~isempty(roots(den_tot)) | T~=0
      grafico(2,0,num_tot,den_tot,T);
   else 
      clc;
      fprintf('Il sistema in anello aperto è un guadagno puro senza ritardo\n');
   end;
   clear num_tot den_tot
end;


