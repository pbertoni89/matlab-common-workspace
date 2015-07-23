clear all; close all; clc;

dy = @(t,y)  [ -3*y(1) - 1*y(2) + sin(t) ;  
			   +1*y(1) - 5*y(2) -   2    ];
t0 = 0;
T  = 10; 

%% studio senza stabilità (EE, EI) (da eqdiff2.pdf)
y0 = [1,1];
h = 1.e-3;
n = ceil((T-t0)/h);
[ t y_ee ] =  eul_expl(dy, [t0 T], y0, n);
[~, y_ei ] =  eul_impl(dy, [t0 T], y0, n);

figure(1); clf;
subplot(2,1,1); plot(t,y_ee(1,:),'r'); hold on; plot(t,y_ei(1,:),'b');
legend('y_1^{EE}','y_1^{EI}'); 
subplot(2,1,2); plot(t,y_ee(2,:),'r'); hold on; plot(t,y_ei(2,:),'b');
legend('y_2^{EE}','y_2^{EI}'); 

%% studio con stabilità di EE: movimento libero
y0 = [1,2];
A = [ -3 -1 ; 1 -5]; 
avals = eig(A);
H0 = -2*real(avals)./(abs(avals).^2);
fprintf('h scelto dev''essere minore di %f \n', min(H0));
		   
H = [ .1 .5 .8]; N = ceil( (T-t0)./H ); i=0;

dy_libero = @(t,y) [ -3*y(1) - 1*y(2) ;  
			         +1*y(1) - 5*y(2) ];
		  
for h = H, i=i+1;
	[ t y ] =  eul_expl(dy_libero, [t0 T], y0, N(i));
	figure(2); subplot(1,3,i); title(['libero, ','h=',num2str(h)]);
	plot(t,y(1,:),'r'); hold on; plot(t,y(2,:),'b'); 
	legend('y_1','y_2');
end
% è chiaro che vi sono due h che non rispettano il comportamento di
% assoluta stabilità della soluzione esatta.
	
%% studio con stabilità di EE: movimento libero + forzato
i = 0;
for h = H, i=i+1;
	[ t y ] =  eul_expl(dy, [t0 T], y0, N(i));
	figure(3); subplot(1,3,i); title(['+forzato, ','h=',num2str(h)]);
	plot(t,y(1,:),'r'); hold on; plot(t,y(2,:),'b'); 
	legend('y_1','y_2');
end
% nella soluzione esatta il limite NON è nullo, essendovi
% una forzante esterna non nulla.
% con il valore accettabile di h questo si può osservare;
% con i valori non ammissibili questo viene perso.