% Patrizio Bertoni 79021 INFLT3
% Elaborazione Numerica dei Segnali aa 2011 2012
% 

% esercizio 2b: convoluzione circolare
%

clear; clc; close all;

n1 = -10:10;
n2 = -20:20;

x1b = [ 3 5 7 ];   y1b = [ 1 2 1 ];
x2b = [ 2 1 ];     y2b = [ 1 2 3 4 ];
x3b = [ 2 5 4 0 3 ];   yb = [ 1 2 2 1 1 2 2 ];


%% ---------------------------------------------------------------------------------------------------------------------------

x1 = my_rep_gen( x1b, n1);   y1 = my_rep_gen( y1b, n1);

mcm1 = lcm(length(x1b),length(y1b));
%mcd1 = gcd(length(x1b),length(y1b));

n_fin = 0:mcm1-1; % dura esattamente mcm campioni
x1f = zeros(1,mcm1);
y1f = x1f;
z1f = x1f;

% finestramento a mcm campioni
for i=1:mcm1
   fprintf('x1f(%d) diventa x1=%d \n', i , x1(n1==i-1) ); 
   x1f(i) = x1(n1==i-1);
   y1f(i) = y1(n1==i-1);
end

temp = my_conv_handler( x1f, y1f, n_fin, n_fin); 

z1t = temp(1,:);
n1t = temp(2,:);

%copiatura elementi sicuramente validi
for i = 1 : mcm1
    z1f(i) = z1t(i);
end

%eventuali campioni da reinserire nel periodo (convoluzione ha sforato)
if(length(z1t(1,:))>mcm1)
    for i = mcm1+1 : length(z1t(1,:))
        fprintf('z1f(%d) = %d si aggiunge di %d andando a %d \n', i-mcm1 , z1t(i-mcm1), z1t(i), z1t(i-mcm1) + z1t(i) ); 
        z1f(i-mcm1) = z1t(i-mcm1) + z1t(i);
    end
end

%subplot(2,2,1); stem(n_fin,x1f); title('$$x_{1f}$$','Interpreter','latex','FontSize',20);
%subplot(2,2,2); stem(n_fin,y1f); title('$$y_{1f}$$','Interpreter','latex','FontSize',20);
%subplot(2,2,3); stem(n1t, z1t);  title('$$z_{1t}$$','Interpreter','latex','FontSize',20);
%subplot(2,2,4); stem(n_fin, z1f);  title('$$z_{1f}$$','Interpreter','latex','FontSize',20);

z1 = my_rep_gen(z1f,n1);

linee_x1 = [ 0 , length(x1b)-1];
linee_y1 = [ 0 , length(y1b)-1];
linee_z1 = [ 0 , length(z1f)-1];

  figure('name', 'Convoluzione circolare numero 1');
 
      subplot(1,3,1); stem( n1, x1,  'y', 'filled'); title('$$x_1$$','Interpreter','latex','FontSize',20); hold on;
      ylim=get(gca,'ylim'); line([ linee_x1;linee_x1 ],ylim.', 'linewidth', 1, 'color',[0,0,0]);
        
      subplot(1,3,2); stem( n1, y1,  'g', 'filled'); title('$$y_1$$','Interpreter','latex','FontSize',20); hold on;
      ylim=get(gca,'ylim'); line([ linee_y1;linee_y1  ],ylim.', 'linewidth', 1, 'color',[0,0,0]);
       
      subplot(1,3,3); stem( n1, z1,  'r', 'filled'); title('$$x_1 \ast y_1$$','Interpreter','latex','FontSize',20); hold on;
      ylim=get(gca,'ylim'); line([ linee_z1;linee_z1 ],ylim.', 'linewidth', 1, 'color',[0,0,0]);
   
pause; clc; close all;  
%% ---------------------------------------------------------------------------------------------------------------------------
      
x2 = my_rep_gen( x2b, n2);   y2 = my_rep_gen( y2b, n2);

mcm2 = lcm(length(x2b),length(y2b));

n_fin = 0:mcm2-1; 
x2f = zeros(1,mcm2);
y2f = x2f;
z2f = x2f;

for i=1:mcm2
   fprintf('x2f(%d) diventa x2=%d \n', i , x2(n1==i-1) ); 
   x2f(i) = x2(n1==i-1);
   y2f(i) = y2(n1==i-1);
end

temp = my_conv_handler( x2f, y2f, n_fin, n_fin); 

z2t = temp(1,:);
n2t = temp(2,:);

for i = 1 : mcm2
    z2f(i) = z2t(i);
end

if(length(z2t(1,:))>mcm2)
    for i = mcm2+1 : length(z2t(1,:))  %% SISTEMAREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        fprintf('\n z2f(%d) = %d si aggiunge di z2f(%d)=%d andando a %d \n', i-mcm2 , z2t(i-mcm2), z2t(i), z2t(i-mcm2) + z2t(i) ); 
        z2f(i-mcm1) = z2t(i-mcm1) + z2t(i);
    end
end

subplot(2,2,1); stem(n_fin,x2f); title('$$x_{2f}$$','Interpreter','latex','FontSize',20);
subplot(2,2,2); stem(n_fin,y2f); title('$$y_{2f}$$','Interpreter','latex','FontSize',20);
subplot(2,2,3); stem(n2t, z2t);  title('$$z_{2t}$$','Interpreter','latex','FontSize',20);
subplot(2,2,4); stem(n_fin, z2f);  title('$$z_{2f}$$','Interpreter','latex','FontSize',20);

z2 = my_rep_gen(z2f,n2);

linee_x2 = [ 0 , length(x2b)-1];
linee_y2 = [ 0 , length(y2b)-1];
linee_z2 = [ 0 , length(z2f)-1];

  figure('name', 'Convoluzione circolare numero 2');
 
      subplot(1,3,1); stem( n2, x2,  'y', 'filled'); title('$$x_2$$','Interpreter','latex','FontSize',20); hold on;
      ylim=get(gca,'ylim'); line([ linee_x2;linee_x2 ],ylim.', 'linewidth', 1, 'color',[0,0,0]);
        
      subplot(1,3,2); stem( n2, y2,  'g', 'filled'); title('$$y_2$$','Interpreter','latex','FontSize',20); hold on;
      ylim=get(gca,'ylim'); line([ linee_y2;linee_y2  ],ylim.', 'linewidth', 1, 'color',[0,0,0]);
       
      subplot(1,3,3); stem( n2, z2,  'r', 'filled'); title('$$x_2 \ast y_1$$','Interpreter','latex','FontSize',20); hold on;
      ylim=get(gca,'ylim'); line([ linee_z2;linee_z2 ],ylim.', 'linewidth', 1, 'color',[0,0,0]);
return;