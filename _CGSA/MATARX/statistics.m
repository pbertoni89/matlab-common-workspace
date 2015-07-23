function varargout = statistics(varargin)
% STATISTICS MATLAB code for statistics.fig
%      STATISTICS, by itself, creates a new STATISTICS or raises the existing
%      singleton*.
%
%      H = STATISTICS returns the handle to a new STATISTICS or the handle to
%      the existing singleton*.
%
%      STATISTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATISTICS.M with the given input arguments.
%
%      STATISTICS('Property','Value',...) creates a new STATISTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before statistics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to statistics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help statistics

% Last Modified by GUIDE v2.5 22-Jul-2011 01:11:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @statistics_OpeningFcn, ...
                   'gui_OutputFcn',  @statistics_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before statistics is made visible.
function statistics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to statistics (see VARARGIN)

% Choose default command line output for statistics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes statistics wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global viewdata;
if(viewdata.min_ide{1} <= 1e-14)
    set(handles.min_ide,'String','0.00000');
else
     set(handles.min_ide,'String',viewdata.min_ide);
end
set(handles.min_val,'String',viewdata.min_val);
set(handles.min_prev,'String',viewdata.min_prev);
set(handles.err_ide,'String',viewdata.err_ide);
set(handles.err_val,'String',viewdata.err_val);
set(handles.err_prev,'String',viewdata.err_prev);
set(handles.err_n_ide,'String',viewdata.corr_ide);
set(handles.err_n_val,'String',viewdata.corr_val);
set(handles.err_n_prev,'String',viewdata.corr_prev);
set(handles.var_ide,'String',viewdata.var_ide);
set(handles.var_val,'String',viewdata.var_val);
set(handles.var_prev,'String',viewdata.var_prev);

set(handles.dati_usati_ide,'String',viewdata.dati_usati_ide);
set(handles.dati_usati_val,'String',viewdata.dati_usati_val);
set(handles.dati_usati_prev,'String',viewdata.dati_usati_prev);


% --- Outputs from this function are returned to the command line.
function varargout = statistics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function main_menu_Callback(hObject, eventdata, handles)
% hObject    handle to main_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function main_close_Callback(hObject, eventdata, handles)
% hObject    handle to main_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close statistics;


% --------------------------------------------------------------------
function save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function legend_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close statistics;
