function varargout = gui_model(varargin)
% GUI_MODEL MATLAB code for gui_model.fig
%      GUI_MODEL, by itself, creates a new GUI_MODEL or raises the existing
%      singleton*.
%
%      H = GUI_MODEL returns the handle to a new GUI_MODEL or the handle to
%      the existing singleton*.
%
%      GUI_MODEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MODEL.M with the given input arguments.
%
%      GUI_MODEL('Property','Value',...) creates a new GUI_MODEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_model_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_model_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_model

% Last Modified by GUIDE v2.5 14-May-2011 17:55:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_model_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_model_OutputFcn, ...
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


% --- Executes just before gui_model is made visible.
function gui_model_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_model (see VARARGIN)
% the data for the gui

% Choose default command line output for gui_model
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_model wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%print the model in the static text on gui
global viewdata;
set(handles.text1,'String',viewdata.mod);

% --- Outputs from this function are returned to the command line.
function varargout = gui_model_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text1.
function text1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_file_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close gui_model;
