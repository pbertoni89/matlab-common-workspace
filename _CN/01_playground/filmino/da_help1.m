figure
Z = peaks; surf(Z); 
axis tight
set(gca,'nextplot','replacechildren');
% Record the movie
for j = 1:400
    surf(sin(2*pi*j/20)*Z,Z)
    F(j) = getframe;
end

%Now play the movie ten times. 
% The eighth frame looks like the following plot.

movie(F,1)
