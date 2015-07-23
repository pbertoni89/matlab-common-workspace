% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 
% esercizio 4a: trasformata Zeta

clear; clc; close all;
t_start = cputime;

f = -2:.01:2;
n = -20:20;

%num = [1 .5]; % osservare che il padding zero avviene a DX se sono in z^-1, a SX in z
%den = [1 -(1/8)*cos(pi/16) .81]; % in z il grado è dato da length-1..   in z- è sempre 0 ?

    %num_plus = [ 3 0];
    %num_mins = fliplr( num_plus ); 
    %den = [1 -1/4 -1/8];
    
num_plus = [1 0];
den =[1 -10/3 +1];
    

    num_mins = fliplr( num_plus ); 
   

%fvtool(num, den);   % diagrammi di bode.

% polynum = poly1d('coefficients', num);
% polyden = poly1d('coefficients', den);
% degrnum = polynum.Degree;
% degrden = polyden.Degree;

Hplus =  tf(num_plus, den, 1, 'variable', 'z')
Hmins =  tf(num_mins, den, 1, 'variable', 'z^-1')

%% METODI RISOLUTIVI PER RISPOSTA IN FREQUENZA

%  utilizzo lsim() PERFETTAMENTE UGUALE IN Z+ & Z- (me me lo aspettavo)
test = impulso(n);
h_da_lsim = lsim(Hplus,test,n);
Hf_da_lsim = dtft(h_da_lsim,n,f);
figure('name','Funzione lsim() in Z+');
subplot(1,3,1); stem(n, h_da_lsim); title('$$h(n)$$','Interpreter','latex','FontSize',18);
subplot(1,3,2); plot(f, abs(Hf_da_lsim)); title('$$|H(f)|$$','Interpreter','latex','FontSize',18);
subplot(1,3,3); plot(f, angle(Hf_da_lsim)); title('$$\angle{H(f)}$$','Interpreter','latex','FontSize',18);

% utilizzo impulse() - equivalente a lsim()  PERFETTAMENTE UGUALE IN Z+ & Z- (me me lo aspettavo)
h_da_impulse = impulse(Hplus)';
% h_da_impulse = impulse(Hmins)';
fir = length(h_da_impulse);
ndx = 0:fir-1;
nsx = -fir:-1;
Hf_da_impulse = dtft(h_da_impulse,ndx,f);
%stem(nsx, fliplr(a) ); 
figure('name','Funzione impulse() con Z+/-');
subplot(1,3,1); stem(ndx, h_da_impulse); title('$$h(n)$$','Interpreter','latex','FontSize',18);
subplot(1,3,2); plot(f, abs(Hf_da_impulse)); title('$$|H(f)|$$','Interpreter','latex','FontSize',18);
subplot(1,3,3); plot(f, angle(Hf_da_impulse)); title('$$\angle{H(f)}$$','Interpreter','latex','FontSize',18);
%

% utilizzo freqresp()
Hf_da_freqresp = freqresp(Hplus,f);
Hf_da_freqresp = squeeze(Hf_da_freqresp); %bellissimaaaaa. toglie le dimensioni unitarie alle matrici n dimensionali!
Hf_da_freqresp = Hf_da_freqresp';
h_da_freqresp = antidtft(Hf_da_freqresp,n,f);
figure('name','Funzione freqresp()');
subplot(1,3,1); stem(n, h_da_freqresp); title('$$h(n)$$','Interpreter','latex','FontSize',18);
subplot(1,3,2); plot(f, abs(Hf_da_freqresp)); title('$$|H(f)|$$','Interpreter','latex','FontSize',18);
subplot(1,3,3); plot(f, angle(Hf_da_freqresp)); title('$$\angle{H(f)}$$','Interpreter','latex','FontSize',18);
%

% DEPRECATED (BY ME)
    % [ Hf_da_freqz  f_da_freqz ] = freqz(num,den);
    % h_da_freqz = antidtft(Hf_da_freqz,n,f); % attenzione passo le mie frequenze
    % figure('name','Funzione freqz()');
    % subplot(1,3,1); stem(n, h_da_freqz); title('$$h(n)$$','Interpreter','latex','FontSize',18);
    % subplot(1,3,2); plot(freqs, abs(Hf_da_freqz));   title('$$|H(f)|$$','Interpreter','latex','FontSize',18);
    % subplot(1,3,3); plot(freqs, angle(Hf_da_freqz)); title('$$\angle{H(f)}$$','Interpreter','latex','FontSize',18);


%  BUONA PER MARCO CAMPI: riporta alle matrici di stato
%[ A B C D ] = zp2ss( Hzeros, Hpoles, Hgain ) 


%% ZERI E POLI
[ Hzeros Hpoles Hgain ] = tf2zp( num_plus, den )            % POLI & ZERI IN Z+!
Hupoles = unique(Hpoles);
rocs = zeros(1,length(Hupoles));
figure('name','Zero & Poles');
zplane(Hzeros, Hpoles); title('Zeros & Poles');
%

%% RESIDUI (FRATTI SEMPLICI)
residue(num_mins,den)                                     % RESIDUI IN Z- !




fprintf ( 1, 'Elapsed CPU time = %f\n', cputime - t_start );
    return;