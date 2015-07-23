function ris=saveplot
%
% interface for asking the user whether he wants to save a plot or not
% 
%

  s_fig = figure('Unit','pixel',...
   'Pos',[400 255 200 80], ...
     'Name','Salva grafico 3D?','NumberTitle','off','menubar','none');
 set(0, 'CurrentFigure', s_fig);
    

  %====================================
  % Information for all buttons
  labelColor=[0.8 0.8 0.8];
  top=0.05;
  bottom=0.05;
  left=0.05;
  right=0.05;
  btnWid=0.40;
  btnHt=0.80;
  % Spacing between the button and the next command's label
  spacing=0.04;
    
  %====================================
  % The CONSOLE frame
  frmBorder=0.15;
  yPos=0.04-frmBorder;
  
  
  %====================================
  labelStr='SI';
  callbackStr='ris=1;save tempris ris; clear ris; close(gcf)';
  closeHndl=uicontrol( ...
       'Style','pushbutton', ...
       'Units','normalized', ...
       'Position',[left bottom btnWid btnHt], ...
       'String',labelStr, ...
       'Callback',callbackStr);

    
  a=[left+.5 bottom btnWid btnHt];
  labelStr='NO';
  callbackStr='ris=0; save tempris ris; clear ris;close(gcf)';
  closeHndl=uicontrol(...
       'Style','pushbutton', ...
       'Units','normalized', ...
       'Position',a, ...
       'String',labelStr, ...
       'Callback',callbackStr);
   uiwait(s_fig)
    
   load tempris 
   delete tempris.mat 