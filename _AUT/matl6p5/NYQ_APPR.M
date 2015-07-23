warning off
if ~(exist('num_appr')) 
   clc;
   fprintf('Il sistema non è stato inserito\n');
elseif isempty(find(num_appr~=0)) | size(num_appr,1)==0
   clc;
   fprintf('Il sistema approssimante non è stato inserito\n');
else
   sys=tf(num_appr,den_appr);
   sys=minreal(sys);
   num_temp=cell2mat(get(sys,'num'));
   den_temp=cell2mat(get(sys,'den'));
   if ~isempty(roots(num_temp)) | ~isempty(roots(den_temp)) | T_appr~=0
      grafico(2,0,num_temp,den_temp,T_appr);
   elseif isempty(roots(num_temp)) & isempty(roots(den_temp))  & T_appr==0
      clc;
      fprintf('Il sistema approssimante è un guadagno puro senza ritardo\n');
   end;
   clear num_temp den_temp
end


