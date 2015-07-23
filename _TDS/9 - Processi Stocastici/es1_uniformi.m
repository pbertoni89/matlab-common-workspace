
clear all; close all;

dim= 10000;

%% i
U = rand( 1, dim );

medU = mean(U);
varU = var(U);

%% ii 
U1 = U*3;     % unif[0,3]

medU1 = mean(U1);
varU1 = var(U1);

%% iii
U2 = U*2 + 3;  % unif[3,5]

medU2 = mean(U2);
varU2 = var(U2);

%% iv

%  (1/2) dei casi: rect tra [-1,1]  
%  (1/4) dei casi: delta in 2
%  (1/4) dei casi: delta in -2

U3= zeros(1,dim);

for k=1:dim

   if ( U(k) < .25 )
       U3(k) = -2;
   else
       if ( U(k) > .75 )
           U3(k) = 2;
       else
           U3(k) = rand(1,1) *2 -1 ;  % unif [-1,1] con metà dei valori di U
       end
   end
   
end

medU3= mean(U3);
varU3= var(U3);

%% v


Z= zeros(1,dim);

for k=1:dim

   if ( U(k) < .5 )
       Z(k) = sqrt(2*U(k))-1;
   else
       Z(k) = 1- sqrt( 2-2*U(k));          %    sqrt( a^2 )  ===== abs( a ) !!!!!
   end
   
end

medZ= mean(Z);
varZ= var(Z);

% metodo guerrini - VALE PER QUALSIASI PDF

% riemannInt(alpha, -10, -8, f_Zi) = 1 = evento certo OKOKOK

% provo con la funzione trasfVC( x, U, pdf)  

dalpha = .001;
alpha = -10:dalpha:10;

pdf= tri(alpha);

prova_vc= trasfVC(alpha,U,pdf);

pause;
myHist1D(prova_vc);
pause;


% inversa: da tri(x) passo alla uniforme su [0,1]

orig = tri(alpha); % parto da questa pdf a trasformare

 XX = zeros(dim,1);

f_XX = my_rect(alpha-.5);   % uniforme [0,1]
F_XX = zeros(size(alpha));
for i = 2:length(alpha)
    F_XX(i) = F_XX(i-1)+f_XX(i)*dalpha;   % sommatoria integrale
end

zeroIndex = sum(F_XX==0);
oneIndex = sum(F_XX==F_XX(end));
F_XXclip = F_XX(zeroIndex:end-oneIndex+1);
alphaClip = alpha(zeroIndex:end-oneIndex+1);
for u = 1:dim             %parto da una pdf~tri, non ~rect
    yIndex = abs(F_XXclip-orig(u))==min(abs(F_XXclip-orig(u)));
    XX(u) = alphaClip(yIndex);
end


%% Plots

myHist1D(U);
myHist1D(U1); 
myHist1D(U2);
myHist1D(U3);
myHist1D(Z);
myHist1D(XX);

return;