function varargout = hmi(varargin)
% hmi MATLAB code for hmi.fig
%      hmi, by itself, creates a new hmi or raises the existing
%      singleton*.
%
%      H = hmi returns the handle to a new hmi or the handle to
%      the existing singleton*.
%
%      hmi('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in hmi.M with the given input arguments.
%
%      hmi('Property','Value',...) creates a new hmi or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hmi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hmi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hmi

% Last Modified by GUIDE v2.5 30-May-2015 16:37:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @hmi_OpeningFcn, ...
    'gui_OutputFcn',  @hmi_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
    
    addpath('Lumenera Matlab Driver V2.0.1 NEW 64 Bit')
end
% End initialization code - DO NOT EDIT


% --- Executes just before hmi is made visible.
function hmi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hmi (see VARARGIN)

% Choose default command line output for hmi

cla(handles.axes1)

handles.output = hObject;
bgcolor = [1 1 1];
set(hObject, 'Color', bgcolor);
set(findobj(hObject,'-property', 'BackgroundColor'), 'BackgroundColor', bgcolor);

%**************************************************************************
axes(handles.axes14);
A=imread('logo.jpg');
B=imrotate(A,90);
%save('logo.mat','B')
%load('logo.mat');
imshow(B,[]);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hmi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hmi_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

guidata(hObject,handles);
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Flag;
global g_modeInput;
cla(handles.axes1);

%% Lucam
if strcat(g_modeInput,'captureFrame')==1
    try
        LuDispatcher(-1, 1); % connect
    catch
        LuDispatcher(-2, 1); %disconnect
        LuDispatcher(-1, 1);
    end
end

i = 1;
if strcmp(get(handles.pushbutton1, 'String'), 'Pause')
    set(handles.pushbutton1, 'String', 'Start');
    Flag.Start = 0;
elseif strcmp(get(handles.pushbutton1, 'String'), 'Start')
    set(handles.pushbutton1,'String','Pause');
    Flag.Start = 1;
    upperbound = Inf;
    if strcmp(g_modeInput, 'video')==1
        imageSeriesVideo = importfile({'', 'video'});
        upperbound=length(imageSeriesVideo);
    end
    if strcmp(g_modeInput, 'imageSeries') == 1
        imageSeriesPhoto = importfile({'..\Samples\imageSeries\', 'imageSeries'});
        upperbound=length(imageSeriesPhoto);
    end
end

Flag.Time=1;
while Flag.Start==1 && Flag.Time<=upperbound
    Flag.Time=i;
    
    %tStart=tic;
    if strcmp(g_modeInput,'video')==1
        %--video--
        raw_image = imageSeriesVideo{Flag.Time};
        file_name = '';
        file_path = '';
    elseif strcmp(g_modeInput,'captureFrame')==1
        %--captureFrame--
        raw_image = automated_frame_catpure();
        file_name = '';
        file_path = '';
    elseif strcmp(g_modeInput,'imageSeries')==1
        %--imageSeries--
        raw_image = imageSeriesPhoto{Flag.Time};
        file_name = '';
        file_path = '';
    elseif strcmp(g_modeInput,'singlePhoto')==1
        %--singlePhoto--
        [file_name, file_path] = uigetfile({'*.jpg;*.tif;*.png;*.gif', ...
                                            'All Image Files'; '*.*', ...
                                            'All Files' }, 'Kepstrum', '..\Samples');
        if file_name == 0
            close all
            clear all
            hmi
        else
            output = importfile({[file_path, file_name], 'singlePhoto'});
            raw_image = output{1};
            Flag.Start = 0;
            file_name = file_name(1 : end-4);
        end
    end
    %% Particle Counter
    
    matlab_config_path = '../../conf.txt';
    config = load_config(matlab_config_path);
    output = image_initialization(raw_image, config);
    raw_image = output.raw_image;
    cropped_raw_image = output.cropped_raw_image;
    config            = output.config;
    calculation = particle_counter({cropped_raw_image, config, file_path, file_name});
  
    handles.calculation = calculation;
    centroid            = calculation.centroid;
    %% plotImage
    plotImage(hObject, eventdata, handles, {cropped_raw_image, centroid, config})
    
    %% Results
    area          = calculation.area;
    minorAxis     = calculation.minorAxis;
    majorAxis     = calculation.majorAxis;
    equivDiameter = calculation.equivDiameter;
    
    cond = get(handles.checkbox4,'value');
    val  = get(handles.popupmenu1,'value');
    Method = get(handles.popupmenu2,'value');
    
    matRes = [equivDiameter; majorAxis; minorAxis];
    if isempty(matRes)
        matRes=[0; 0; 0];
    end
    handles.ymean(:,i)  = mean(matRes,2);
    handles.ymedian(:,i)= median(matRes,2);
    handles.ymode(:,i)  = mode(matRes,2);
    switch Method
        case 1
            y = handles.ymean(:,i);
        case 2
            y = handles.ymedian(:,i);
        case 3
            y = handles.ymode(:,i);
    end
    %% plotHist
    plotHist(hObject, eventdata, handles,{val, cond, calculation});
    
    %*****************plotImage********************************************
    filename = strcat(num2str(Flag.Time), '.mat');
    TodayDate = date;
    if ~exist(['Images\', TodayDate],'dir')
        mkdir('Images\', TodayDate)
    end
    save(['Images\', TodayDate, '\', filename], 'calculation', 'cropped_raw_image');
    cmap = colormap('gray');
    imwrite(cropped_raw_image, cmap, ['Images\', TodayDate, '\', num2str(Flag.Time), '.jpg'], 'jpeg');
    %**********************************************************************
    plotVsTime(hObject, eventdata, handles,{y,i})
    %**********************************************************************
    guidata(hObject,handles);
    %tEnd=toc(tStart);
    set(handles.edit4, 'String', i);
    i = i + 1;
end

guidata(hObject,handles);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles)
if isfield(handles,'calculation')
    val  = get(handles.popupmenu1,'value');
    cond = get(handles.checkbox4,'value');
    calculation = handles.calculation;
    plotHist(hObject, eventdata, handles,{val,cond,calculation});
end
guidata(hObject,handles);
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


% --- Executes during object creation, after setting all properties.
function axes10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes10


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Flag
guidata(hObject,handles);
val = get(handles.checkbox4,'value');

if strcmp(get(handles.pushbutton1, 'String'), 'Start') && ~(get(handles.slider1,'Value') == 0)
    slider1value = get(handles.slider1,'Value');
    if Flag.Time > 20
        slider1value = Flag.Time - 20 + ceil(slider1value);
    end
    TodayDate = date;
    filename = strcat(num2str(ceil(slider1value)), '.mat');
    x = load(['Images\', TodayDate, '\', filename]);
    handles.calculation = x.calculation;
end
popupmenu1_Callback(hObject, eventdata, handles)
handles.Percentage = val;
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes during object creation, after setting all properties.
function axes14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes14

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
global Flag
global yRes
yRes = [];

switch get(handles.popupmenu2, 'value');
    case 1
        y = handles.ymean;
    case 2
        y = handles.ymedian;
    case 3
        y = handles.ymode;
end
cla(handles.axes1);
axes(handles.axes1)
if Flag.Time<=20
    timeMin = 1;
    timeMax = Flag.Time;
else
    timeMin = Flag.Time -20 + 1;
    timeMax = Flag.Time;
end
plot(timeMin:timeMax, y(1, timeMin:timeMax), '-' , 'LineWidth', 2, 'color', 'k')
hold on
plot(timeMin:timeMax, y(2, timeMin:timeMax), '-.', 'LineWidth', 2, 'color', 'k')
hold on
plot(timeMin:timeMax, y(3, timeMin:timeMax), '--', 'LineWidth', 2, 'color', 'k')
hold on
grid on
set(gca,'Xcolor',[0.5 0.5 0.5]);
set(gca,'Ycolor',[0.5 0.5 0.5]);
xlabel('Time [s]');
ylabel('Particle Size [mm]');
axis tight
legend('equivDiameter: Q3','majorAxis: Q2','minorAxis: Q1');

guidata(hObject,handles);

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function plotHist(hObject, eventdata, handles,vargin)
guidata(hObject,handles);
val          = vargin{1};
cond         = vargin{2};
calculation  = vargin{3};
if exist('calculation')
    majorAxis     = calculation.majorAxis;
    minorAxis     = calculation.minorAxis;
    area          = calculation.area;
    equivDiameter = calculation.equivDiameter;
    switch val
        case 1
            cla(handles.axes10);
            axes(handles.axes10)
            [C,x]=hist(equivDiameter);
            switch cond
                case 1
                    Cnew = C ./ sum(C) * 100;
                case 0
                    Cnew=C;
            end
            axes(handles.axes10)
            bar(x,Cnew,'Parent',handles.axes10);
            hold on
            plot(x,Cnew,'r','Marker','o','Linewidth',2);
            axis tight
            grid on
            xlabel('Particle Size [mm]','Fontsize',12);
            legend('Q3: equivDiameter');
        case 2
            cla(handles.axes10);
            axes(handles.axes10)
            [C, x] = hist(majorAxis);
            switch cond
                case 1
                    Cnew = C ./ sum(C) * 100;
                case 0
                    Cnew=C;
            end
            axes(handles.axes10)
            bar(x, Cnew);
            hold on
            plot(x, Cnew, 'r', 'Marker', 'o', 'Linewidth', 2);
            axis tight
            grid on
            xlabel('Particle Size [mm]', 'Fontsize', 12);
            legend('Q2: majorAxis');
        case 3
            cla(handles.axes10);
            axes(handles.axes10)
            [C,x]=hist(minorAxis);
            switch cond
                case 1
                    Cnew = C ./ sum(C) * 100;
                case 0
                    Cnew = C;
            end
            axes(handles.axes10)
            bar(x, Cnew);
            axis tight
            hold on
            plot(x, Cnew, 'r', 'Marker', 'o', 'Linewidth', 2)
            grid on
            xlabel('Particle Size [mm]', 'Fontsize', 12);
            legend('Q1: minorAxis');
        case 4
            cla(handles.axes10);
            axes(handles.axes10)
            Xtotal=[equivDiameter, majorAxis, minorAxis];
            bar(Xtotal, 'grouped');
            axis tight
            grid on
            legend('Q3: equivDiameter', 'Q2: majorAxis', 'Q1: minorAxis');
            xlabel('Particle Size [mm]', 'Fontsize',12);
    end
    axes(handles.axes10)
    title('Particle Diameter Distribution / Frame','Fontsize',12);
    switch cond
        case 1
            ylabel('Particle Count (percentile %)','Fontsize',12);
        case 0
            ylabel('Particle Count (number #)','Fontsize',12);
    end
end


function plotImage(hObject, eventdata, handles, vargin)
global g_modeInput;
guidata(hObject,handles)
raw_image = vargin{1};
centroid  = vargin{2};
num_particles = size(centroid,2) - 1;

cla(handles.axes7);
axes(handles.axes7)

if strcmp(g_modeInput, 'singlePhoto') == 1 || strcmp(g_modeInput, 'imageSeries') == 1
    ratioScaleDown = 0.25 * 2448 / size(raw_image, 2);
else
    ratioScaleDown = 1;
end
imshow(imresize(raw_image, ratioScaleDown), [], 'Parent', handles.axes7);
for  k = 0 : num_particles
    hold on
    x_particle = centroid(1, k+1) * ratioScaleDown;
    y_particle = centroid(2, k+1) * ratioScaleDown;
    scatter(x_particle, y_particle, 5, 'r*', 'Parent', handles.axes7);
end

cla(handles.axes15);
axes(handles.axes15);
imshow(imresize(raw_image,ratioScaleDown),[], 'Parent', handles.axes15);

function plotVsTime(hObject, eventdata, handles,vargin)
guidata(hObject,handles)
global yRes
global Flag
y = vargin{1};
box on
if isempty(yRes)
    cla(handles.axes1);
    yRes=y;
else
    if isempty(y)
        yRes=[yRes,[0;0;0]];
    else
        yRes=[yRes,y];
    end
end
axes(handles.axes1)
if size(yRes,2)==1
    
else
    plot(yRes(1,:),'-','LineWidth',2,'color','k')
    hold on
    plot(yRes(2,:),'-.','LineWidth',2,'color','k')
    hold on
    plot(yRes(3,:),'--','LineWidth',2,'color','k')
    hold on
    legend('equivDiameter: Q3','majorAxis: Q2','minorAxis: Q1');
end
grid on
set(gca,'Xcolor',[0.5 0.5 0.5]);
set(gca,'Ycolor',[0.5 0.5 0.5]);
xlabel('Time [s]');
ylabel('Particle Size [mm]');
xlim([max(Flag.Time,20)-20,max(Flag.Time,20)]);

guidata(hObject,handles)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderTemp = 0;
global Flag
if exist('Flag')
    while get(handles.pushbutton1,'Value') == 0 && sliderTemp == 0
        slider1value=get(handles.slider1,'Value');
        if Flag.Time > 20
            slider1value = Flag.Time - 20 + ceil(slider1value);
        end
        TodayDate = date;
        filename = strcat(num2str(ceil(slider1value)),'.mat');
        x = load(['Images\', TodayDate, '\', filename]);
        raw_image   = x.raw_image;
        centroidNew = x.calculation.centroid;
        %******************************************************************
        plotImage(hObject, eventdata, handles,{raw_image, centroidNew})
        %******************************************************************
        cond = get(handles.checkbox4, 'value');
        val  = get(handles.popupmenu1,'value');
        
        calculation = x.calculation;
        %******************************************************************
        plotHist(hObject, eventdata, handles,{val,cond,calculation});
        %******************************************************************
        sliderTemp=1;
    end
    set(handles.edit4,'String', ceil(slider1value));
end
guidata(hObject,handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textValue = str2num( get(handles.edit4,'String') );
set(handles.edit4,'Value',textValue)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
clear all
clc
hmi


% --- Executes when uipanel7 is resized.
function uipanel7_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clearclear all

% --------------------------------------------------------------------
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
Kepstrum


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g_modeInput;
contents = cellstr(get(hObject,'String'));
g_modeInput=contents{get(hObject,'Value')};

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
