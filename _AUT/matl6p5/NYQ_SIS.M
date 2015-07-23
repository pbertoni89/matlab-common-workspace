warning off
if ~(exist('num')) 
   clc;
   fprintf('Il sistema non è stato inserito\n');
elseif isempty(find(num~=0)) | size(num,1)==0
   clc;
   fprintf('Il sistema non è stato inserito\n');
else
   sys=tf(num,den);
   sys=minreal(sys);
   num_temp=cell2mat(get(sys,'num'));
   den_temp=cell2mat(get(sys,'den'));
   if ~isempty(roots(num_temp)) | ~isempty(roots(den_temp)) | T~=0
      grafico(2,0,num_temp,den_temp,T);
   elseif isempty(roots(num_temp)) & isempty(roots(den_temp))  & T==0
      clc;
      fprintf('Il sistema è un guadagno puro senza ritardo\n');
   end
   clear num_temp den_temp
end;

