which es2_integrale;

t= -20:0.01:20; % tempo fine ed esteso

% x= zeros(1, length(t)) +3;  % 1, zeros o l'avrei quadrata
% a=1;
% b=3;
% fprintf('l integrale vale %f\n', riemannInt(t, a, b, x) );

fprintf(' Area di rect(t)= %f\n', riemannInt(t, t(1), t(length(t)), my_rect(t) ) );
fprintf(' W di rect(t)= %f\n', riemannInt(t, t(1), t(length(t)), my_rect(t).*my_rect(t) ) );

fprintf(' Area di tri(t)= %f\n', riemannInt(t, t(1), t(length(t)), my_tri(t) ) );
fprintf(' W di tri(t)= %f\n', riemannInt(t, t(1), t(length(t)), my_tri(t).*my_tri(t) ) );
fprintf(' W di tri(t/2)= %f\n', riemannInt(t, t(1), t(length(t)), my_tri(t/2).*my_tri(t/2) ) );


fprintf(' P di sin(2*pi*t)= %f\n', riemannInt(t,t(1),t(length(t)),sin(2*pi*t).*sin(2*pi*t))/ (t(length(t))-t(1)) );

return;