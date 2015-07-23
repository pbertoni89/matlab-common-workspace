% Disegnare f (x, y, t) = 1/5 sin(x)y cos(t)
% per (x, y) ? [??, ?]^2 e t ? [0, 2?]
close all; clear; clc;

%[x,y] = meshgrid( -pi:.5:pi );
%f=@(x,y,t)[sin(x) .* y/5 * cos(t)];

[x,y] = meshgrid( -pi:.1:pi );
f=@(x,y,t)[exp(-x.*x) .* exp(-y.*y) * cos(t)];
nframes=20;
tt = linspace(0, 2*pi, nframes);

figure(1); clf;

Mv = moviein(nframes);

for n = 1:nframes
	t = tt(n); 
	z = f(x,y,t); 
	surf(x,y,z);
	axis( [-pi pi -pi pi -1 1] );
	Mv(:,n) = getframe;
end

movie(Mv,4); % prende TUTTO il filmino generato e lo visualizza 4 volte
% pertanto in totale verrà mostrato 5 volte.