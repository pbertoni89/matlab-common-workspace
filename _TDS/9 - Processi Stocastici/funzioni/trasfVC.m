function [ vc ] = trasfVC( alpha, U, pdf)  
% alpha la variabile 'piccola'
% U la uniforme (qualsiasi) di partenza
% pdf il segnale desiderato

vc = zeros( length(U),1);
d_alpha = alpha(2)-alpha(1); 

% pdf f_Z = tri(alpha);

F = zeros(size(alpha));
for i = 2:length(alpha)
    F(i) = F(i-1) + pdf(i)*d_alpha;   % sommatoria integrale
end

zeroIndex = sum(F==0);
oneIndex = sum(F==F(end));

Fclip = F(zeroIndex:end-oneIndex+1);
alphaClip = alpha(zeroIndex:end-oneIndex+1);

for u = 1:length(U)
    yIndex = abs(Fclip-U(u))==min(abs(Fclip-U(u)));
    vc(u) = alphaClip(yIndex);
end

end

