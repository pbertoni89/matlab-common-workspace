function[x,it,Err]= conjgra1(x,a,b,nmax,toll)
%
% gradiente coniugato con disegno delle x_k
%
fprintf('\n Si risolve ora il sistema lineare con il metodo del GRADIENTE')
fprintf(' CONIUGATO\n')
disp('Premere un tasto per continuare')
pause

xx=a\b;
re=[];
r=b-a*x;
nrk=r'*r;
p=r;
bb=norm(b,2);
%
k=0;err=sqrt(nrk)/bb;
Err=[err];
xmin=-55;xmax=55;
ymin=-55;ymax=55;
h=0.5;
xr=xmin:h:xmax;
yr=ymin:h:ymax;
[x1,y]=meshgrid(xr,yr);
z=0.5*(a(1,1)*x1.^2+2*a(1,2)*x1.*y+a(2,2)*y.^2)-b(1)*x1-b(2)*y;
f='0.5*(a(1,1)*xx1.^2+2*a(1,2)*xx1.*yy1+a(2,2)*yy1.^2)-b(1)*xx1-b(2)*yy1';
xx1=x(1);yy1=x(2);
f0=eval(f);
%hc=contour(x1,y,z,[f0,f0],'g--');
%set(hc,'Color',[0.07,0.86,1.])
%
while k<nmax & err> toll
q=a*p;
alpha=nrk/(p'*q);
%
h1=plot(x(1),x(2),'g*');
set(h1,'Color',[0.06,0.68,1.],'Linewidth',2)
xv=x;
%
x=x+alpha*p;
%
if k< 5
%z=0.5*(a(1,1)*x1.^2+2*a(1,2)*x1.*y+a(2,2)*y.^2)-b(1)*x1-b(2)*y;
%xx1=x(1);yy1=x(2);f0=eval(f);
%hc=contour(x1,y,z,[f0,f0],'g--')
%set(hc,'Color',[0.06,0.68,1.])
h2=plot(x(1),x(2),'g*');
set(h2,'Color',[0.06,0.68,1.])
h1=plot([x(1),xv(1)],[x(2),xv(2)],'g');
set(h1,'Color',[0.06,0.68,1.],'Linewidth',2)
pause
else
h2=plot(x(1),x(2),'g*')
set(h2,'Color',[0.06,0.68,1.],'Linewidth',2)
h3=plot([x(1),xv(1)],[x(2),xv(2)],'g');
set(h3,'Color',[0.06,0.68,1.])
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
k=k+1;
nrk=nrk1;
end
it=k;
fprintf('\n Il metodo del GRADIENTE CONIUGATO e` arrivato a convergenza in')
fprintf('%2g iterazioni,\n fissata la tolleranza = %6.3g\n', it, toll)

return
