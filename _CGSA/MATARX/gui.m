function varargout = gui(varargin)
clc;

% global variables list
clear prevision
global prevision;

% the validation vector
clear validation;
global validation;

% the measure of the data used to predict
clear predData;
global predData;

% the data for the gui
clear guidata;
global guidata;

% the data to visualize in the gui
clear viewdata;
global viewdata;

%the data for the arx menu_help
clear data;
global data;

% the data for the validation
clear dataValidate;
global dataValidate;

% the data for the prediction
clear dataPrediction;
global dataPrediction;

% the model
clear model;
global model;

% the various error for the stats
clear errid;
global errid;
clear errval;
global errval;
clear errpred;
global errpred;


% GUI M-file for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui
% Last Modified by GUIDE v2.5 22-Jul-2011 14:29:47
% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_OpeningFcn, ...
    'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)
%handles.current_data=handles.validate_graph;
% load all the prevision from the directory history

% inizialize default gui data
initialize_guidata(handles);

% initialize popupmenù
initialize_popupmenu(handles);

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.arxgui);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% make graphic the object selected
global viewdata;
global prevision;

selected=get(handles.popupmenu1,'UserData');
selected=selected{get(handles.popupmenu1,'Value')};
if ~isempty(selected)
    valName=['history/' selected '.valori_iniziali'];
    %val=load(valName);
    loadName=['history/' selected '.mat'];
    viewdata=load(loadName);
    viewdata=viewdata.viewdata;
    viewdata.view_model='on';
    viewdata.view_statistic='on';
    viewdata.view_data='on';
    viewdata.view_predict='off';
    viewdata.predict='off';
    refresh_gui(handles);
end


% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_file.
function load_file_Callback(hObject, eventdata, handles)
% hObject    handle to load_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;
global data;

% this method load the exogenous part
[ guidata.fileY , guidata.pathY] = uigetfile( ...
    '*.*' , 'Select the AR part' );
if ~ischar(guidata.fileY);
    return;
end

emptyy=isempty(guidata.fileY);

% this code set the data field in the gui
viewdata.filey=guidata.fileY;
viewdata.predict='on';
viewdata.view_data='on';
viewdata.view_predict='off';
viewdata.view_model='off';
viewdata.view_statistic='off';

refresh_gui(handles);

% load the data to plot
data=service.loadData([guidata.pathY guidata.fileY],'','',viewdata.misvalue,0,0);
viewdata.data=data;
% i show the original data w/o misdata

% --- Executes on button press in salva_previsione.
function salva_previsione_Callback(~, eventdata, handles)
% hObject    handle to salva_previsione (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(p,'Parent', handles.validate_graph)
global guidata;
global viewdata;

u=[ guidata.orderU1 guidata.orderU2];
period=guidata.period;
nomeFile=guidata.fileY;
nomeFileU1=guidata.fileU1;
nomeFileU2=guidata.fileU2;
orderY=guidata.orderY;
delay_u1=guidata.delay_u1;
delay_u2=guidata.delay_u2;
%get the current date and time
dt = datestr(now, 'mmmm dd, yyyy HH:MM:SS.FFF AM');

% info that will be saved in info file
path=[guidata.pathY,guidata.pathU1,guidata.pathU2];
%fileName=[ nomeFile nomeFileU1 nomeFileU2]
orders=[orderY, u];

if isempty(nomeFile)
    return;
end

s=dir(['history/*.val']);
valName=[];

for i=1:length(s)
    valName{i}=s(i).name;
end

answers = inputdlg('Type the name to save model:');
if isempty(answers)
    return;
end

history='history/';
val='.val';
txt='.txt';
mat='.mat';
name1=strcat(history,answers{1},val);
name2=strcat(history,answers{1},txt);
name3=strcat(history,answers{1},mat);

for i=1:length(valName)
    %take only the name
    valueName{i}=valName{i}(1:end-4);
    %check that the files i want to save there aren't in the directory history
    if strcmp(answers{1},valueName{i})
        ret_string = questdlg('The file exist! Do you want replace it?');
        ret=strcmp(ret_string,'Yes');
        if ret==1
            delete(name1);
            delete(name2);
            delete(name3);
        end
    end
end
disp('start save')
% store the current prevision and an info file
%save the data
f1 = Filewriter(name1);
f1.writeToFileD(viewdata.data.outputdata);
f1.delete();
clear f1;

%save the info
f2 = Filewriter(name2);
f2.writeToFile('----- MATARX -----------------------');
f2.writeToFile('----------------------------------');
f2.writeToFile('');
f2.writeToFile('Date and Time:');
f2.writeToFile(dt);
f2.writeToFile('');
f2.writeToFile('Used files during the simulation and path:');
%f3.writeToFile(fileName);
f2.writeToFile(nomeFile);
f2.writeToFile(nomeFileU1);
f2.writeToFile(nomeFileU2);
f2.writeToFile('');
f2.writeToFile(path);
f2.writeToFile('');
f2.writeToFile('Order of  [ y - u1 - u2 ]');
f2.writeToFileD(orders);
f2.writeToFile('');
f2.writeToFile('Delay of u1:');
f2.writeToFileD(delay_u1);
f2.writeToFile('Delay of u2:')
f2.writeToFileD(delay_u2);
f2.writeToFile('');
f2.writeToFile('----------------------------------');
f2.delete();
clear f2;

%save the field of the gui
save(name3, 'viewdata');
disp('end save');

initialize_popupmenu(handles);

% --- Executes on button press in createModel_button.
function createModel_button_Callback(hObject, eventdata, handles)
% hObject    handle to createModel_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global data;
global model;
global viewdata;
global errid;

u=[guidata.orderU1 guidata.orderU2];
period=guidata.period;
internalstat=[viewdata.internalstat];
orderY=guidata.orderY;
delay_u1=guidata.delay_u1;
delay_u2=guidata.delay_u2;

if ~isempty(guidata.orderY)
    data=service.loadData([guidata.pathY guidata.fileY],[guidata.pathU1 guidata.fileU1],[guidata.pathU2 guidata.fileU2],viewdata.misvalue,guidata.orderU1,guidata.orderU2);
    % this method create the model with the function predict
    [model]=mainCore.predict(1,0,data,period,internalstat,orderY,u,1,delay_u1,delay_u2,viewdata.misvalue); 
    [stima, tempdata, tempred]=mainCore.predict(0,model,data,period,internalstat,orderY,u,1,delay_u1,delay_u2,viewdata.misvalue);
    if(isempty(tempdata)) % no stazionariety
        errid=service.calErrors(stima,data.outputdata,0,viewdata.misvalue,guidata.edit_step);
    else
        errid=service.calErrors(tempred,tempdata,1,viewdata.misvalue,guidata.edit_step);
    end
    % set the interface
    viewdata.filey_validation='on';
    viewdata.fileu1_validation='on';
    viewdata.fileu2_validation='on';
    viewdata.view_model='on';
    viewdata.model=model;
    modStr=service.createModStr(model,guidata,viewdata);
    viewdata.model_text=modStr;
    viewdata.view_statistic='on';
    viewdata.view_predict='off';
    viewdata.min_ide=errid(1);
    viewdata.err_ide=errid(2);
    viewdata.corr_ide=errid(3);
    viewdata.var_ide=errid(4);
    viewdata.dati_usati_ide=errid(5);
    refresh_gui(handles);
end
% --- Executes on button press in exogen_u1.
function exogen_u1_Callback(hObject, eventdata, handles)
% hObject    handle to exogen_u1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global data;
global viewdata;

% this method load the exogenous part
[ guidata.fileU1 , guidata.pathU1] = uigetfile( ...
    '*.*' , 'Select the AX part U1' );
if ~ischar(guidata.fileU1);
    return;
end

emptyu1=isempty(guidata.fileU1);

% this code set the data field in the gui
if ~emptyu1
    set(handles.fileu1,'String',guidata.fileU1);
end
viewdata.fileu1=guidata.fileU1;


% --- Executes on button press in exogen_u2.
function exogen_u2_Callback(hObject, eventdata, handles)
% hObject    handle to exogen_u2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global data;
global viewdata;

% this method load the exogenous part
[ guidata.fileU2 , guidata.pathU2] = uigetfile( ...
    '*.*' , 'Select the AX part U2' );
if ~ischar(guidata.fileU2);
    return;
end


emptyu2=isempty(guidata.fileU2);
% this code set the data field in the gui

if ~emptyu2
    set(handles.fileu2,'String',guidata.fileU2);
end
viewdata.fileu2=guidata.fileU2;


function ordery_Callback(hObject, eventdata, handles)
% hObject    handle to ordery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ordery as text
%        str2double(get(hObject,'String')) returns contents of ordery as a double
global guidata;
global viewdata;
temp=get(handles.ordery,'String');
guidata.orderY=str2double(temp);
viewdata.ordery=guidata.orderY;
refresh_gui(handles);

% --- Executes during object creation, after setting all properties.
function ordery_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ordery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orderu1_Callback(hObject, eventdata, handles)
% hObject    handle to orderu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orderu1 as text
%        str2double(get(hObject,'String')) returns contents of orderu1 as a double
global guidata;
global viewdata;
temp=get(handles.orderu1,'String');
guidata.orderU1=str2double(temp);
viewdata.orderu1=guidata.orderU1;
refresh_gui(handles);

% --- Executes during object creation, after setting all properties.
function orderu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orderu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orderu2_Callback(hObject, eventdata, handles)
% hObject    handle to orderu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orderu2 as text
%        str2double(get(hObject,'String')) returns contents of orderu2 as a double
global guidata;
global viewdata;
temp=get(handles.orderu2,'String');
guidata.orderU2=str2double(temp);
viewdata.orderu2=guidata.orderU2;
refresh_gui(handles);

% --- Executes during object creation, after setting all properties.
function orderu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orderu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function period_Callback(hObject, eventdata, handles)
% hObject    handle to period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of period as text
%        str2double(get(hObject,'String')) returns contents of period as a double
global guidata;
global viewdata;

temp=get(handles.period,'String');
if isempty(temp)
    temp='0';
end
guidata.period=str2double(temp);
viewdata.period=guidata.period;
viewdata.tempstat_enable='on';
viewdata.add_statio='on';
viewdata.delete_statio='on';
refresh_gui(handles);


% --- Executes during object creation, after setting all properties.
function period_CreateFcn(hObject, eventdata, handles)
% hObject    handle to period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tempstat_Callback(hObject, eventdata, handles)
% hObject    handle to tempstat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tempstat as text
%        str2double(get(hObject,'String')) returns contents of tempstat as a double
global guidata;
temp=get(handles.tempstat,'String');
guidata.tempstat=str2double(temp);

% --- Executes during object creation, after setting all properties.
function tempstat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tempstat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_statio.
function add_statio_Callback(hObject, eventdata, handles)
% hObject    handle to add_statio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

newstat=get(handles.tempstat,'String');
newstat=str2double(newstat);
%guidata.internalstat=[guidata.internalstat;newstat];
%guidata.internalstat;
viewdata.internalstat=[viewdata.internalstat;newstat];
viewdata.internalstat;


initialize_listbox(handles);

% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in view_model.
function view_model_Callback(hObject, eventdata, handles)
% hObject    handle to view_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global model;
global guidata;
global viewdata;

delay_u1=guidata.delay_u1;
delay_u2=guidata.delay_u2;
%len=length(menu_help);
len=length(viewdata.model);

%if isempty(menu_help)
if isempty(viewdata.model)
    return;
end

for i=1:len % for each model I create string that rapresent the model of each stationariety
    mody=[];
    %menu_help{i};
    viewdata.model{i};
    n_c=[];
    n_ciclo=sprintf('\nmodel %d:\n',i);
    n_c=[n_c, n_ciclo];
    
    if(guidata.orderY>0)
        for j1=1:guidata.orderY
            %tempy=[num2str(menu_help{i}(j)) '*y(t-' int2str(j) ') + '] ;
            tempy=[num2str(viewdata.model{i}(j1)) '*y(t-' int2str(j1) ') + '] ;
            mody=[mody tempy];
        end
    end
    
    modu1=[];
%    n=0;
    n=delay_u1;
    if(guidata.orderU1>0)
      %  for j=guidata.orderY:guidata.orderY+guidata.orderU1
      j1=j1+1;
        for j2=j1:guidata.orderU1+j1-1
            n=n+1;
            %tempu1=['+ ' num2str(menu_help{i}(j)) '*u1(t-' int2str(n) ') '];
            tempu1=['+ ' num2str(viewdata.model{i}(j2)) '*u1(t-' int2str(n) ') '];
            modu1=[modu1 tempu1];
        end
    end
    
    modu2=[];
%    n=0;
    n=delay_u2;
    if (guidata.orderU2>0)
        j2=j2+1
        %for j=guidata.orderY+guidata.orderU1:guidata.orderY+guidata.orderU1+guidata.orderU2
        for j3=j2:guidata.orderU2+j2-1
            n=n+1;
            %tempu2=['+ ' num2str(menu_help{i}(j)) '*u2(t-' int2str(n) ') '];
            tempu2=['+ ' num2str(viewdata.model{i}(j3)) '*u2(t-' int2str(n) ') '];
            modu2=[modu2 tempu2];
        end
    end
    
    %mod{i}=[ n_c mody(1:end-2) modu1 modu2];

    %%%%%%%
    %
    depolariz=model{1}(end);
    dep=['+ ' num2str(depolariz)];
    err=' + e(t)';
    mod{i}=[ n_c mody(1:end-2) modu1 modu2 dep err];
    %
    %%%%%%%
    mod{i}(1:end);
end

viewdata.mod=mod;
gui_model(viewdata);

% --- Executes on button press in view_statistic.
function view_statistic_Callback(hObject, eventdata, handles)
% hObject    handle to view_statistic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global viewdata;
statistics(viewdata);

% --- Executes on button press in delete_statio.
function delete_statio_Callback(hObject, eventdata, handles)
% hObject    handle to delete_statio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

% get the selected item from the listbox
selected=get(handles.listbox2,'Value');

% remove selected from internalstat
newstat=[];
if selected~=1
    for i=1:selected-1
        %       newstat=[newstat;guidata.internalstat(i)];
        newstat=[newstat;viewdata.internalstat(i)];
    end
end
%if selected~=length(guidata.internalstat)
%for i=selected+1:length(guidata.internalstat)
%    newstat=[newstat;guidata.internalstat(i)];
%end
%end
%guidata.internalstat=newstat;
if selected~=length(viewdata.internalstat)
    for i=selected+1:length(viewdata.internalstat)
        newstat=[newstat;viewdata.internalstat(i)];
    end
end
viewdata.internalstat=newstat;
initialize_listbox(handles);

% --- Executes on button press in sub_button2.
function sub_button2_Callback(hObject, eventdata, handles)
% hObject    handle to sub_button2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected=get(handles.popupmenu1,'UserData');
selected=selected{get(handles.popupmenu1,'Value')};
ret_string = questdlg('Are you sure?');
ret=strcmp(ret_string,'Yes');
if ret==1
    valName=['history/' selected '.val']
    delete(valName);
    txtName=['history/' selected '.txt']
    delete(txtName);
    matName=['history/' selected '.mat']
    delete(matName);
end
initialize_popupmenu(handles);

%this method update the listbox
function update_listbox(handles)
newvalue=[];

set(handles.listbox2,'String','prova','value',1);

% this methot initialize the popup menu
function initialize_popupmenu(handles)
global viewdata;

s=dir(['history/*.val']);
valName=[];
for i=1:length(s)
    valName{i}=s(i).name;
end
valueName{1}=[];
for i=1:length(valName)
    % take only the name
    valueName{i}=valName{i}(1:end-4);
end
% set the name that appear
set(handles.popupmenu1,'String',valueName);
% set the appropriate value
set(handles.popupmenu1,'UserData',valueName);
% set the starting value to 1
set(handles.popupmenu1,'Value',1);

% if the popupmenù is empy the graph is resetted
if isempty(valueName{1})
    viewdata.view_model='off';
    viewdata.view_statistic='off';
    viewdata.view_data='off';
    viewdata.view_predict='off';
    refresh_gui(handles);
end

%initialze the field in the gui.
function initialize_guidata(handles)
global guidata;
global model;
global viewdata;
global prevision;

prevision=[];
model=[];

% inizialize data object
guidata.fileY=[];
guidata.fileU1=[];
guidata.fileU2=[];
guidata.pathY=[];
guidata.pathU1=[];
guidata.pathU2=[];
guidata.fileY_prev=[];
guidata.fileU1_prev=[];
guidata.fileU2_prev=[];
guidata.pathY_prev=[];
guidata.pathU1_prev=[];
guidata.pathU2_prev=[];
guidata.fileY_val=[];
guidata.fileU1_val=[];
guidata.fileU2_val=[];
guidata.pathY_val=[];
guidata.pathU1_val=[];
guidata.pathU2_val=[];
guidata.orderU1=0;
guidata.orderU2=0;
guidata.orderY=1;
guidata.period=0;
guidata.internalstat=[];
guidata.tempstat=[];
guidata.edit_step=1;
guidata.delay_u2=0;
guidata.delay_u1=0;
guidata.maxstep=0;
guidata.model_text='';

viewdata.misvalue=9999.99;
viewdata.filey='';
viewdata.fileu1='';
viewdata.fileu2='';
viewdata.filey_val='';
viewdata.fileu1_val='';
viewdata.fileu2_val='';
viewdata.filey_prev='';
viewdata.fileu1_prev='';
viewdata.fileu2_prev='';
viewdata.ordery='';
viewdata.edit_step='';
viewdata.delay_u1='';
viewdata.delay_u2='';
viewdata.orderu1='';
viewdata.orderu2='';
viewdata.period='';
viewdata.tempstat='';
viewdata.listbox2='';
viewdata.view_model='';
viewdata.view_statistic='';
viewdata.tempstat_enable='off';
viewdata.view_predict='';
viewdata.salva_previsione='';
viewdata.predict='off';
viewdata.mod='';
viewdata.model=[];
viewdata.data=[];
viewdata.internalstat=[];
viewdata.view_data='';
viewdata.add_statio='off';
viewdata.delete_statio='off';
viewdata.maxstep=0;
viewdata.model_text='';

%statistics
viewdata.var_ide='';
viewdata.var_val='';
viewdata.var_prev='';
viewdata.min_ide='';
viewdata.min_val='';
viewdata.min_prev='';
viewdata.err_ide='';
viewdata.err_val='';
viewdata.err_prev='';
viewdata.corr_ide='';
viewdata.corr_val='';
viewdata.corr_prev='';
viewdata.dati_usati_ide='';
viewdata.dati_usati_val='';
viewdata.dati_usati_prev='';

%validate
viewdata.filey_validation='';
viewdata.fileu1_validation='';
viewdata.fileu2_validation='';
viewdata.validate_button='';

%predict
viewdata.filey_prevision='';
viewdata.fileu1_prevision='';
viewdata.fileu2_prevision='';
viewdata.predict_button='';

% %validate
set(handles.filey_validation,'Enable','off');
set(handles.fileu1_validation,'Enable','off');
set(handles.fileu2_validation,'Enable','off');
set(handles.validate_button,'Enable','off');
% 
% %predict
set(handles.filey_prevision,'Enable','off');
set(handles.fileu1_prevision,'Enable','off');
set(handles.fileu2_previison,'Enable','off');
set(handles.predict_button,'Enable','off');


set(handles.model_text,'String','y(t) =');
set(handles.filey,'String','empty');
set(handles.fileu1,'String','empty');
set(handles.fileu2,'String','empty');
set(handles.filey_val,'String','empty');
set(handles.fileu1_val,'String','empty');
set(handles.fileu2_val,'String','empty');
set(handles.filey_prev,'String','empty');
set(handles.fileu1_prev,'String','empty');
set(handles.fileu2_prev,'String','empty');
set(handles.ordery,'String','1');
set(handles.edit_step,'String','0');
set(handles.delay_u1,'String','0');
set(handles.delay_u2,'String','0');
set(handles.orderu1,'String','0');
set(handles.orderu2,'String','0');
set(handles.tempstat,'String','0');
set(handles.tempstat,'Enable','off');
set(handles.period,'String','0');
set(handles.listbox2,'String','');
set(handles.listbox2,'Value',1);
set(handles.view_model,'Enable','off');
set(handles.view_statistic,'Enable','off');
set(handles.view_data,'Enable','off');
set(handles.view_predict,'Enable','off');
set(handles.add_statio,'Enable','off');
set(handles.delete_statio,'Enable','off');
set(handles.createModel_button,'Enable','off');
set(handles.maxstep,'Enable','off');
set(handles.edit_step,'String','0');
set(handles.edit_step,'Enable','off');
set(handles.misval,'String',viewdata.misvalue);


%this function refresh each field in the gui
function refresh_gui(handles)
global model;
global viewdata;

if isempty(viewdata.misvalue)
    viewdata.misvalue=viewdata.misvalue;
    set(handles.misval,'String',viewdata.misvalue);
else
    set(handles.misval,'String',viewdata.misvalue);
end

if isempty(viewdata.model_text)
    set(handles.model_text,'String','y(t) =');
else
    %viewdata.model_text
    set(handles.model_text,'String',viewdata.model_text); 
end

if isempty(viewdata.filey)
    set(handles.filey,'String','empty');
else
    set(handles.filey,'String',viewdata.filey);
end

if (isempty(viewdata.fileu1))
    set(handles.fileu1,'String','empty');
else
    set(handles.fileu1,'String',viewdata.fileu1);
end

if isempty(viewdata.fileu2)
    set(handles.fileu2,'String','empty');
else
    set(handles.fileu2,'String',viewdata.fileu2);
end

if isempty(viewdata.filey_val)
    set(handles.filey_val,'String','empty');
else
    set(handles.filey_val,'String',viewdata.filey_val);
end

if (isempty(viewdata.fileu1_val))
    set(handles.fileu1_val,'String','empty');
else
    set(handles.fileu1_val,'String',viewdata.fileu1_val);
end

if isempty(viewdata.fileu2_val)
    set(handles.fileu2_val,'String','empty');
else
    set(handles.fileu2_val,'String',viewdata.fileu2_val);
end

if isempty(viewdata.filey_prev)
    set(handles.filey_prev,'String','empty');
else
    set(handles.filey_prev,'String',viewdata.filey_prev);
end

if (isempty(viewdata.fileu1_prev))
    set(handles.fileu1_prev,'String','empty');
else
    set(handles.fileu1_prev,'String',viewdata.fileu1_prev);
end

if isempty(viewdata.fileu2_prev)
    set(handles.fileu2_prev,'String','empty');
else
    set(handles.fileu2_prev,'String',viewdata.fileu2_prev);
end

if isempty(viewdata.ordery)
    set(handles.ordery,'String','1');
else
    set(handles.ordery,'String',viewdata.ordery);
end

% chek if the edit text "edit_step" in the GUI is empy
% or not. If is not empty i refresh the GUI with the
% current value
if isempty(viewdata.edit_step)
    set(handles.edit_step,'String','1');
else
    set(handles.edit_step,'Enable','on');
    set(handles.edit_step,'String',viewdata.edit_step);
end

% chek if the edit text "delay_u1" in the GUI is empy
% or not. If is not empty i refresh the GUI with the
% current value
if isempty(viewdata.delay_u1)
    set(handles.delay_u1,'String','0');
else
    set(handles.delay_u1,'String',viewdata.delay_u1);
end

% chek if the edit text "delay_u2" in the GUI is empy
% or not. If is not empty i refresh the GUI with the
% current value
if isempty(viewdata.delay_u2)
    set(handles.delay_u2,'String','0');
else
    set(handles.delay_u2,'String',viewdata.delay_u2);
end

if isempty(viewdata.orderu1)
    set(handles.orderu1,'String','0');
else
    set(handles.orderu1,'String',viewdata.orderu1);
end

if isempty(viewdata.orderu2)
    set(handles.orderu2,'String','0');
else
    set(handles.orderu2,'String',viewdata.orderu2);
end

if isempty(viewdata.tempstat)
    set(handles.tempstat,'String','0');
else
    set(handles.tempstat,'String',viewdata.tempstat);
end

if isempty(viewdata.period)
    set(handles.period,'String','0');
else
    set(handles.tempstat,'Enable',viewdata.tempstat_enable);
    set(handles.period,'String',viewdata.period);
end

if isempty(viewdata.listbox2)
    set(handles.listbox2,'String','');
else
    set(handles.listbox2,'String',viewdata.listbox2);
end

if isempty(viewdata.listbox2)
    set(handles.listbox2,'Value',1);
else
    set(handles.listbox2,'String',viewdata.listbox2);
end

if isempty(viewdata.view_model)
    set(handles.view_model,'Enable','off');
else
    set(handles.view_model,'Enable',viewdata.view_model);
end

if isempty(viewdata.view_statistic)
    set(handles.view_statistic,'Enable','off');
else
    set(handles.view_statistic,'Enable',viewdata.view_statistic);
end

if isempty(viewdata.view_data)
    set(handles.view_data,'Enable','off');
else
    set(handles.view_data,'Enable',viewdata.view_data);
end
if isempty(viewdata.view_predict)
    set(handles.view_predict,'Enable','off');
else
    set(handles.view_predict,'Enable',viewdata.view_predict);
end
if isempty(viewdata.predict)
    set(handles.createModel_button,'Enable','off');
else
    set(handles.createModel_button,'Enable',viewdata.predict);
end
if isempty(viewdata.add_statio)
    set(handles.add_statio,'Enable','off');
else
    set(handles.add_statio,'Enable',viewdata.add_statio);
end
if isempty(viewdata.delete_statio)
    set(handles.delete_statio,'Enable','off');
else
    set(handles.delete_statio,'Enable',viewdata.delete_statio);
end
if isempty(viewdata.model)
    %set(handles.delete_statio,'Enable','off');
else
    viewdata.model=viewdata.model;
end
if isempty(viewdata.data)
    %set(handles.delete_statio,'Enable','off');
else
    viewdata.data=viewdata.data;
end
if isempty(viewdata.internalstat)
    %set(handles.delete_statio,'Enable','off');
else
    viewdata.internalstat=viewdata.internalstat;
    initialize_listbox(handles);
end
%Set the maximum number of the step.
if ~isempty(viewdata.maxstep)
        set(handles.maxstep,'String',viewdata.maxstep);
else if isempty(viewdata.delay_u2) & isempty(viewdata.delay_u2)
            set(handles.maxstep,'String','99');
    else
            temp=service.maxstep( viewdata.delay_u1, viewdata.delay_u2);
            set(handles.maxstep,'String',temp);
    end
end

%refresh statistics
if ~isempty(viewdata.err_ide)
    viewdata.err_ide=viewdata.err_ide;
end
if ~isempty(viewdata.err_val)
    viewdata.err_val=viewdata.err_val;
end
if ~isempty(viewdata.err_prev)
    viewdata.err_prev=viewdata.err_prev;
end
if ~isempty(viewdata.corr_ide)
    viewdata.corr_ide=viewdata.corr_ide;
end
if ~isempty(viewdata.corr_val)
    viewdata.corr_val=viewdata.corr_val;
end
if ~isempty(viewdata.corr_prev)
    viewdata.corr_prev=viewdata.corr_prev;
end
if ~isempty(viewdata.var_ide)
    viewdata.var_ide=viewdata.var_ide;
end
if ~isempty(viewdata.var_val)
    viewdata.var_val=viewdata.var_val;
end
if ~isempty(viewdata.var_prev)
    viewdata.var_prev=viewdata.var_prev;
end
if ~isempty(viewdata.min_ide)
    viewdata.min_ide=viewdata.min_ide;
end
if ~isempty(viewdata.min_val)
    viewdata.min_val=viewdata.min_val;
end
if ~isempty(viewdata.min_prev)
    viewdata.min_prev=viewdata.min_prev;
end
if ~isempty(viewdata.dati_usati_ide)
    viewdata.dati_usati_ide=viewdata.dati_usati_ide;
end
if ~isempty(viewdata.dati_usati_val)
    viewdata.dati_usati_val=viewdata.dati_usati_val;
end
if ~isempty(viewdata.dati_usati_prev)
    viewdata.dati_usati_prev=viewdata.dati_usati_prev;
end

%validate
if isempty(viewdata.filey_validation)
    set(handles.filey_validation,'Enable','off');
else
    set(handles.filey_validation,'Enable',viewdata.filey_validation);
end
if isempty(viewdata.fileu1_validation)
    set(handles.fileu1_validation,'Enable','off');
else
    set(handles.fileu1_validation,'Enable',viewdata.fileu1_validation);
end
if isempty(viewdata.fileu2_validation)
    set(handles.fileu2_validation,'Enable','off');
else
    set(handles.fileu2_validation,'Enable',viewdata.fileu2_validation);
end
if isempty(viewdata.validate_button)
    set(handles.validate_button,'Enable','off');
else
    set(handles.validate_button,'Enable',viewdata.validate_button);
end
%prevision
if isempty(viewdata.filey_prevision)
    set(handles.filey_prevision,'Enable','off');
else
    set(handles.filey_prevision,'Enable',viewdata.filey_prevision);
end
if isempty(viewdata.fileu1_prevision)
    set(handles.fileu1_prevision,'Enable','off');
else
    set(handles.fileu1_prevision,'Enable',viewdata.fileu1_prevision);
end
if isempty(viewdata.fileu2_prevision)
    set(handles.fileu2_previison,'Enable','off');
else
    set(handles.fileu2_previison,'Enable',viewdata.fileu2_prevision);
end
if isempty(viewdata.predict_button)
    set(handles.predict_button,'Enable','off');
else
    set(handles.predict_button,'Enable',viewdata.predict_button);
end

disp('end refresh gui');

%
% function that put the stationariety in the box
function initialize_listbox(handles)
global guidata;
global viewdata;


valueName{1}=[];
%for i=1:length(guidata.internalstat)
%    valueName{i}=guidata.internalstat(i);
for i=1:length(viewdata.internalstat)
    valueName{i}=viewdata.internalstat(i);
end


% set the name that appear
set(handles.listbox2,'String',valueName);
% set the appropriate value
set(handles.listbox2,'UserData',valueName);
% set the starting value to 1
set(handles.listbox2,'Value',1);


% --- Executes on button press in removeu1.
function removeu1_Callback(hObject, eventdata, handles)
% hObject    handle to removeu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

set(handles.fileu1,'String','empty');
guidata.fileU1=[];
guidata.pathU1=[];
viewdata.fileu1='';
refresh_gui(handles);

% --- Executes on button press in removeu2.
function removeu2_Callback(hObject, eventdata, handles)
% hObject    handle to removeu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

set(handles.fileu2,'String','empty');
guidata.fileU2=[];
guidata.pathU2=[];

viewdata.fileu2='';
refresh_gui(handles);

% --- Executes during object creation, after setting all properties.
function add_statio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to add_statio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% clear data
initialize_guidata(handles);
% reset graph
%cla(handles.validate_graph,'reset')
%cla(handles.predict_graph,'reset')


% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuEdit_Callback(hObject, eventdata, handles)
% hObject    handle to menuEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuView_Callback(hObject, eventdata, handles)
% hObject    handle to menuView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_help_Callback(hObject, eventdata, handles)
% hObject    handle to menu_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuHelp_doc_Callback(hObject, eventdata, handles)
% hObject    handle to menuHelp_doc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open doc/MATARX_mu.pdf;

% --------------------------------------------------------------------
function menuHelp_about_Callback(hObject, eventdata, handles)
% hObject    handle to menuHelp_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open doc/about.html;

% --- Executes on button press in view_data.
function view_data_Callback(hObject, eventdata, handles)
% hObject    handle to view_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global viewdata;
figure(100);
data=viewdata.data;
plot(data,'g');
hold off;

% --- Executes on button press in view_predict.
function view_predict_Callback(hObject, eventdata, handles)
% hObject    handle to view_predict (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global viewdata;
global validation;
global prevision;
global predData;

figure(100);
plot(predData,'g');
hold on;
prevplot=prevision
prevplot(find(prevplot==viewdata.misvalue))=NaN;
plot(prevplot,'b');
grid on
legend('misura','predizione')
hold off;
grid off;

% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

% --------------------------------------------------------------------
function view_data_menu_Callback(hObject, eventdata, handles)
% hObject    handle to view_data_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
view_data_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function view_statistic_menu_Callback(hObject, eventdata, handles)
% hObject    handle to view_statistic_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
view_statistic_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function view_prevision_menu_Callback(hObject, eventdata, handles)
% hObject    handle to view_prevision_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
view_predict_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function reset_menu_Callback(hObject, eventdata, handles)
% hObject    handle to reset_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
reset_button_Callback(hObject, eventdata, handles);



function edit_step_Callback(hObject, eventdata, handles)
% hObject    handle to edit_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_step as text
%        str2double(get(hObject,'String')) returns contents of edit_step as a double
global guidata;
global viewdata;
temp=get(handles.edit_step,'String');
guidata.edit_step=str2double(temp);

max=get(handles.maxstep,'String');
guidata.maxstep=str2double(max);

if guidata.edit_step>guidata.maxstep
    display('error')
else
    viewdata.edit_step=guidata.edit_step;
end
refresh_gui(handles);

% --- Executes during object creation, after setting all properties.
function edit_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function delay_u1_Callback(hObject, eventdata, handles)
% hObject    handle to delay_u1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delay_u1 as text
%        str2double(get(hObject,'String')) returns contents of delay_u1 as a double
global guidata;
global viewdata;
temp=get(handles.delay_u1,'String');
guidata.delay_u1=str2double(temp);
viewdata.delay_u1=guidata.delay_u1;
refresh_gui(handles);

% --- Executes during object creation, after setting all properties.
function delay_u1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delay_u1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function info_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to info_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function delay_u2_Callback(hObject, eventdata, handles)
% hObject    handle to delay_u2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delay_u2 as text
%        str2double(get(hObject,'String')) returns contents of delay_u2 as a double
global guidata;
global viewdata;
temp=get(handles.delay_u2,'String');
guidata.delay_u2=str2double(temp);
viewdata.delay_u2=guidata.delay_u2;
refresh_gui(handles);

% --- Executes during object creation, after setting all properties.
function delay_u2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delay_u2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menuHelp_model_Callback(hObject, eventdata, handles)
% hObject    handle to menuHelp_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open doc/model.html;



function maxstep_Callback(hObject, eventdata, handles)
% hObject    handle to maxstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxstep as text
%        str2double(get(hObject,'String')) returns contents of maxstep as a double
global guidata;
global viewdata;

% maxstep=service.maxStep( guidata.delayu1, guidata.delayu2);
% 
% temp=set(handles.maxstep,'0');
% guidata.edit15=str2double(temp);
% viewdata.edit15=guidata.edit15;
% refresh_gui(handles);

% --- Executes during object creation, after setting all properties.
function maxstep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fileu1_prevision.
function fileu1_prevision_Callback(hObject, eventdata, handles)
% hObject    handle to fileu1_prevision (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global data;
global viewdata;

% this method load the exogenous part
[ guidata.fileU1_prev , guidata.pathU1_prev] = uigetfile( ...
    '*.*' , 'Select the AX part U1' );
if ~ischar(guidata.fileU1_prev);
    return;
end

emptyu1_prev=isempty(guidata.fileU1_prev);

% this code set the data field in the gui
if ~emptyu1_prev
    set(handles.fileu1_prev,'String',guidata.fileU1_prev);
end
viewdata.fileu1_prev=guidata.fileU1_prev;

% --- Executes on button press in fileu2_previison.
function fileu2_previison_Callback(hObject, eventdata, handles)
% hObject    handle to fileu2_previison (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global data;
global viewdata;

% this method load the exogenous part
[ guidata.fileU2_prev , guidata.pathU2_prev] = uigetfile( ...
    '*.*' , 'Select the AX part U2' );
if ~ischar(guidata.fileU2_prev);
    return;
end


emptyu2_prev=isempty(guidata.fileU2_prev);
% this code set the data field in the gui

if ~emptyu2_prev
    set(handles.fileu2_prev,'String',guidata.fileU2_prev);
end
viewdata.fileu2_prev=guidata.fileU2_prev;

% --- Executes on button press in filey_prevision.
function filey_prevision_Callback(hObject, eventdata, handles)
% hObject    handle to filey_prevision (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

% this method load the exogenous part
[ guidata.fileY_prev , guidata.pathY_prev] = uigetfile( ...
    '*.*' , 'Select the AR part' );
if ~ischar(guidata.fileY_prev);
    return;
end

emptyy_prev=isempty(guidata.fileY_prev);
if ~emptyy_prev  
    set(handles.filey_prev,'String',guidata.fileY_prev);
    viewdata.predict_button='on';
end
% this code set the data field in the gui
viewdata.filey_prev=guidata.fileY_prev;
viewdata.prevision='on';

refresh_gui(handles);

% load the data to plot
data_prev=service.loadData([guidata.pathY_prev guidata.fileY_prev],'','',viewdata.misvalue,0,0);
viewdata.data_prev=data_prev;

% --- Executes on button press in filey_validation.
function filey_validation_Callback(hObject, eventdata, handles)
% hObject    handle to filey_validation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

% this method load the exogenous part
[ guidata.fileY_val , guidata.pathY_val] = uigetfile( ...
    '*.*' , 'Select the AR part' );
if ~ischar(guidata.fileY_val);
    return;
end

emptyy_val=isempty(guidata.fileY_val);
if ~emptyy_val  
    set(handles.filey_val,'String',guidata.fileY_val);
    viewdata.validate_button='on';
end
% this code set the data field in the gui
viewdata.filey_val=guidata.fileY_val;
viewdata.validate='on';

refresh_gui(handles);

% load the data to plot
data_val=service.loadData([guidata.pathY_val guidata.fileY_val],'','',viewdata.misvalue,0,0);
viewdata.data_val=data_val;
% i show the original data w/o misdata

% --- Executes on button press in fileu1_validation.
function fileu1_validation_Callback(hObject, eventdata, handles)
% hObject    handle to fileu1_validation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global data;
global viewdata;

% this method load the exogenous part
[ guidata.fileU1_val , guidata.pathU1_val] = uigetfile( ...
    '*.*' , 'Select the AX part U1' );
if ~ischar(guidata.fileU1_val);
    return;
end

emptyu1_val=isempty(guidata.fileU1_val);

% this code set the data field in the gui
if ~emptyu1_val
    set(handles.fileu1_val,'String',guidata.fileU1_val);
end
viewdata.fileu1_val=guidata.fileU1_val;

% --- Executes on button press in fileu2_validation.
function fileu2_validation_Callback(hObject, eventdata, handles)
% hObject    handle to fileu2_validation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global data;
global viewdata;

% this method load the exogenous part
[ guidata.fileU2_val , guidata.pathU2_val] = uigetfile( ...
    '*.*' , 'Select the AX part U2' );
if ~ischar(guidata.fileU2_val);
    return;
end


emptyu2_val=isempty(guidata.fileU2_val);
% this code set the data field in the gui

if ~emptyu2_val
    set(handles.fileu2_val,'String',guidata.fileU2_val);
end
viewdata.fileu2_val=guidata.fileU2_val;

% --- Executes on button press in predict_button.
function predict_button_Callback(hObject, eventdata, handles)
% hObject    handle to predict_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global dataPrediction;
global model;
global viewdata;
global prevision;
global errpred;
global predData;
global error;

u=[guidata.orderU1 guidata.orderU2];
period=guidata.period;
internalstat=[viewdata.internalstat];
orderY=guidata.orderY;
nStep=guidata.edit_step;
delay_u1=guidata.delay_u1;
delay_u2=guidata.delay_u2;

if ~isempty(guidata.fileY_prev)
    data=service.loadData([guidata.pathY_prev guidata.fileY_prev],[guidata.pathU1_prev guidata.fileU1_prev],[guidata.pathU2_prev guidata.fileU2_prev],viewdata.misvalue,guidata.orderU1,guidata.orderU2);
    predData=data;
    % this method create the model with the function predict
    [prevision, tempdata, tempred]=mainCore.predict(0,model,data,period,internalstat,orderY,u,nStep,delay_u1,delay_u2,viewdata.misvalue); 
    if(isempty(tempdata)) % no stazionariety
        [errpred error]=service.calErrors(prevision,data.outputdata,0,viewdata.misvalue,nStep); %viewdata.data_prev.outputdata,0);
    else
        [errpred error]=service.calErrors(tempred,tempdata,1,viewdata.misvalue,nStep);
    end
else
    disp('Please insert AutoregressiveY part');
end

viewdata.view_statistic='on';
viewdata.view_predict='on';
viewdata.min_prev=errpred(1);
viewdata.err_prev=errpred(2);
viewdata.corr_prev=errpred(3);
viewdata.var_prev=errpred(4);
viewdata.dati_usati_prev=errpred(5);
refresh_gui(handles);

% --- Executes on button press in validate_button.
function validate_button_Callback(hObject, eventdata, handles)
% hObject    handle to validate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global dataValidate;
global model;
global viewdata;
global validation;
global errval;

u=[guidata.orderU1 guidata.orderU2];
period=guidata.period;
internalstat=[viewdata.internalstat];
orderY=guidata.orderY;
delay_u1=guidata.delay_u1;
delay_u2=guidata.delay_u2;


if ~isempty(guidata.fileY_val)
    dataValidate=service.loadData([guidata.pathY_val guidata.fileY_val],[guidata.pathU1_val guidata.fileU1_val],[guidata.pathU2_val guidata.fileU2_val],viewdata.misvalue,guidata.orderU1,guidata.orderU2);
    % this method calculate the prediction
    [validation, tempdata, tempred]=mainCore.predict(0,model,dataValidate,period,internalstat,orderY,u,1,delay_u1,delay_u2,viewdata.misvalue); 
    if(isempty(tempdata)) % no stazionariety
        errval=service.calErrors(validation,dataValidate.outputdata,0,viewdata.misvalue,guidata.edit_step); % viewdata.data_val.outputdata,0);
    else
        errval=service.calErrors(tempred,tempdata,1,viewdata.misvalue,guidata.edit_step);
    end
    maxStep=service.maxstep(guidata);
else
    disp('Please insert AutoregressiveY part');
end
viewdata.maxstep=maxStep;
viewdata.edit_step='1';
viewdata.min_val=errval(1);
viewdata.err_val=errval(2);
viewdata.corr_val=errval(3);
viewdata.var_val=errval(4);
viewdata.dati_usati_val=errval(5);
viewdata.filey_prevision='on';
viewdata.fileu1_prevision='on';
viewdata.fileu2_prevision='on';
refresh_gui(handles);

% --- Executes on button press in delete_u1_p.
function delete_u1_p_Callback(hObject, eventdata, handles)
% hObject    handle to delete_u1_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

set(handles.fileu1_prev,'String','empty');
guidata.fileU1_prev=[];
guidata.pathU1_prev=[];
viewdata.fileu1_prev='';
refresh_gui(handles);

% --- Executes on button press in delete_u2_p.
function delete_u2_p_Callback(hObject, eventdata, handles)
% hObject    handle to delete_u2_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

set(handles.fileu2_prev,'String','empty');
guidata.fileU2_prev=[];
guidata.pathU2_prev=[];
viewdata.fileu2_prev='';
refresh_gui(handles);

% --- Executes on button press in delete_u1_v.
function delete_u1_v_Callback(hObject, eventdata, handles)
% hObject    handle to delete_u1_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

set(handles.fileu1_val,'String','empty');
guidata.fileU1_val=[];
guidata.pathU1_val=[];
viewdata.fileu1_val='';
refresh_gui(handles);

% --- Executes on button press in delete_u2_v.
function delete_u2_v_Callback(hObject, eventdata, handles)
% hObject    handle to delete_u2_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

set(handles.fileu2_val,'String','empty');
guidata.fileU2_val=[];
guidata.pathU2_val=[];
viewdata.fileu2_val='';
refresh_gui(handles);

% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

set(handles.filey_val,'String','empty');
guidata.fileY_val=[];
guidata.pathY_val=[];
viewdata.filey_val='';
refresh_gui(handles);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over filey.



function model_text_Callback(hObject, eventdata, handles)
% hObject    handle to model_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of model_text as text
%        str2double(get(hObject,'String')) returns contents of model_text as a double


% --- Executes during object creation, after setting all properties.
function model_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to model_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when Identification is resized.
function Identification_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to Identification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function load_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function filey_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function validate_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to validate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in delete_y_p.
function delete_y_p_Callback(hObject, eventdata, handles)
% hObject    handle to delete_y_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global guidata;
global viewdata;

set(handles.filey_prev,'String','empty');
guidata.fileY_prev=[];
guidata.pathY_prev=[];
viewdata.filey_prev='';
refresh_gui(handles);


% --- Executes on button press in save_prev.
function save_prev_Callback(hObject, eventdata, handles)
% hObject    handle to save_prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global prevision;
global validation;
global predData;
global error;

if isempty(prevision) | isempty(validation) | isempty(predData)
    return;
end

s=dir(['previsions/*.mat']);
valName=[];

for i=1:length(s)
    valName{i}=s(i).name;
end

answers = inputdlg('Type the name to save prevision and validation data:');
if isempty(answers)
    return;
end

previsions='previsions/';
prev='.mat';
pred='_predData.mat';
val='_validationData.mat';
err='_error.mat';
name1=strcat(previsions,answers{1},pred);
name2=strcat(previsions,answers{1},val);
name3=strcat(previsions,answers{1},prev);
name4=strcat(previsions,answers{1},err);

for i=1:length(valName)
    %take only the name
    valueName{i}=valName{i}(1:end-4);
    %check that the files i want to save there aren't in the directory history
    if strcmp(answers{1},valueName{i})
        ret_string = questdlg('The file exist! Do you want replace it?');
        ret=strcmp(ret_string,'Yes');
        if ret==1
            delete(name1);
            delete(name2);
            delete(name3);
            delete(name4);
        end
    end
end

save(name1, 'predData');
save(name2, 'validation');
save(name3, 'prevision');
save(name4, 'error');
msgbox('Save ok!','Save prevision');


% --- Executes on button press in ins_misvalue.
function ins_misvalue_Callback(hObject, eventdata, handles)
% hObject    handle to ins_misvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global viewdata;



function misval_Callback(hObject, eventdata, handles)
% hObject    handle to misval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of misval as text
%        str2double(get(hObject,'String')) returns contents of misval as a double
global viewdata;

temp=get(handles.misval,'String');
if isempty(temp)
    temp='9999.99';
end
viewdata.misvalue=str2double(temp);
refresh_gui(handles);


% --- Executes during object creation, after setting all properties.
function misval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to misval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
