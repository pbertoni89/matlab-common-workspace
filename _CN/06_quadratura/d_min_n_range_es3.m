clear all; close all; clc; format SHORTG;

xfa = 0; xfb = pi;
xga = 0; xgb = 1;

tol = 1.e-4;

f   = @(x) exp(x).*cos(x);
F  = @(x) 0.5*exp(x).*(sin(x)+cos(x)); If_ex = F(xfb) - F(xfa);
d2f = @(x) -2*exp(x).*(sin(x));
d4f = @(x) -4*exp(x).*cos(x);

g   = @(x) sqrt(x.*(1-x));
d2g = @(x) 1./(4*(x-x.^2).^(3/2));
% che in alcuni punti del dominio (gli estremi) va a infinito;
% il sup allora è infinito, non ha più senso la formula.
% tantomeno si può arrivare con continuità alla derivata quarta.
% Mg_tol non è quindi calcolabile; 
% uno può integrarsi g, ma deve decidere M in base a qualcos'altro.

xf_eval = linspace(xfa,xfb,1000);
xg_eval = linspace(xga,xgb,1000);

MaxAbs_df2 = max(abs(d2f(xf_eval)));
MaxAbs_df4 = max(abs(d4f(xf_eval)));
% MaxAbs_dg2 = max(abs(d2g(xg_eval)));   = +Inf!!!
% ---

%% PM COMPOSITI

%((xb-xa)/24)*(H^2)*MaxAbs_d2 < tol    per f
Hf_tol = sqrt((24*tol)/((xfb-xfa)*MaxAbs_df2));

Mf_tol = ceil((xfb-xfa)/Hf_tol); % = 8;
If_tol =  i_c_pm(f,xfa,xfb,Mf_tol);
fprintf('Punto Medio: Mf_tol = %d  | If_tol = %d\n', Mf_tol, If_tol);
if If_tol-If_ex <= tol
	disp('ottima implementazione punto medio.');
end
%% TRAP COMPOSITI

%((xb-xa)/12)*(H^2)*MaxAbs_d2 < tol    per f
Hf_tol = sqrt((12*tol)/((xfb-xfa)*MaxAbs_df2));

Mf_tol = ceil((xfb-xfa)/Hf_tol);
If_tol =  i_c_trap(f,xfa,xfb,Mf_tol);
fprintf('Trapezi:     Mf_tol = %d  | If_tol = %d\n', Mf_tol, If_tol);
if If_tol-If_ex <= tol
	disp('ottima implementazione trapezi.');
end
%% SIMPSON COMPOSITO

%((xb-xa)/(180*16))*(H^4)*MaxAbs_d4 < tol    per f
Hf_tol = ((180*16*tol)/((xfb-xfa)*MaxAbs_df4))^(1/4);

Mf_tol = ceil((xfb-xfa)/Hf_tol);
If_tol =  simpsonc(xfa,xfb,Mf_tol,f);
% If_1 =  simpsonc(xfa,xfb,1,f); E1 = abs(If_1-If_ex);
%disp('compare this two:');
%-((xfb-xfa)^5*MaxAbs_df4)/(180*16)
% E1

fprintf('Simpson:     Mf_tol = %d  | If_tol = %d\n', Mf_tol, If_tol);
if If_tol-If_ex <= tol
	disp('ottima implementazione simpson.');
end