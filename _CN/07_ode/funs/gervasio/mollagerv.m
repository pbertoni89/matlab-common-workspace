function mollagerv(tn,un,varargin)
%
%   rappresentazione grafica del sistema
%   parete - molla - massa  
%
%     uso: molla(tn,un)
% 
%     Input: tn= vettore dei tempi
%            un= array con un vettore colonna (o riga)
%                contenente la posizioni della massa ai tempi tn. 
%
[n1,n2]=size(un);
if n1>n2
    un=un.';
end

if nargin==2
	nspire=12;
else
	nspire=varargin{1};
end
% preparo le variabili 
xmin=min(min(un(1:n2,:)));xmax=max(max(un(1:n2,:))); xr=(xmax-xmin)/5;
ymin=-1;ymax=1; yr=0;
xmin=xmin-xr; xmax=xmax+xr;
ymin=ymin-yr; ymax=ymax+yr;

    fig=figure( ...
        'Name','Molla', ...
        'Visible','on');
    colordef(fig,'white');
    axes( ...
        'Units','normalized', ...
        'Visible','on');

    axis([-1 1 -1 1]);
    axHndl=gca;
    
%      aviobj = avifile('molla.avi')
     set(axHndl, ...
        'XLim',[xmin xmax],'YLim',[ymin ymax], ...
        'Drawmode','fast', ...
        'Visible','on', ...
        'NextPlot','add', ...
        'Xgrid','on','Ygrid','on',...
        'View',[0,90]);
    tempo=text('position',[1,0.6,0],...
            'String',[],...
            'Fontsize',14);
        molla1=line( ...
            'color','g', ...
            'Linewidth',2,...
            'erase','normal', ...
            'xdata',[],'ydata',[]);
        
        parete=line( ...
            'color','k', ...
            'Linewidth',3,...
            'erase','none', ...
            'xdata',[],'ydata',[]);
        massa1 = line( ...
            'color','r', ...
            'Marker','s', ...
            'markersize',9, ...
            'markerfacecolor','r', ...
            'markeredgecolor','r', ...
            'erase','normal', ...
            'xdata',[],'ydata',[]);
        
         
l=length(tn);
for k=1:l
   
    x1=linspace(0,un(1,k),nspire*2+4);
    y1=zeros(1,nspire*2+4);
    y1(3:2:end-2)=0.1;
    y1(4:2:end-3)=-0.1;
    
    %y1=[0,0,.1,-.1,.1,-.1,.1,-.1,.1,0,0];
    set(tempo,'String',['t=',num2str(tn(k))]);
    set(parete,'xdata',[0,0],'ydata',[-0.5,0.5]);
    set(massa1,'xdata',un(1,k),'ydata',0);
    
    set(molla1,'xdata',x1,'ydata',y1);
   
    drawnow;
%     F = getframe(fig);
%            aviobj = addframe(aviobj,F);
end
% close(fig)
%        aviobj = close(aviobj);