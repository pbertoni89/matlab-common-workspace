function varargout = monet2(varargin)

% MONET2 
%      Applica due algoritmi per la selezione delle stazioni di
%      monitoraggio ambientale su una griglia rettangolare discretizzata.

% Edit the above text to modify the response to help monet2

% Last Modified by GUIDE v2.5 07-Feb-2012 16:52:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @monet2_OpeningFcn, ...
                   'gui_OutputFcn',  @monet2_OutputFcn, ...
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




% --- Executes just before monet2 is made visible.
function monet2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to monet2 (see VARARGIN)

% Choose default command line output for monet2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes monet2 wait for user response (see UIRESUME)
% uiwait(handles.figureMonet2);


% --- Outputs from this function are returned to the command line.
function varargout = monet2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonFileInput.
function buttonFileInput_Callback(hObject, eventdata, handles)

getInputPollution(handles); %oggetto che contiene un array di matrici (scenari)



% hObject    handle to buttonFileInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editFileInput_Callback(hObject, eventdata, handles)

% hObject    handle to editFileInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFileInput as text
%        str2double(get(hObject,'String')) returns contents of editFileInput as a double


% --- Executes during object creation, after setting all properties.



function editFileInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFileInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSoglia_Callback(hObject, eventdata, handles)
% hObject    handle to editSoglia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSoglia as text
%        str2double(get(hObject,'String')) returns contents of editSoglia as a double


% --- Executes during object creation, after setting all properties.
function editSoglia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSoglia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editStazioni_Callback(hObject, eventdata, handles)
% hObject    handle to editStazioni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editStazioni as text
%        str2double(get(hObject,'String')) returns contents of editStazioni as a double


% --- Executes during object creation, after setting all properties.
function editStazioni_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editStazioni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listboxAlgoritmi.
function listboxAlgoritmi_Callback(hObject, eventdata, handles)
value = get(hObject,'Value');
if value == 2 %visualizzo input Langstaff
    set(handles.textSoglia, 'Visible', 'off');
    set(handles.textSoglia2, 'Visible', 'off');
    set(handles.editSoglia, 'Visible', 'off');
    set(handles.textPopolazione, 'Visible', 'on');
    set(handles.editPopolazione, 'Visible', 'on');
    set(handles.textPopolazione2, 'Visible', 'on');
    set(handles.buttonPopolazione, 'Visible', 'on');
    set(handles.textVarianza, 'Visible', 'on');
    set(handles.textVarianza2, 'Visible', 'on');
    set(handles.editVarianza, 'Visible', 'on');    
    set(handles.textOsservazione, 'Visible', 'on');
    set(handles.textOsservazione2, 'Visible', 'on');
    set(handles.editOsservazione, 'Visible', 'on');
    set(handles.textAddizionale, 'Visible', 'on');
    set(handles.textAddizionale2, 'Visible', 'on');
    set(handles.editAddizionale, 'Visible', 'on');
    set(handles.textMinEffStaz, 'Visible', 'off');
    set(handles.textMinEffStaz2, 'Visible', 'off');
    set(handles.editMinEffStaz, 'Visible', 'off');
    
else %visualizza input Noll
    set(handles.textSoglia, 'Visible', 'on');
    set(handles.textSoglia2, 'Visible', 'on');
    set(handles.editSoglia, 'Visible', 'on');
    set(handles.textPopolazione, 'Visible', 'off');
    set(handles.textPopolazione2, 'Visible', 'off');
    set(handles.editPopolazione, 'Visible', 'off');
    set(handles.buttonPopolazione, 'Visible', 'off');
    set(handles.textVarianza, 'Visible', 'off');
    set(handles.textVarianza2, 'Visible', 'off');
    set(handles.editVarianza, 'Visible', 'off');
    set(handles.textOsservazione, 'Visible', 'off');
    set(handles.textOsservazione2, 'Visible', 'off');
    set(handles.editOsservazione, 'Visible', 'off');
    set(handles.textAddizionale, 'Visible', 'off');
    set(handles.textAddizionale2, 'Visible', 'off');
    set(handles.editAddizionale, 'Visible', 'off');
    set(handles.textMinEffStaz, 'Visible', 'on');
    set(handles.textMinEffStaz2, 'Visible', 'on');
    set(handles.editMinEffStaz, 'Visible', 'on');

end
refresh(monet2)

% hObject    handle to listboxAlgoritmi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxAlgoritmi contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxAlgoritmi


% --- Executes during object creation, after setting all properties.
function listboxAlgoritmi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxAlgoritmi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPopolazione_Callback(hObject, eventdata, handles)
% hObject    handle to editPopolazione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPopolazione as text
%        str2double(get(hObject,'String')) returns contents of editPopolazione as a double


% --- Executes during object creation, after setting all properties.
function editPopolazione_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPopolazione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonPopolazione.
function buttonPopolazione_Callback(hObject, eventdata, handles)

getInputPopulation(handles); %oggetto che contiene un array di matrici (scenari)


% hObject    handle to buttonPopolazione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonSimulazione.
function buttonSimulazione_Callback(hObject, eventdata, handles)

gestoreSimulazione(handles)





% hObject    handle to buttonSimulazione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkBoxOutput.
function checkBoxOutput_Callback(hObject, eventdata, handles)
% hObject    handle to checkBoxOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkBoxOutput


% --- Executes on button press in buttonGuida.
function buttonGuida_Callback(hObject, eventdata, handles)
open('guida.pdf');
% hObject    handle to buttonGuida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function editVarianza_Callback(hObject, eventdata, handles)
% hObject    handle to editVarianza (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVarianza as text
%        str2double(get(hObject,'String')) returns contents of editVarianza as a double


% --- Executes during object creation, after setting all properties.
function editVarianza_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVarianza (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAddizionale_Callback(hObject, eventdata, handles)
% hObject    handle to editAddizionale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAddizionale as text
%        str2double(get(hObject,'String')) returns contents of editAddizionale as a double


% --- Executes during object creation, after setting all properties.
function editAddizionale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAddizionale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOsservazione_Callback(hObject, eventdata, handles)
% hObject    handle to editOsservazione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOsservazione as text
%        str2double(get(hObject,'String')) returns contents of editOsservazione as a double


% --- Executes during object creation, after setting all properties.
function editOsservazione_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOsservazione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMinEffStaz_Callback(hObject, eventdata, handles)
% hObject    handle to editMinEffStaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMinEffStaz as text
%        str2double(get(hObject,'String')) returns contents of editMinEffStaz as a double


% --- Executes during object creation, after setting all properties.
function editMinEffStaz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMinEffStaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
