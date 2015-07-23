function  [sys, x0, str, ts]  = sfunxyz(t,x,u,flag,xlim,ylim,zlim,view,st)
%SFUNXYZ S-function that acts as an X-Y-Z scope using MATLAB plotting functions.
%
%	This M-file is designed to be used in a SIMULINK S-function block.
%	It draws a line from the previous input point, which is stored using
%	discrete states, and the current point.  It then stores the current
%	point for use in the next invocation.
%
%	See also SFUNXY.

%	Copyright (c) 1994 by The MathWorks, Inc.
%	Rick Spada 9-21-94



if (abs(flag) == 2) | (flag == 9)   	% A real time hit
   
  %pause(.1)
  %
  % Look for the figure handle, it's stored in the second state.
  % If it's negative or zero, the figure needs to be located or
  % created.  Otherwise, it exists (we hope...)
  %
  h_fig = x(2);
  if (h_fig <= 0)

    %
    % check the axes limits, they must be 1x2 vectors
    %
    if length([xlim,ylim,zlim,view])~=8
      disp('Axis not defined correctly; the limits must be 1x2 vectors')
      xlim=[-10,10];
      ylim=[-10,10];
      zlim=[-10,10];
    end

    %
    % The figure window takes on the name of the current system, not the
    % current block.  This is due to the way in which the xyz scope is built,
    % it's in a subsystem which is the current system.
    %
    sl_name = get_param(0,'CurrentSystem');

    %
    % Slashes in block names are doubled up, remove the doubled ones.
    % Also change any carriage returns to a blank.
    %
    sl_name = strrep(sl_name,'//','/');
    ind = find(sl_name==setstr(10) | sl_name==setstr(13));
    dash = ' ';
    sl_name(ind)=dash(ones(size(ind)));

    %
    % use findobj to locate the figure window, if it exists, set the
    % limits for the X, Y, and Z axes
    %
    h_fig = findobj('type','figure','name', sl_name);
    if isempty(h_fig),
      new_figure = 1;
    else,
      new_figure = 0;
      %if you want the new plot not overlapped on the old ones
      %new_figure=1;
    
      
      handles = get(h_fig,'UserData');
      h_axis = handles(1);
      h_line = handles(2);
      lx = handles(3);
      ly = handles(4);
      lz = handles(5);
      set(h_line,...
	  'XData',xlim(1),...
	  'YData',ylim(1),...
	  'ZData',zlim(1),...
	  'Erasemode','none','UserData',u(2));
      set(h_axis,...
	  'Xlim',xlim,...
	  'Ylim',ylim,...
	  'ZLim',zlim,...
	  'View',view,...
	  'UserData',u(1));
    end

    %
    % the figure does not exist, and this is an end of simulation (flag 9) call
    % exit early
    %
    if new_figure & (flag == 9)
      sys = [];
      return;
    end;

    %
    % create a new figure window if necessary
    %
    if new_figure
 
      %
      % create the figure
      %
      h_fig = figure('Unit','pixel',...
	             'Pos',[650 255 360 275], ...
		     'Name',sl_name,'NumberTitle','off');
      set(0, 'CurrentFigure', h_fig);

      %
      % now the axes
      %
      h_axis = axes('Xlim',xlim,...
	            'Ylim',ylim,...
		    'Zlim',zlim,...
		    'View',view,...
		    'Handlevisibility','on',...%'NextPlot','new',...
		    'Xgrid','on',...
          'Ygrid','on',...
  		    'Zgrid','on',...
		    'UserData',u(1),'fontsize',8);
       set(get(h_axis,'XLabel'),'VerticalAlignment', 'bottom');
       set(get(h_axis,'XLabel'),'FontSize', 10);
       set(get(h_axis,'XLabel'),'HorizontalAlignment', 'right')
       set(get(h_axis,'YLabel'),'VerticalAlignment', 'top');
       set(get(h_axis,'YLabel'),'FontSize', 10);
       set(get(h_axis,'YLabel'),'HorizontalAlignment', 'right')

       set(get(h_axis,'ZLabel'),'VerticalAlignment', 'bottom','Rotation',0);
		 set(get(h_axis,'ZLabel'),'FontSize', 10);
       set(get(h_axis,'ZLabel'),'HorizontalAlignment', 'right')

 
      set(get(h_axis,'XLabel'),'String','t');
      set(get(h_axis,'YLabel'),'String','x_1');
      set(get(h_axis,'ZLabel'),'String','x_2')

      %      set(get(h_axis,'Title'),'String','X Y Z Plot');
      %
      % and a line
      %
      h_line = line('Xdata',[xlim(1) xlim(1)],...
	            'YData',[ylim(1) ylim(1)],...
		    'Zdata',[zlim(1) zlim(1)],...
		    'Color','blue',...
		    'Erasemode','none','LineWidth',1.5);

      %
      % create three additional lines to hole the X, Y, Z data as it is
      % accumulated during the run
      %
      lx = line('x',[],'y',[],'z',[],'Tag','X');
      ly = line('x',[],'y',[],'z',[],'Tag','Y');
      lz = line('x',[],'y',[],'z',[],'Tag','Z');

    end;

    %
    % this will force a redraw of the figure
    %
    
    set(h_fig,'Color',get(h_fig,'Color'));
    set(h_fig,'Handlevisibility','on');%'NextPlot','new');

    x(1) = 0; 				% Flag to indicate first point
    x(2) = h_fig;
    set(h_fig, 'UserData', [h_axis h_line lx ly lz xlim ylim zlim view]);
  end;

  %
  % init the next discrete states to the current ones, changes
  % will be made below to reflect the run state
  %
  sys = x;

  handles = get(x(2),'UserData');

  %
  % if state 1 is 0, then this is the first time through
  %
  if x(1) == 0
    x_data = [];
    y_data = [];
    z_data = [];
  else

    %
    % test to see if the user has changed the axes limits and take
    % the appropriate action
    %
    lims = handles(6:13);
    if any([xlim ylim zlim view]~=lims),
      set(handles(1),...
	  'xlim',xlim,...
	  'ylim',ylim,...
	  'zlim',zlim,...
	  'view',view);
      handles(6:13) = [xlim ylim zlim view];
      set(x(2),'UserData',handles);
    end

    
    %
    % Plot the next point.  This amounts to setting the line segment
    % to go from the last point to the current point.
    %
    x_data = get(handles(3),'UserData');
    y_data = get(handles(4),'UserData');
    z_data = get(handles(5),'UserData');
    set(handles(2),...
	'XData',[x_data(x(1)),u(1)],...
	'YData',[y_data(x(1)),u(2)],...
	'ZData',[z_data(x(1)),u(3)]);
  end

  %
  % accumulate this input into the X, Y, and Z storage areas
  %
  set(handles(3), 'UserData', [x_data, u(1)]);
  set(handles(4), 'UserData', [y_data, u(2)]);
  set(handles(5), 'UserData', [z_data, u(3)]);

  %
  % up the number of points
  %
  sys(1) = x(1) + 1;

  %
  % flag 9, end of simulation, redraw the entire graph with
  % the accumulated data
  %
  if flag == 9

%    tmp_x = get(handles(1),'Xlim');
%    tmp_y = get(handles(1),'Ylim');
%    tmp_z = get(handles(1),'Zlim');

    set(handles(2),...
	'XData',x_data,...
	'YData',y_data,...
	'ZData',z_data);

%mine
if exist('datapendolo.mat')~=2
   ris=saveplot;
   
	if ris==1
		x_dataold=x_data;
		y_dataold=y_data;
		z_dataold=z_data;
   	xlimold=xlim;
   	ylimold=ylim;
   	zlimold=zlim;
   	save datapendolo x_dataold y_dataold z_dataold  xlimold  ylimold  zlimold
   end
clear ris   
else
   load datapendolo 
   %pause(3)
   temp=min(xlim,xlimold); 
   xlim(1)=temp(1);
   temp=max(xlim,xlimold);
   xlim(2)=temp(2);
   temp=min(ylim,ylimold);
   ylim(1)=temp(1);
   temp=max(ylim,ylimold);
   ylim(2)=temp(2);
   temp=min(zlim,zlimold);
   zlim(1)=temp(1);
   temp=max(zlim,zlimold);
   zlim(2)=temp(2);

figure('name','Movimenti sovrapposti','NumberTitle','off')
   plot3(x_data,y_data,z_data,'Color','blue',...
		    'Erasemode','none','LineWidth',1.5);
   hold on 
   plot3(x_dataold,y_dataold,z_dataold,'Color','red',...
		    'Erasemode','none','LineWidth',1.5);
   set(gca,...
	'xlim',xlim,...
	'ylim',ylim,...
	'zlim',zlim,...
   'view',view,...
   'Handlevisibility','on',...	
   'Xgrid','on',...
   'Ygrid','on',...
  	'Zgrid','on',...
	'fontsize',8);
       set(get(gca,'XLabel'),'VerticalAlignment', 'bottom');
       set(get(gca,'XLabel'),'FontSize', 10);
       set(get(gca,'XLabel'),'HorizontalAlignment', 'right')
       set(get(gca,'YLabel'),'VerticalAlignment', 'top');
       set(get(gca,'YLabel'),'FontSize', 10);
       set(get(gca,'YLabel'),'HorizontalAlignment', 'right')
       set(get(gca,'ZLabel'),'VerticalAlignment', 'bottom','Rotation',0);
		 set(get(gca,'ZLabel'),'FontSize', 10);
       set(get(gca,'ZLabel'),'HorizontalAlignment', 'right')
      set(get(gca,'XLabel'),'String','t');
      set(get(gca,'YLabel'),'String','x_1');
      set(get(gca,'ZLabel'),'String','x_2')
      %
      hold off
      delete datapendolo.mat
      clear
end
%end mine   

    % force a redraw
    %
    %set(handles(1),'Xlim',tmp_x/2);
    %set(handles(1),'Xlim',tmp_x,'Ylim',tmp_y,'Zlim',tmp_z);
    sys=[];

  end;

elseif flag  == 0, 	% Initialization
  
  str = [];  
  % Return system sizes
  sys(1) = 0;	% 0 continuous states
  sys(2) = 2;	% 2 discrete states
  sys(3) = 0;	% 0 outputs
  sys(4) = 3;	% 2 inputs
  sys(5) = 0;	% 0 roots
  sys(6) = 1;	% has direct feedthrough
  sys(7) = 1;	% 1 sample time
  
%  if exist('datapendolo.mat')==2
%     delete datapendolo.mat
%  end
  

  %mine  
  sl_name = get_param(0,'CurrentSystem');

    %
    % Slashes in block names are doubled up, remove the doubled ones.
    % Also change any carriage returns to a blank.
    %
    sl_name = strrep(sl_name,'//','/');
    ind = find(sl_name==setstr(10) | sl_name==setstr(13));
    dash = ' ';
    sl_name(ind)=dash(ones(size(ind)));

  k_fig = findobj('type','figure','name', sl_name);
  close(k_fig);
  
  
  %end
  
  x0 = [0; 0]; 	% Flag to indicate first point

  if (nargin > 5)
    ts = [st, 0];
  else
    ts = [-1, 0];
  end

else

  sys = [];

end
