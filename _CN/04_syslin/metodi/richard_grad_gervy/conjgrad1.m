function [x,it,Err]=grad1(x,a,b,nmax,toll)
%
% metodo del gradiente con disegno delle direzioni di discesa
%
% E' una function di tipo esplicativo, funziona per sistemi 2x2
%
[n,m]=size(a);
xmin=-55;xmax=55;
ymin=-55;ymax=55;
% disegno le isolinee e le direzioni di discesa
xx=a\b;
h=.5;
xr=xmin:h:xmax;
yr=ymin:h:ymax;
[x1,y]=meshgrid(xr,yr);
z=0.5*(a(1,1)*x1.^2+2*a(1,2)*x1.*y+a(2,2)*y.^2)-b(1)*x1-b(2)*y;
f='0.5*(a(1,1)*xx1.^2+2*a(1,2)*xx1.*yy1+a(2,2)*yy1.^2)-b(1)*xx1-b(2)*yy1';
xx1=x(1);yy1=x(2);
f0=eval(f);

%
    figNumber=figure( ...
        'Name','Isolinee della forma quadratica associata al sistema Ax=b',...
        'Visible','on');
    axes( ...
        'Units','normalized', ...
        'Position',[0.15,0.07,.65,.88],...
        'Visible','on');

    axis([xmin,xmax,ymin,ymax])
    axHndl=gca;
    figNumber=gcf;
    set(axHndl, ...
        'XLim',[xmin xmax],'YLim',[ymin ymax], ...
        'Drawmode','fast', ...
        'Visible','on', ...
        'View',[0,90]);
    xlabel('x');
    ylabel('y');

contour(x1,y,z,50)
title('isolinee della forma quadratica associata al sistema Ax=b')
fprintf('\n Si risolve ora il sistema lineare con il metodo del GRADIENTE\n ')
disp('Premere un tasto per continuare')
pause
hold on
contour(x1,y,z,[f0,f0],'c--')
h1=plot(x(1),x(2),'c.');
set(h1,'MarkerSize',10)
pause
%
re=[];
r=b-a*x;
bb=norm(b,2);
k=0;err=norm(r)/bb;p=r;
Err=[err];
while k<nmax & err> toll
q=a*p;
nrk=p'*r;
alpha=nrk/(p'*q);
%
h1=plot(x(1),x(2),'c.');
set(h1,'MarkerSize',10)
xv=x;
%
x=x+alpha*p;
%
if k< 2
z=0.5*(a(1,1)*x1.^2+2*a(1,2)*x1.*y+a(2,2)*y.^2)-b(1)*x1-b(2)*y;
xx1=x(1);yy1=x(2);f0=eval(f);
contour(x1,y,z,[f0,f0],'c--')
h1=plot(x(1),x(2),'c.');
set(h1,'MarkerSize',10)
plot([x(1),xv(1)],[x(2),xv(2)],'c');
pause
else
h1=plot(x(1),x(2),'m.');
set(h1,'MarkerSize',10)
plot([x(1),xv(1)],[x(2),xv(2)],'c');
end
%
r=r-alpha*q;
nrk1=r'*r;
beta=nrk1/nrk;
p=r+beta*p;
res=norm(r,2);
re=[re;res];
err=res/bb;
Err=[Err;err];
k=k+1;nrk=nrk1;
end
it=k;
fprintf('\n Il metodo del GRADIENTE e` arrivato a convergenza in %3g ',it)
fprintf('iterazioni,\n fissata la tolleranza = %6.3g\n', toll)
return
