function [sys,x0]=pendolosim(t,x,u,flag,ts)
%   S-function for animating the motion of a pendulum.

%   Ned Gulley, 6-21-93
%   Copyright (c) 1990-1998 by The MathWorks, Inc. All Rights Reserved.
%   $Revision: 5.5 $

global PendAnim1

if flag==2,
  if any(get(0,'Children')==PendAnim1),
    if strcmp(get(PendAnim1,'Name'),'pendolo'),
      set(0,'currentfigure',PendAnim1);
      hndlList=get(gca,'UserData');
      x=[u(1) u(1)+sin(u(2))];
      y=[0 -cos(u(2))];
      set(hndlList(1),'XData',x,'YData',y);
      set(hndlList(2),'XData',u(1),'YData',0);
      drawnow;
    end
  end
  sys=[];

elseif flag == 4 % Return next sample hit
  
  % ns stores the number of samples
  ns = t/ts;

  % This is the time of the next sample hit.
  sys = (1 + floor(ns + 1e-13*(1+ns)))*ts;

elseif flag==0,

  % Initialize the figure for use with this simulation
  animinit('pendolo'); 
  [flag,PendAnim1] = figflag('pendolo');
  position=get(PendAnim1,'Position');
  position=[5 150 500 500];
  set(PendAnim1,'Position',position);
  axis([-1 1 -1.1 1.1]);
  hold on;

  x=[0 0];
  y=[0 -2];
  hndlList(1)=plot(x,y,'LineWidth',5,'EraseMode','background','color','red');
  hndlList(2)=plot(0,0,'.','MarkerSize',25,'EraseMode','back','color','red');
  set(gca,'DataAspectRatio',[1 1 1]);
  set(gca,'UserData',hndlList);

  sys=[0 0 0 2 0 0];
  x0=[];

end

