function varargout = gui_apc(varargin)

clear data;
global data;

% GUI_APC M-file for gui_apc.fig
%      GUI_APC, by itself, creates a new GUI_APC or raises the existing
%      singleton*.
%
%      H = GUI_APC returns the handle to a new GUI_APC or the handle to
%      the existing singleton*.
%
%      GUI_APC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_APC.M with the given input arguments.
%
%      GUI_APC('Property','Value',...) creates a new GUI_APC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_apc_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_apc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_apc

% Last Modified by GUIDE v2.5 29-Sep-2004 12:02:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_apc_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_apc_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_apc is made visible.
function gui_apc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_apc (see VARARGIN)

% Choose default command line output for gui_apc
handles.output = hObject;
movegui(hObject,'north');
% Update handles structure
guidata(hObject, handles);

if strcmp(get(hObject,'Visible'),'off')
    initialize_gui(hObject, handles);
end

% UIWAIT makes gui_apc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_apc_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% % --- Executes during object creation, after setting all properties.
% function popupmenu1_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to popupmenu1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: popupmenu controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc
%     set(hObject,'BackgroundColor','white');
% else
%     set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
% end


% % --- Executes on selection change in popupmenu1.
% function popupmenu1_Callback(hObject, eventdata, handles)
% % hObject    handle to popupmenu1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
% %        contents{get(hObject,'Value')} returns selected item from popupmenu1
% 

% --- Executes during object creation, after setting all properties.
function coordinate_camino_1_CreateFcn(hObject, eventdata, handles)
global data;
% hObject    handle to coordinate_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function coordinate_camino_1_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to coordinate_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordinate_camino_1 as text
%        str2double(get(hObject,'String')) returns contents of coordinate_camino_1 as a double

coordinate_camino_1 = str2num(get(hObject, 'String'));

data = getappdata(gcbf, 'metricdata');
data.coordinate_camino_1 = coordinate_camino_1;
setappdata(gcbf, 'metricdata', data);



% --- Executes during object creation, after setting all properties.
function altezza_geometrica_camino_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to altezza_geometrica_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function altezza_geometrica_camino_1_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to altezza_geometrica_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of altezza_geometrica_camino_1 as text
%        str2double(get(hObject,'String')) returns contents of altezza_geometrica_camino_1 as a double

altezza_geometrica_camino_1 = str2num(get(hObject, 'String'));

data = getappdata(gcbf, 'metricdata');
data.altezza_geometrica_camino_1 = altezza_geometrica_camino_1;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function raggio_camino_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to raggio_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function raggio_camino_1_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to raggio_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of raggio_camino_1 as text
%        str2double(get(hObject,'String')) returns contents of raggio_camino_1 as a double

raggio_camino_1 = str2num(get(hObject, 'String'));

data = getappdata(gcbf, 'metricdata');
data.raggio_camino_1 = raggio_camino_1;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function dimensione_impianto_camino_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dimensione_impianto_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function dimensione_impianto_camino_1_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

dimensione_impianto_camino_1 = get(hObject,'Value');
%valore 2 corrisponde ad P, valore 3 a G,...,

data = getappdata(gcbf, 'metricdata');
data.dimensione_impianto_camino_1 = dimensione_impianto_camino_1;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function temperatura_uscita_fumi_camino_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temperatura_uscita_fumi_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function temperatura_uscita_fumi_camino_1_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to temperatura_uscita_fumi_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temperatura_uscita_fumi_camino_1 as text
%        str2double(get(hObject,'String')) returns contents of temperatura_uscita_fumi_camino_1 as a double

temperatura_uscita_fumi_camino_1 = str2num(get(hObject, 'String'));

data = getappdata(gcbf, 'metricdata');
data.temperatura_uscita_fumi_camino_1 = temperatura_uscita_fumi_camino_1;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function velocita_uscita_fumi_camino_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to velocita_uscita_fumi_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function velocita_uscita_fumi_camino_1_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to velocita_uscita_fumi_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of velocita_uscita_fumi_camino_1 as text
%        str2double(get(hObject,'String')) returns contents of velocita_uscita_fumi_camino_1 as a double

velocita_uscita_fumi_camino_1 = str2num(get(hObject, 'String'));

data = getappdata(gcbf, 'metricdata');
data.velocita_uscita_fumi_camino_1 = velocita_uscita_fumi_camino_1;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function rateo_di_emissione_camino_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rateo_di_emissione_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function rateo_di_emissione_camino_1_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to rateo_di_emissione_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rateo_di_emissione_camino_1 as text
%        str2double(get(hObject,'String')) returns contents of rateo_di_emissione_camino_1 as a double

rateo_di_emissione_camino_1 = str2num(get(hObject, 'String'));

data = getappdata(gcbf, 'metricdata');
data.rateo_di_emissione_camino_1 = rateo_di_emissione_camino_1;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function velocita_vento_CreateFcn(hObject, eventdata, handles)
% hObject    handle to velocita_vento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function velocita_vento_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to velocita_vento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of velocita_vento as text
%        str2double(get(hObject,'String')) returns contents of velocita_vento as a double

velocita_vento = str2num(get(hObject, 'String'));

data = getappdata(gcbf, 'metricdata');
data.velocita_vento = velocita_vento;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function direzione_vento_CreateFcn(hObject, eventdata, handles)
% hObject    handle to direzione_vento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function direzione_vento_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to direzione_vento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of direzione_vento as text
%        str2double(get(hObject,'String')) returns contents of direzione_vento as a double

direzione_vento = str2num(get(hObject, 'String'));

data = getappdata(gcbf, 'metricdata');
data.direzione_vento = direzione_vento;
setappdata(gcbf, 'metricdata', data);


% --- Executes during object creation, after setting all properties.
function temperatura_aria_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temperatura_aria (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function temperatura_aria_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to temperatura_aria (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temperatura_aria as text
%        str2double(get(hObject,'String')) returns contents of temperatura_aria as a double

temperatura_aria = str2num(get(hObject, 'String'));

data = getappdata(gcbf, 'metricdata');
data.temperatura_aria = temperatura_aria;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function classe_stabilita_CreateFcn(hObject, eventdata, handles)
% hObject    handle to classe_stabilita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu.
function classe_stabilita_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

classe_stabilita = get(hObject,'Value');
%valore 2 corrisponde ad A, valore 3 a B,...,

data = getappdata(gcbf, 'metricdata');
data.classe_stabilita = classe_stabilita;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function tipologia_terreno_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tipologia_terreno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu.
function tipologia_terreno_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

tipologia_terreno = get(hObject,'Value');
%valore 2 corrisponde ad O, valore 3 a U,...,

data = getappdata(gcbf, 'metricdata');
data.tipologia_terreno = tipologia_terreno;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function coordinate_citta_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordinate_citta_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function coordinate_citta_1_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to coordinate_citta_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordinate_citta_1 as text
%        str2double(get(hObject,'String')) returns contents of coordinate_citta_1 as a double

coordinate_citta_1 = str2num(get(hObject, 'String'));

if isscalar(coordinate_citta_1)==1
   set(hObject, 'String', 0);
   errordlg('Input must be written separating x and y with a COMMA. Please use this format: x,y','Error');    
end
if length(coordinate_citta_1)==2
    for i=1:2
        if coordinate_citta_1(i)<0 | coordinate_citta_1(i)>20000
            set(hObject, 'String', 0);
            errordlg('Input of x and y must be a number between 0 and 20000','Error');
        end
    end
end

data = getappdata(gcbf, 'metricdata');
data.coordinate_citta_1 = coordinate_citta_1;
setappdata(gcbf, 'metricdata', data);

% --- Executes on button press in crea_concentrazioni_2d.
function crea_concentrazioni_2d_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to crea_concentrazioni_2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = getappdata(gcbf, 'metricdata');
data.toggle_conc_click=1;

%controlli per le caratteristiche meteo e del sito, relativamente a range
%di valori che si possono inserire, e uso del punto o della virgola
if isnan(data.velocita_vento) | (data.velocita_vento<1 | data.velocita_vento>50) | isscalar(data.velocita_vento)==0
    errordlg('Velocita vento must be a number betwenn 1 and 50; use DOT and not COMMA','Error');
    data.toggle_conc_click=0;
end

if isnan(data.direzione_vento) | (data.direzione_vento<0 | data.direzione_vento>360) | isscalar(data.direzione_vento)==0
    errordlg('Direzione vento must be a number betwenn 0 and 360; use DOT and not COMMA','Error');
    data.toggle_conc_click=0;
end

if isnan(data.temperatura_aria) | (data.temperatura_aria<263 | data.temperatura_aria>323) | isscalar(data.temperatura_aria)==0
    errordlg(' Temperatura aria must be a number betwenn 263 and 323; use DOT and not COMMA','Error');
    data.toggle_conc_click=0;
end

if data.classe_stabilita==1
    errordlg('You must select Classe stabilit� ','Error');
    data.toggle_conc_click=0;
end

if data.tipologia_terreno==1
    errordlg('You must select Tipologia terreno','Error');
    data.toggle_conc_click=0;
end

%controlli per i tre camini: camino1
if data.presenza_camino_1==1

    if isscalar(data.coordinate_camino_1)==1
        errordlg('Coordinate x,y must be written separating x and y with a COMMA. Please use this format: x,y','Error');
        data.toggle_conc_click=0;
    end
    if length(data.coordinate_camino_1)==2
        for i=1:2
            if data.coordinate_camino_1(i)<0 | data.coordinate_camino_1(i)>20000
                errordlg('x and y must be a number between 0 and 20000','Error');
                data.toggle_conc_click=0;
            end
        end
    end

    if isnan(data.altezza_geometrica_camino_1) | (data.altezza_geometrica_camino_1<0.1 | data.altezza_geometrica_camino_1>500) | isscalar(data.altezza_geometrica_camino_1)==0
        errordlg('Altezza geometrica camino must be a number betwenn 0.1 and 500; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end


    if isnan(data.raggio_camino_1) | (data.raggio_camino_1<0.1 | data.raggio_camino_1>20)| isscalar(data.raggio_camino_1)==0
        errordlg('Raggio camino must be a number betwenn 0.1 and 20; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

    if data.dimensione_impianto_camino_1==1
        errordlg('You must select Dim. impianto for your stacks','Error');
        data.toggle_conc_click=0;
    end

    if isnan(data.temperatura_uscita_fumi_camino_1) | (data.temperatura_uscita_fumi_camino_1<303 | data.temperatura_uscita_fumi_camino_1>773) |  isscalar(data.temperatura_uscita_fumi_camino_1)==0
        errordlg('Temperatura uscita fumi must be a number betwenn 303 and 773; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

    if isnan(data.velocita_uscita_fumi_camino_1) | (data.velocita_uscita_fumi_camino_1<0.1 | data.velocita_uscita_fumi_camino_1>50) | isscalar(data.velocita_uscita_fumi_camino_1)==0
        errordlg('Velocit� fumi must be a number betwenn 0.1 and 50; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

    if isnan(data.rateo_di_emissione_camino_1) | (data.rateo_di_emissione_camino_1<0.1 | data.rateo_di_emissione_camino_1>20000) | isscalar(data.rateo_di_emissione_camino_1)==0
        errordlg('Rateo di emissione camino must be a number betwenn 0.1 and 20000; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

end

%controlli per i tre camini: camino2
if data.presenza_camino_2==1

    if isscalar(data.coordinate_camino_2)==1
        errordlg('Coordinate x,y must be written separating x and y with a COMMA. Please use this format: x,y','Error');
        data.toggle_conc_click=0;
    end
    if length(data.coordinate_camino_2)==2
        for i=1:2
            if data.coordinate_camino_2(i)<0 | data.coordinate_camino_2(i)>20000
                errordlg('x and y must be a number between 0 and 20000','Error');
                data.toggle_conc_click=0;
            end
        end
    end

    if isnan(data.altezza_geometrica_camino_2) | (data.altezza_geometrica_camino_2<0.1 | data.altezza_geometrica_camino_2>500) | isscalar(data.altezza_geometrica_camino_2)==0
        errordlg('Altezza geometrica camino must be a number betwenn 0.1 and 500; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end


    if isnan(data.raggio_camino_2) | (data.raggio_camino_2<0.1 | data.raggio_camino_2>20)| isscalar(data.raggio_camino_2)==0
        errordlg('Raggio camino must be a number betwenn 0.1 and 20; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

    if data.dimensione_impianto_camino_2==1
        errordlg('You must select Dim. impianto for your stacks','Error');
        data.toggle_conc_click=0;
    end

    if isnan(data.temperatura_uscita_fumi_camino_2) | (data.temperatura_uscita_fumi_camino_2<303 | data.temperatura_uscita_fumi_camino_2>773) |  isscalar(data.temperatura_uscita_fumi_camino_2)==0
        errordlg('Temperatura uscita fumi must be a number betwenn 303 and 773; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

    if isnan(data.velocita_uscita_fumi_camino_2) | (data.velocita_uscita_fumi_camino_2<0.1 | data.velocita_uscita_fumi_camino_2>50) | isscalar(data.velocita_uscita_fumi_camino_2)==0
        errordlg('Velocit� fumi must be a number betwenn 0.1 and 50; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

    if isnan(data.rateo_di_emissione_camino_2) | (data.rateo_di_emissione_camino_2<0.1 | data.rateo_di_emissione_camino_2>20000) | isscalar(data.rateo_di_emissione_camino_2)==0
        errordlg('Rateo di emissione camino must be a number betwenn 0.1 and 20000; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

end


%controlli per i tre camini: camino3
if data.presenza_camino_3==1

    if isscalar(data.coordinate_camino_3)==1
        errordlg('Coordinate x,y must be written separating x and y with a COMMA. Please use this format: x,y','Error');
        data.toggle_conc_click=0;
    end
    if length(data.coordinate_camino_3)==2
        for i=1:2
            if data.coordinate_camino_3(i)<0 | data.coordinate_camino_3(i)>20000
                errordlg('x and y must be a number between 0 and 20000','Error');
                data.toggle_conc_click=0;
            end
        end
    end

    if isnan(data.altezza_geometrica_camino_3) | (data.altezza_geometrica_camino_3<0.1 | data.altezza_geometrica_camino_3>500) | isscalar(data.altezza_geometrica_camino_3)==0
        errordlg('Altezza geometrica camino must be a number betwenn 0.1 and 500; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end


    if isnan(data.raggio_camino_3) | (data.raggio_camino_3<0.1 | data.raggio_camino_3>20)| isscalar(data.raggio_camino_3)==0
        errordlg('Raggio camino must be a number betwenn 0.1 and 20; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

    if data.dimensione_impianto_camino_3==1
        errordlg('You must select Dim. impianto for your stacks','Error');
        data.toggle_conc_click=0;
    end

    if isnan(data.temperatura_uscita_fumi_camino_3) | (data.temperatura_uscita_fumi_camino_3<303 | data.temperatura_uscita_fumi_camino_3>773) |  isscalar(data.temperatura_uscita_fumi_camino_3)==0
        errordlg('Temperatura uscita fumi must be a number betwenn 303 and 773; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

    if isnan(data.velocita_uscita_fumi_camino_3) | (data.velocita_uscita_fumi_camino_3<0.1 | data.velocita_uscita_fumi_camino_3>50) | isscalar(data.velocita_uscita_fumi_camino_3)==0
        errordlg('Velocit� fumi must be a number betwenn 0.1 and 50; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

    if isnan(data.rateo_di_emissione_camino_3) | (data.rateo_di_emissione_camino_3<0.1 | data.rateo_di_emissione_camino_3>20000) | isscalar(data.rateo_di_emissione_camino_1)==0
        errordlg('Rateo di emissione camino must be a number betwenn 0.1 and 20000; use DOT and not COMMA','Error');
        data.toggle_conc_click=0;
    end

end











if data.toggle_conc_click==1
    apc_main(data);
end

% --- Executes during object creation, after setting all properties.
function coordinate_citta_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordinate_citta_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function coordinate_citta_2_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to coordinate_citta_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordinate_citta_2 as text
%        str2double(get(hObject,'String')) returns contents of coordinate_citta_2 as a double

coordinate_citta_2 = str2num(get(hObject, 'String'));

if isscalar(coordinate_citta_2)==1
   set(hObject, 'String', 0);
   errordlg('Input must be written separating x and y with a COMMA. Please use this format: x,y','Error');    
end
if length(coordinate_citta_2)==2
    for i=1:2
        if coordinate_citta_2(i)<0 | coordinate_citta_2(i)>20000
            set(hObject, 'String', 0);
            errordlg('Input of x and y must be a number between 0 and 20000','Error');
        end
    end
end


data = getappdata(gcbf, 'metricdata');
data.coordinate_citta_2 = coordinate_citta_2;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function coordinate_camino_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordinate_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function coordinate_camino_2_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to coordinate_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordinate_camino_2 as text
%        str2double(get(hObject,'String')) returns contents of coordinate_camino_2 as a double

coordinate_camino_2 = str2num(get(hObject, 'String'));

if isscalar(coordinate_camino_2)==1
   set(hObject, 'String', 0);
   errordlg('Input must be written separating x and y with a COMMA. Please use this format: x,y','Error');    
end
if length(coordinate_camino_2)==2
    for i=1:2
        if coordinate_camino_2(i)<0 | coordinate_camino_2(i)>20000
            set(hObject, 'String', 0);
            errordlg('Input of x and y must be a number between 0 and 20000','Error');
        end
    end
end



data = getappdata(gcbf, 'metricdata');
data.coordinate_camino_2 = coordinate_camino_2;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function altezza_geometrica_camino_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to altezza_geometrica_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function altezza_geometrica_camino_2_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to altezza_geometrica_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of altezza_geometrica_camino_2 as text
%        str2double(get(hObject,'String')) returns contents of altezza_geometrica_camino_2 as a double

altezza_geometrica_camino_2 = str2num(get(hObject, 'String'));
if isnan(altezza_geometrica_camino_2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
if altezza_geometrica_camino_2<0 | altezza_geometrica_camino_2>500
    set(hObject, 'String', 0);
    errordlg('Input must be a number between 0 and 500','Error');
end
if isscalar(altezza_geometrica_camino_2)==0
   set(hObject, 'String', 0);
   errordlg('Input must be written using DOT and not COMMA','Error');    
end

data = getappdata(gcbf, 'metricdata');
data.altezza_geometrica_camino_2 = altezza_geometrica_camino_2;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function raggio_camino_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to raggio_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function raggio_camino_2_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to raggio_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of raggio_camino_2 as text
%        str2double(get(hObject,'String')) returns contents of raggio_camino_2 as a double

raggio_camino_2 = str2num(get(hObject, 'String'));
if isnan(raggio_camino_2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
if raggio_camino_2<0 | raggio_camino_2>20
    set(hObject, 'String', 0);
    errordlg('Input must be a number between 0 and 20','Error');
end
if isscalar(raggio_camino_2)==0
   set(hObject, 'String', 0);
   errordlg('Input must be written using DOT and not COMMA','Error');    
end

data = getappdata(gcbf, 'metricdata');
data.raggio_camino_2 = raggio_camino_2;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function dimensione_impianto_camino_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dimensione_impianto_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function dimensione_impianto_camino_2_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

dimensione_impianto_camino_2 = get(hObject,'Value');
%valore 2 corrisponde ad P, valore 3 a G,...,

data = getappdata(gcbf, 'metricdata');
data.dimensione_impianto_camino_2 = dimensione_impianto_camino_2;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function temperatura_uscita_fumi_camino_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temperatura_uscita_fumi_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function temperatura_uscita_fumi_camino_2_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to temperatura_uscita_fumi_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temperatura_uscita_fumi_camino_2 as text
%        str2double(get(hObject,'String')) returns contents of temperatura_uscita_fumi_camino_2 as a double

temperatura_uscita_fumi_camino_2 = str2num(get(hObject, 'String'));
if isnan(temperatura_uscita_fumi_camino_2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
if temperatura_uscita_fumi_camino_2<303 | temperatura_uscita_fumi_camino_2>773
    set(hObject, 'String', 0);
    errordlg('Input must be a number between 303 and 773','Error');
end
if isscalar(temperatura_uscita_fumi_camino_2)==0
   set(hObject, 'String', 0);
   errordlg('Input must be written using DOT and not COMMA','Error');    
end

data = getappdata(gcbf, 'metricdata');
data.temperatura_uscita_fumi_camino_2 = temperatura_uscita_fumi_camino_2;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function velocita_uscita_fumi_camino_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to velocita_uscita_fumi_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function velocita_uscita_fumi_camino_2_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to velocita_uscita_fumi_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of velocita_uscita_fumi_camino_2 as text
%        str2double(get(hObject,'String')) returns contents of velocita_uscita_fumi_camino_2 as a double

velocita_uscita_fumi_camino_2 = str2num(get(hObject, 'String'));
if isnan(velocita_uscita_fumi_camino_2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
if velocita_uscita_fumi_camino_2<0 | velocita_uscita_fumi_camino_2>50
    set(hObject, 'String', 0);
    errordlg('Input must be a number between 0 and 50','Error');
end
if isscalar(velocita_uscita_fumi_camino_2)==0
   set(hObject, 'String', 0);
   errordlg('Input must be written using DOT and not COMMA','Error');    
end

data = getappdata(gcbf, 'metricdata');
data.velocita_uscita_fumi_camino_2 = velocita_uscita_fumi_camino_2;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function rateo_di_emissione_camino_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rateo_di_emissione_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function rateo_di_emissione_camino_2_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to rateo_di_emissione_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rateo_di_emissione_camino_2 as text
%        str2double(get(hObject,'String')) returns contents of rateo_di_emissione_camino_2 as a double

rateo_di_emissione_camino_2 = str2num(get(hObject, 'String'));
if isnan(rateo_di_emissione_camino_2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
if rateo_di_emissione_camino_2<0 | rateo_di_emissione_camino_2>2000
    set(hObject, 'String', 0);
    errordlg('Input must be a number between 0 and 2000','Error');
end
if isscalar(rateo_di_emissione_camino_2)==0
   set(hObject, 'String', 0);
   errordlg('Input must be written using DOT and not COMMA','Error');    
end

data = getappdata(gcbf, 'metricdata');
data.rateo_di_emissione_camino_2 = rateo_di_emissione_camino_2;
setappdata(gcbf, 'metricdata', data);


% % --- Executes during object creation, after setting all properties.
% function popupmenu4_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to tipologia_terreno (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: popupmenu controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc
%     set(hObject,'BackgroundColor','white');
% else
%     set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
% end

% 
% % --- Executes on selection change in tipologia_terreno.
% function popupmenu4_Callback(hObject, eventdata, handles)
% % hObject    handle to tipologia_terreno (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: contents = get(hObject,'String') returns tipologia_terreno contents as cell array
% %        contents{get(hObject,'Value')} returns selected item from tipologia_terreno


% % --- Executes on button press in pushbutton2.
% function pushbutton2_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 


% % --- Executes on button press in checkbox1.
% function checkbox1_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox1
% 
% presenza_camino_3 = get(hObject,'Value');
% 
% data = getappdata(gcbf, 'metricdata');
% data.presenza_camino_1 = presenza_camino_1;
% setappdata(gcbf, 'metricdata', data);


% % --- Executes on button press in checkbox2.
% function checkbox2_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox2
% 
% presenza_camino_2 = get(hObject,'Value');
% 
% data = getappdata(gcbf, 'metricdata');
% data.presenza_camino_2 = presenza_camino_2;
% setappdata(gcbf, 'metricdata', data);
% 


% --- Executes during object creation, after setting all properties.
% function dimensione_impianto_camino_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dimensione_impianto_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in dimensione_impianto_camino_1.
% function dimensione_impianto_camino_1_Callback(hObject, eventdata, handles)
% hObject    handle to dimensione_impianto_camino_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns dimensione_impianto_camino_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dimensione_impianto_camino_1


% --- Executes during object creation, after setting all properties.
% function dimensione_impianto_camino_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dimensione_impianto_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in dimensione_impianto_camino_2.
% function dimensione_impianto_camino_2_Callback(hObject, eventdata, handles)
% hObject    handle to dimensione_impianto_camino_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns dimensione_impianto_camino_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dimensione_impianto_camino_2


% --- Executes on button press in presenza_citta_1.
function presenza_citta_1_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to presenza_citta_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of presenza_citta_1

presenza_citta_1=get(hObject,'Value');

data = getappdata(gcbf, 'metricdata');
data.presenza_citta_1=presenza_citta_1;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in presenza_citta_2.
function presenza_citta_2_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to presenza_citta_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of presenza_citta_2

presenza_citta_2=get(hObject,'Value');

data = getappdata(gcbf, 'metricdata');
data.presenza_citta_2=presenza_citta_2;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in presenza_camino_1.
function presenza_camino_1_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to presenza_citta_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of presenza_citta_1

presenza_camino_1=get(hObject,'Value');

data = getappdata(gcbf, 'metricdata');
data.presenza_camino_1=presenza_camino_1;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in presenza_camino_2.
function presenza_camino_2_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to presenza_citta_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of presenza_citta_1

presenza_camino_2=get(hObject,'Value');

data = getappdata(gcbf, 'metricdata');
data.presenza_camino_2=presenza_camino_2;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in resetta_valori.
function resetta_valori_Callback(hObject, eventdata, handles)
% hObject    handle to resetta_valori (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

initialize_gui(gcbf, handles);
% h = findobj('Type','figure');
% h(1)=0;
% h=h(find(h));
% delete(h);


function initialize_gui(fig_handle, handles)
global data;
data.velocita_vento = 1;
data.direzione_vento=0;
data.temperatura_aria=0;
data.classe_stabilita=1;
data.tipologia_terreno=1;
data.presenza_camino_1=0;
data.presenza_camino_2=0;
data.presenza_camino_3=0;
data.coordinate_camino_1=0;
data.coordinate_camino_2=0;
data.coordinate_camino_3=0;
data.altezza_geometrica_camino_1=0;
data.altezza_geometrica_camino_2=0;
data.altezza_geometrica_camino_3=0;
data.raggio_camino_1=0;
data.raggio_camino_2=0;
data.raggio_camino_3=0;
data.dimensione_impianto_camino_1=1;
data.dimensione_impianto_camino_2=1;
data.dimensione_impianto_camino_3=1;
data.temperatura_uscita_fumi_camino_1=0;
data.temperatura_uscita_fumi_camino_2=0;
data.temperatura_uscita_fumi_camino_3=0;
data.velocita_uscita_fumi_camino_1=0;
data.velocita_uscita_fumi_camino_2=0;
data.velocita_uscita_fumi_camino_3=0;
data.rateo_di_emissione_camino_1=0;
data.rateo_di_emissione_camino_2=0;
data.rateo_di_emissione_camino_3=0;
data.presenza_citta_1=0;
data.presenza_citta_2=0;
data.coordinate_citta_1=0;
data.coordinate_citta_2=0;
data.mappa_x=0;
data.mappa_y=0;
data.mappa_conc=0;
data.flag_profili=0;



setappdata(fig_handle, 'metricdata', data);

set(handles.coordinate_camino_1, 'String', data.coordinate_camino_1);
set(handles.coordinate_camino_2, 'String', data.coordinate_camino_2);
set(handles.coordinate_camino_3, 'String', data.coordinate_camino_3);
set(handles.temperatura_aria, 'String', data.temperatura_aria);
set(handles.classe_stabilita, 'value', data.classe_stabilita);
set(handles.tipologia_terreno, 'value', data.tipologia_terreno);
set(handles.presenza_camino_1, 'value', data.presenza_camino_1);
set(handles.presenza_camino_2, 'value', data.presenza_camino_2);
set(handles.presenza_camino_3, 'value', data.presenza_camino_3);
set(handles.velocita_vento, 'String', data.velocita_vento);
set(handles.direzione_vento, 'String', data.direzione_vento);
set(handles.altezza_geometrica_camino_1, 'String', data.altezza_geometrica_camino_1);
set(handles.altezza_geometrica_camino_2, 'String', data.altezza_geometrica_camino_2);
set(handles.altezza_geometrica_camino_3, 'String', data.altezza_geometrica_camino_3);
set(handles.raggio_camino_1, 'String', data.raggio_camino_1);
set(handles.raggio_camino_2, 'String', data.raggio_camino_2);
set(handles.raggio_camino_3, 'String', data.raggio_camino_3);
set(handles.dimensione_impianto_camino_1, 'value', data.dimensione_impianto_camino_1);
set(handles.dimensione_impianto_camino_2, 'value', data.dimensione_impianto_camino_2);
set(handles.dimensione_impianto_camino_3, 'value', data.dimensione_impianto_camino_3);
set(handles.temperatura_uscita_fumi_camino_1, 'String', data.temperatura_uscita_fumi_camino_1);
set(handles.temperatura_uscita_fumi_camino_2, 'String', data.temperatura_uscita_fumi_camino_2);
set(handles.temperatura_uscita_fumi_camino_3, 'String', data.temperatura_uscita_fumi_camino_3);
set(handles.velocita_uscita_fumi_camino_1, 'String', data.velocita_uscita_fumi_camino_1);
set(handles.velocita_uscita_fumi_camino_2, 'String', data.velocita_uscita_fumi_camino_2);
set(handles.velocita_uscita_fumi_camino_3, 'String', data.velocita_uscita_fumi_camino_3);
set(handles.rateo_di_emissione_camino_1, 'String', data.rateo_di_emissione_camino_1);
set(handles.rateo_di_emissione_camino_2, 'String', data.rateo_di_emissione_camino_2);
set(handles.rateo_di_emissione_camino_3, 'String', data.rateo_di_emissione_camino_3);
set(handles.presenza_citta_1, 'value', data.presenza_citta_1);
set(handles.presenza_citta_2, 'value', data.presenza_citta_2);
set(handles.coordinate_citta_1, 'String', data.coordinate_citta_1);
set(handles.coordinate_citta_2, 'String', data.coordinate_citta_2);
set(handles.mappa_x, 'String', data.mappa_x);
set(handles.mappa_y, 'String', data.mappa_x);
set(handles.mappa_conc, 'String', data.mappa_x);
set(handles.flag_profili, 'value', data.flag_profili);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in toggle_conc_click.
function toggle_conc_click_Callback(hObject, eventdata, handles)
global conc_tot;
global c_f;
global conc_parz;
global Xin;
global Xfin;
global passoX;
global Yin;
global Yfin;
global passoY;
global Zin;
global Zfin;
global passoZ;

% hObject    handle to toggle_conc_click (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


toggle_conc_click=get(hObject,'Value');
data = getappdata(gcbf, 'metricdata');
data.toggle_conc_click = toggle_conc_click;
setappdata(gcbf, 'metricdata', data);
set(gcf,'Pointer','arrow');
%ciclo while che permette di interagire con la mappa interattiva delle concetrazioni totali
%e stampa i valori di concentrazione.

if data.toggle_conc_click==1;
    % if data.toggle_conc_click==0;
    %     k=1;
    %     break;
    % else    
%     c=get(0,'CurrentFigure');
    c=gcf;
    figure(c);
    [x,y,N]=ginput(1);
    if (N==3)
        k=1;
        data.toggle_conc_click=0;
        set(handles.toggle_conc_click, 'Value', 0);
        set(gcf,'Pointer','arrow');
    else
        set(handles.mappa_x, 'String', x);
        set(handles.mappa_y, 'String', y);
        j=abs(round((Xin-x)/passoX))+1;
        i=abs(round((Yin-y)/passoY))+1;
        if c>1 & max(c_f)==c
            t=conc_tot(i,j,1);
            t(find(t<0.001))=0;
            set(handles.mappa_conc, 'String', t);
            if data.flag_profili==1
                profilo=conc_tot(i,j,:);
                b = reshape(profilo,1,51);
                figure;
                plot(b,Zin:passoZ:Zfin);
                xlabel('Concentrazione (\mu g/m3)');
                ylabel('Altezza (m)');
                data.toggle_conc_click=0;
                set(handles.toggle_conc_click, 'Value', 0);
                return;
            end
            set(handles.toggle_conc_click, 'Value', 0);
        else
            f=find(c_f==c);
            t=conc_parz{f}(i,j,1);
            t(find(t<0.001))=0;
            set(handles.mappa_conc, 'String',t);
            if data.flag_profili==1
                profilo=conc_parz{f}(i,j,:);
                b = reshape(profilo,1,51);
                figure;
                plot(b,Zin:passoZ:Zfin);
                xlabel('Concentrazione (\mu g/m3)');
                ylabel('Altezza (m)');
                data.toggle_conc_click=0;
                set(handles.toggle_conc_click, 'Value', 0);
                return;
            end
            data.toggle_conc_click=0;
            set(handles.toggle_conc_click, 'Value', 0); 
        end
    end
end


% --- Executes during object creation, after setting all properties.
function mappa_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mappa_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function mappa_x_Callback(hObject, eventdata, handles)
% hObject    handle to mappa_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mappa_x as text
%        str2double(get(hObject,'String')) returns contents of mappa_x as a double


% --- Executes during object creation, after setting all properties.
function mappa_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mappa_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function mappa_y_Callback(hObject, eventdata, handles)
% hObject    handle to mappa_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mappa_y as text
%        str2double(get(hObject,'String')) returns contents of mappa_y as a double


% --- Executes during object creation, after setting all properties.
function mappa_conc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mappa_conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function mappa_conc_Callback(hObject, eventdata, handles)
% hObject    handle to mappa_conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mappa_conc as text
%        str2double(get(hObject,'String')) returns contents of mappa_conc as a double


% --- Executes on button press in flag_profili.
function flag_profili_Callback(hObject, eventdata, handles)
% hObject    handle to flag_profili (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag_profili

flag_profili=get(hObject,'Value');

data = getappdata(gcbf, 'metricdata');
data.flag_profili=flag_profili;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in presenza_camino_3.
function presenza_camino_3_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to presenza_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of presenza_camino_3

presenza_camino_3=get(hObject,'Value');

data = getappdata(gcbf, 'metricdata');
data.presenza_camino_3=presenza_camino_3;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function coordinate_camino_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordinate_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function coordinate_camino_3_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to coordinate_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordinate_camino_3 as text
%        str2double(get(hObject,'String')) returns contents of coordinate_camino_3 as a double

coordinate_camino_3 = str2num(get(hObject, 'String'));

if isscalar(coordinate_camino_3)==1
   set(hObject, 'String', 0);
   errordlg('Input must be written separating x and y with a COMMA. Please use this format: x,y','Error');    
end
if length(coordinate_camino_3)==2
    for i=1:2
        if coordinate_camino_3(i)<0 | coordinate_camino_3(i)>20000
            set(hObject, 'String', 0);
            errordlg('Input of x and y must be a number between 0 and 20000','Error');
        end
    end
end

data = getappdata(gcbf, 'metricdata');
data.coordinate_camino_3 = coordinate_camino_3;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function altezza_geometrica_camino_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to altezza_geometrica_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function altezza_geometrica_camino_3_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to altezza_geometrica_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of altezza_geometrica_camino_3 as text
%        str2double(get(hObject,'String')) returns contents of altezza_geometrica_camino_3 as a double

altezza_geometrica_camino_3 = str2num(get(hObject, 'String'));
if isnan(altezza_geometrica_camino_3)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
if altezza_geometrica_camino_3<0 | altezza_geometrica_camino_3>500
    set(hObject, 'String', 0);
    errordlg('Input must be a number between 0 and 500','Error');
end
if isscalar(altezza_geometrica_camino_3)==0
   set(hObject, 'String', 0);
   errordlg('Input must be written using DOT and not COMMA','Error');    
end

data = getappdata(gcbf, 'metricdata');
data.altezza_geometrica_camino_3 = altezza_geometrica_camino_3;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function raggio_camino_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to raggio_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function raggio_camino_3_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to raggio_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of raggio_camino_3 as text
%        str2double(get(hObject,'String')) returns contents of raggio_camino_3 as a double

raggio_camino_3 = str2num(get(hObject, 'String'));
if isnan(raggio_camino_3)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
if raggio_camino_3<0 | raggio_camino_3>20
    set(hObject, 'String', 0);
    errordlg('Input must be a number between 0 and 20','Error');
end
if isscalar(raggio_camino_3)==0
   set(hObject, 'String', 0);
   errordlg('Input must be written using DOT and not COMMA','Error');    
end

data = getappdata(gcbf, 'metricdata');
data.raggio_camino_3 = raggio_camino_3;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function dimensione_impianto_camino_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dimensione_impianto_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in dimensione_impianto_camino_3.
function dimensione_impianto_camino_3_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to dimensione_impianto_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns dimensione_impianto_camino_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dimensione_impianto_camino_3

dimensione_impianto_camino_3 = get(hObject,'Value');
%valore 2 corrisponde ad P, valore 3 a G,...,

data = getappdata(gcbf, 'metricdata');
data.dimensione_impianto_camino_3 = dimensione_impianto_camino_3;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function temperatura_uscita_fumi_camino_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temperatura_uscita_fumi_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function temperatura_uscita_fumi_camino_3_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to temperatura_uscita_fumi_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temperatura_uscita_fumi_camino_3 as text
%        str2double(get(hObject,'String')) returns contents of temperatura_uscita_fumi_camino_3 as a double

temperatura_uscita_fumi_camino_3 = str2num(get(hObject, 'String'));
if isnan(temperatura_uscita_fumi_camino_3)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
if temperatura_uscita_fumi_camino_3<303 | temperatura_uscita_fumi_camino_3>773
    set(hObject, 'String', 0);
    errordlg('Input must be a number between 303 and 773','Error');
end
if isscalar(temperatura_uscita_fumi_camino_3)==0
   set(hObject, 'String', 0);
   errordlg('Input must be written using DOT and not COMMA','Error');    
end


data = getappdata(gcbf, 'metricdata');
data.temperatura_uscita_fumi_camino_3 = temperatura_uscita_fumi_camino_3;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function velocita_uscita_fumi_camino_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to velocita_uscita_fumi_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function velocita_uscita_fumi_camino_3_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to velocita_uscita_fumi_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of velocita_uscita_fumi_camino_3 as text
%        str2double(get(hObject,'String')) returns contents of velocita_uscita_fumi_camino_3 as a double

velocita_uscita_fumi_camino_3 = str2num(get(hObject, 'String'));
if isnan(velocita_uscita_fumi_camino_3)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
if velocita_uscita_fumi_camino_3<0 | velocita_uscita_fumi_camino_3>50
    set(hObject, 'String', 0);
    errordlg('Input must be a number between 0 and 50','Error');
end
if isscalar(velocita_uscita_fumi_camino_3)==0
   set(hObject, 'String', 0);
   errordlg('Input must be written using DOT and not COMMA','Error');    
end

data = getappdata(gcbf, 'metricdata');
data.velocita_uscita_fumi_camino_3 = velocita_uscita_fumi_camino_3;
setappdata(gcbf, 'metricdata', data);

% --- Executes during object creation, after setting all properties.
function rateo_di_emissione_camino_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rateo_di_emissione_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function rateo_di_emissione_camino_3_Callback(hObject, eventdata, handles)
global data;
% hObject    handle to rateo_di_emissione_camino_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rateo_di_emissione_camino_3 as text
%        str2double(get(hObject,'String')) returns contents of rateo_di_emissione_camino_3 as a double

rateo_di_emissione_camino_3 = str2num(get(hObject, 'String'));
if isnan(rateo_di_emissione_camino_3)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
if rateo_di_emissione_camino_3<0 | rateo_di_emissione_camino_3>2000
    set(hObject, 'String', 0);
    errordlg('Input must be a number between 0 and 2000','Error');
end
if isscalar(rateo_di_emissione_camino_3)==0
   set(hObject, 'String', 0);
   errordlg('Input must be written using DOT and not COMMA','Error');    
end

data = getappdata(gcbf, 'metricdata');
data.rateo_di_emissione_camino_3 = rateo_di_emissione_camino_3;
setappdata(gcbf, 'metricdata', data);
