clear all; close all; clc;

FF = imread('z_firefox.png');

R = double(FF(:,:,1))'; rr = R(:);
G = double(FF(:,:,2))'; gg = G(:);
B = double(FF(:,:,3))'; bb = B(:);

colors = 255; % invece di magic number
int = (rr+gg+bb)/colors; % intensità spazia tra 0 e 3

ny = size(FF,1)-1; nx = size(FF,2)-1;
hx = 1/nx; hy = 1/ny; % dominio arbitrario: quadrato (0,1)x(0,1)
nx1 = nx+1; ny1 = ny+1; % esattamente uguali ai pixels
N = nx1*ny1;

bordo = [(1:nx1)' ; (nx1:nx1:N-nx)' ; (1:nx1:N)' ; (N-nx:N)'];
bordo = (unique(bordo))';
interno = setdiff(1:N,bordo);

% matrice del - laplaciano
al = -1/(hy^2); be = -1/(hx^2); ga = (-2*al-2*be);
e = ones(N,1);
A = spdiags([al*e, be*e, ga*e, be*e, al*e], ...
	        [-nx1,-1,0,1,nx1],N,N);

% Il blocco seguente dovrebbe sostituisce il ciclo
		for i = bordo, A(i,:) = 0;A(i,i) = 1; end
% ma essendo copiato da un problema differente andrebbe rivisto.
% A(1,2) = 0; A(1,nx1+1) = 0;
% A(N,N-1) = 0; A(N,N-nx1) = 0;
% for i = bordo(2:(nx*2+ny*2)-1) % (nx*2+ny*2)= length(bordo)
% 	if i<=nx1
% 		A(i,i-1) = 0; A(i,i+1) = 0; A(i,i+nx1) = 0;
% 	elseif i>=N-nx
% 		A(i,i-1) = 0; A(i,i+1) = 0; A(i,i-nx1)=0;
% 	else
% 		A(i,i+1)=0; A(i,i+nx1)=0; A(i,i-1)=0; A(i,i-nx1)=0;
% 	end
% 	A(i,i) = 1; 
% end

w = A*int;
			
wa = abs(w);  % valore assoluto
wm = w/colors;% middle
M = max(max(w)); m = min(min(w));
Ma = max(max(wa)); ma = min(min(wa));
wa = (wa/(Ma-ma))*colors; % w tra 0 e 255
wr = (w/(M-m))*colors + colors/2; 

w2a = reshape(wa,nx1,ny1); w2a = w2a'; W2A = uint8(w2a);
w2m = reshape(wm,nx1,ny1); w2m = w2m'; W2M = uint8(w2m);
w2r = reshape(wr,nx1,ny1); w2r = w2r'; W2R = uint8(w2r);

figure('name','Firefox');
subplot(2,2,1); imshow(FF);  title('firefox');
subplot(2,2,2); imshow(W2R); title('remapped');
subplot(2,2,3); imshow(W2A); title('abs');
subplot(2,2,4); imshow(W2M); title('middle');

figure('name','Meshes'); 
subplot(1,3,1); mesh(1:nx1,1:ny1,w2r); title('remapped');
subplot(1,3,2); mesh(1:nx1,1:ny1,w2a); title('abs');
subplot(1,3,3); mesh(1:nx1,1:ny1,w2m); title('middle');

w1 = uint8(255*ones(size(W2A))); tol = 3; mid = 128;
for i=1:ny1
	for j=1:nx1
		if W2A(i,j)<mid-tol || W2A(i,j)>mid+tol
			w1(i,j) = 0;
		end
	end
end
figure('name','W1');
imshow(w1);
