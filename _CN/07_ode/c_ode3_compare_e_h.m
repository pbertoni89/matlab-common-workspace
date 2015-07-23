clear all; close all; clc;

dy = @(t,y) t-y;
y = @(t) t - 1 + 3*exp(-t-1);

t0 = -1;
T  =  5;
y0 =  1;

H = [1 .5 .1 .05 .01 .005 .001];
err_expl = []; err_impl = [];  err_crni = [];

for h = H
	
	Nh = ceil( (T-t0)/h );
	
	[ t_expl y_expl ] =  eul_expl(dy, [t0 T], y0, Nh);
	y_exe = y(t_expl);
	err_expl = [ err_expl max(abs(y_expl-y_exe)) ];
	
	[ ~, y_impl ] =  eul_impl(dy, [t0 T], y0, Nh);
	err_impl = [ err_impl max(abs(y_impl-y_exe)) ];
	
	[ ~, y_crni ] = crnk_nich(dy, [t0 T], y0, Nh);
	err_crni = [ err_crni max(abs(y_crni-y_exe)) ];
end

loglog(H, H); hold on; 
loglog(H, H.^2,'c');
loglog(H, err_expl,'r'); 
loglog(H, err_impl,'m'); 
loglog(H, err_crni,'k');
legend('H','H^2','expl','impl','crni');

% gli Eulero convergono con h a ordine 1;
% Crank-Nicholson conv  con h a ordine 2.