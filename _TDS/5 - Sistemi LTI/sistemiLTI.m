
which sistemiLTI;

clear;
close all;
archived=0;

if(archived==0)  % Creo Workspace
    % Assi del tempo e frequenza
    dt= .01; df=dt;
    t= -10:dt:10;
    f= -15:df:15;
    % Sistemi
    y1_S1= zeros(1,length(t));
    y2_S1= y1_S1; y1_S2= y2_S1; y2_S2= y1_S2; y1_S3= y2_S2;
    % Parametri per la linearità
    alpha= 3;
    beta= 2;
    % Segnali
    x1= 2*my_rect(t);
    x2= my_tri(t-1);
    xtot= alpha*x1+beta*x2;
    % Parametro per la tempo-invarianza
    t0= 3;
    x1TI= 2*my_rect(t-t0); 
    % Risposta all'impulso
    T= 2;
    h= my_rect((t-T/2)/T);
    %h= my_rect(t);  % CAPIRE BENE PERCHE' E' DIVERSA DA QUELLA DEI LUCIDI!!! (spazia tra i valori discreti [-pi,0,pi]
  %  xrisp= A*cos( 2*pi*f0 *t + phi);
    
    % Salvataggio del workspace
    archived=1;
    save sistemiLTIworkspace;
else
    load sistemiLTIworkspace;
end

%% LINEARITA' DEI SISTEMI

% S1
y1_S1= S1(t, xtot); % S[a.x1+b.x2]
y2_S1= alpha*S1(t, x1) + beta*S1(t, x2); % a.S[x1]+b.S[x2]

% S2
y1_S2= S2(xtot); % S[a.x1+b.x2]
y2_S2= alpha*S2(x1) + beta*S2(x2); % a.S[x1]+b.S[x2]

% S3
t2= S3(t, 0.5);
y1_S3= xtot; % S[a.x1+b.x2]
temp1 = x1; 
temp2 = x2;
y2_S3 = alpha*temp1+beta*temp2; % a.S[x1]+b.S[x2]

% Plots
figure('name','Linearità dei sistemi');
subplot(2,3,1); plot(t, y1_S1, 'b'); title('$$S1[a.x1+b.x2]$$','Interpreter','latex','FontSize',20);     axis( [-5 5 -1 8] )
subplot(2,3,2); plot(t, y1_S2, 'b'); title('$$S2[a.x1+b.x2]$$','Interpreter','latex','FontSize',20);     axis( [-5 5 -1 60] )
subplot(2,3,3); plot(t2,y1_S3, 'b'); title('$$S3[a.x1+b.x2]$$','Interpreter','latex','FontSize',20);     axis( [-5 5 -1 8] )
subplot(2,3,4); plot(t, y2_S1, 'b'); title('$$a.S1[x1]+b.S1[x2]$$','Interpreter','latex','FontSize',20); axis( [-5 5 -1 8] )
subplot(2,3,5); plot(t, y2_S2, 'b'); title('$$a.S2[x1]+b.S2[x2]$$','Interpreter','latex','FontSize',20); axis( [-5 5 -1 16] )
subplot(2,3,6); plot(t2,y2_S3, 'b'); title('$$a.S3[x1]+b.S3[x2]$$','Interpreter','latex','FontSize',20); axis( [-5 5 -1 8] )


%% TEMPO INVARIANZA   
% deve soddisfare:       x(t+t') = y(t+t')

% S1   
figure('name','Tempo invarianza del sistema 1');
subplot(2,2,1); plot(t, x1, 'b');          title('$$x1(t)=2.rect(t)$$','Interpreter','latex','FontSize',20);   axis( [-4 4 -1 3] )
subplot(2,2,2); plot(t, S1(t,x1), 'b');    title('$$y1(t)$$','Interpreter','latex','FontSize',20);             axis( [-4 4 -1 3] )
subplot(2,2,3); plot(t, x1TI, 'b');        title('$$x2(t)=2.rect(t-3)$$','Interpreter','latex','FontSize',20); axis( [-4 4 -1 3] )
subplot(2,2,4); plot(t, S1(t, x1TI), 'b'); title('$$y2(t)$$','Interpreter','latex','FontSize',20);             axis( [-4 4 -1 3] )

% S2  
figure('name','Tempo invarianza del sistema 2');
subplot(2,2,1); plot(t, x1, 'b');          title('$$x1(t)=2.rect(t)$$','Interpreter','latex','FontSize',20);   axis( [-2 6 -1 5] )
subplot(2,2,2); plot(t, S2(x1), 'b');      title('$$y1(t)=4.rect(t)$$','Interpreter','latex','FontSize',20);   axis( [-2 6 -1 5] )
subplot(2,2,3); plot(t, x1TI, 'b');        title('$$x2(t)=2.rect(t+3)$$','Interpreter','latex','FontSize',20); axis( [-2 6 -1 5] )
subplot(2,2,4); plot(t, S2(x1TI), 'b');    title('$$y2(t)=4.rect(t+3)$$','Interpreter','latex','FontSize',20); axis( [-2 6 -1 5] )
  
% tempoinvariante
% non causale. guarda sia nel futuro che nel passato.
  
% S3
figure('name','Tempo invarianza del sistema 3');
subplot(2,2,1); plot(t, x1, 'b');          title('$$2.rect(t)$$','Interpreter','latex','FontSize',20);         axis( [-1.5 7.5 -1 3] )
subplot(2,2,2); plot(S3(t,0.5), x1,'b');   title('$$2.rect(t/2)$$','Interpreter','latex','FontSize',20);       axis( [-1.5 7.5 -1 3] )
subplot(2,2,3); plot(t, x1TI, 'b');        title('$$2.rect(t-3)$$','Interpreter','latex','FontSize',20);       axis( [-1 7.5 -1 5] )
subplot(2,2,4); plot(S3(t,0.5), x1TI,'b'); title('$$2.rect((t-3)/2)$$','Interpreter','latex','FontSize',20);   axis( [-1.5 7.5 -1 3] )
  
% il sistema è tempovariante. L'asse temporale viene distorto.

%% RISPOSTA ALL'IMPULSO - RISPOSTA IN FREQUENZA

%si ricorda che h= my_rect((t-T/2)/T)
H= fourierTrasf(h, t, f);
moduloH= abs(H);
faseH= angle(H);

figure('name','Risposta del sistema alle sollecitazioni 3');
subplot(1,2,1); plot(f, moduloH, 'b');         title('$$spettro\ di\ ampiezza$$','Interpreter','latex','FontSize',20);  axis( [-10 10 -.5 2.5] )
subplot(1,2,2); plot(f, unwrap( faseH ), 'b'); title('$$spettro\ di\ fase$$','Interpreter','latex','FontSize',20);  %    axis( [-15 10 -80 4] )

A=1;
phi= 0;
f0=1;

xFRQ= A*cos(2*pi*f0*t+phi);
XFRQ= fourierTrasf(xFRQ, t, f); 

YFRQ= XFRQ.*H;
%teorema della risposta in frequenza: saranno uguali?
yFRQ=  A * abs( fourierTrasf(h,t, f0) ) .* cos( 2*pi*f0*t + phi + angle( fourierTrasf(h,t, f0) ) );

figure('name','Teorema della risposta in frequenza');

subplot(1,2,1); plot(f, YFRQ, 'b'); title('$$X(f)*H(f)$$','Interpreter','latex','FontSize',20);  axis( [-5 5 -.5 .5] )
subplot(1,2,2); plot(t, yFRQ, 'r'); title('$$|H(f)|*x(t+\ <H(f))$$','Interpreter','latex','FontSize',20);   axis( [-4 4 -10^-15 10^-15] )

%YFRQ(1)
%YFRQ_TH

%for f0= 0.2:0.2:1
%    y=  A * abs( fourierTrasf(h,t, f0) ) .* cos( 2*pi*f0*t + phi + angle( fourierTrasf(h,t, f0) ) );
%end


%%  Escape 
pause; close all; return;