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
    try
        gui_mainfcn(gui_State, varargin{:});
    catch ERROR
        logError = fopen('ERROR.txt','a');
        fprintf(logError,['%-' int2str(length(ERROR.message)) 's\r\n'],ERROR.message);
        fclose(logError);
    end
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

% --- Executes during object creation, after setting all properties.
function axes10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes10

% --- Executes during object creation, after setting all properties.
function axes14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes14

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderTemp = 0;
global Flag
if exist('Flag', 'var')
    while get(handles.pushbutton1,'Value') == 0 && sliderTemp == 0
        slider1value = ceil(get(handles.slider1,'Value'));
        if Flag.Time > 20
            slider1value = Flag.Time - 21 + slider1value;
        end
        TodayDate = date;
        filename = strcat(num2str(slider1value+1),'.mat');
        loaded_data = load(['Images\', TodayDate, '\', filename]);
        handles.raw_image   = loaded_data.raw_image;
        handles.calculation = loaded_data.calculation;
        %% plotImage
        plotImage(hObject, eventdata, handles)
        %% plotHist
        plotHist(hObject, eventdata, handles);
        sliderTemp = 1;
    end
    set(handles.edit4,'String', slider1value);
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
runtime


% --- Executes when uipanel7 is resized.
function uipanel7_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear all

% --------------------------------------------------------------------
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
Kepstrum

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

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Flag input_image_type particle_diameter_type parameter_over_time

i = 1;
if strcmp(get(handles.pushbutton1, 'String'), 'Pause')
    set(handles.pushbutton1, 'String', 'Start');
    Flag.Start = 0;
    runtime
elseif strcmp(get(handles.pushbutton1, 'String'), 'Start')
    cla(handles.axes1);
    set(handles.pushbutton1,'String','Pause');
    Flag.Time = 1;
    Flag.Start = 1;
    upperbound = Inf;
    if strcmp(input_image_type, 'video')==1
        sequence_of_images_video = import_video('F:\vision_sensor_pedram\particle_counter\videos\1.avi');
        upperbound = length(sequence_of_images_video);
    end
end


while Flag.Start == 1 && Flag.Time <= upperbound
    Flag.Time = i;
    if strcmp(input_image_type,'video')==1
        %--video--
        raw_image = sequence_of_images_video{Flag.Time};
    elseif strcmp(input_image_type,'lucam_camera')==1
        %--lucam_camera--
%         try
%             LuDispatcher(-1, 1); % connect
%         catch
%             LuDispatcher(-2, 1); %disconnect
%             LuDispatcher(-1, 1);
%         end
        calculation               = main('', 'true');

    elseif strcmp(input_image_type,'single_image')==1
        %--single_image--
        %[file_name, file_path] = uigetfile({'*.jpg;*.tif;*.png;*.gif', ...
        %                                    'All Image Files'; '*.*', ...
        %                                    'All Files' }, 'Kepstrum', '..\Samples');
        file_path = '/Users/Pedram/Dropbox/Ataee/[Repositories]/Khayyam/particle_counter/samples/';
        file_name = strcat(num2str(Flag.Time), '.jpg');
        if file_name == 0
            close all
            clear all
            runtime
        else
            Flag.Start = 1;
        end
        calculation = main([file_path, file_name], 'false');
    end    
    cropped_raw_image         = calculation.cropped_raw_image;
    raw_image                 = calculation.raw_image;
    handles.calculation       = calculation;
    handles.cropped_raw_image = cropped_raw_image;
    handles.raw_image         = raw_image;

    %% plotImage
    plotImage(hObject, eventdata, handles);
    %% plotHist
    plotHist(hObject, eventdata, handles);
    %% plotVsTime
    if strcmp(parameter_over_time, 'mean')
        handles.plotVsTime(i) = mean(calculation.(particle_diameter_type));
    elseif strcmp(parameter_over_time, 'contamination')
        handles.plotVsTime(i) = calculation.contam_level_gram_per_liter;
    end
    plotVsTime(hObject, eventdata, handles)
    %% save
    filename = strcat(num2str(Flag.Time), '.mat');
    TodayDate = date;
    if ~exist(['dataset_evaluation\', TodayDate],'dir')
        mkdir('dataset_evaluation\', TodayDate)
    end
    histogram = []; 
    for k = 1:20
        histogram = [histogram sum(calculation.equiv_diam<k/10 & calculation.equiv_diam>(k-1)/10)];
    end
    strSystemTime = m2xdate(now);
    contamination_hist = [strSystemTime, calculation.contam_level_gram_per_liter, calculation.contam_level_num_per_sample, histogram];
    
    cmap = colormap('gray');
    if isunix
        calculation_noimage = rmfield(calculation,{'raw_image','cropped_raw_image'});
        save(['dataset_evaluation/', TodayDate, '/', filename], 'calculation_noimage');
        imwrite(calculation.raw_image,         cmap, ['dataset_evaluation/', TodayDate, '/', num2str(Flag.Time), '.jpg'], 'jpeg');
        imwrite(calculation.cropped_raw_image * 256, cmap, ['dataset_evaluation/', TodayDate, '/', num2str(Flag.Time), 'C.jpg'], 'jpeg');
        saveScatter = getframe(handles.axes7);
        saveScatter = frame2im(saveScatter);
        imwrite(saveScatter,['dataset_evaluation/', TodayDate, '/', num2str(Flag.Time), 'S.jpg'], 'jpeg');        
        fileID = fopen(['dataset_evaluation/', TodayDate, '/', 'contamination.txt'],'a');
        fprintf(fileID,'%8f %12.8f %8f\r\n', contamination_hist);
        fclose(fileID);
    else
        calculation_noimage = rmfield(calculation,{'raw_image','cropped_raw_image'});
        save(['dataset_evaluation\', TodayDate, '\', filename], 'calculation_noimage');
        % save raw image, cropped image, and image with scatters represnting the particle been counted
        imwrite(calculation.raw_image,         cmap, ['dataset_evaluation\', TodayDate, '\', num2str(Flag.Time), '.jpg'], 'jpeg');
        imwrite(calculation.cropped_raw_image * 256, cmap, ['dataset_evaluation\', TodayDate, '\', num2str(Flag.Time), 'C.jpg'], 'jpeg'); 
        saveScatter = getframe(handles.axes7);
        saveScatter = imresize(frame2im(saveScatter),4);
        imwrite(saveScatter,['dataset_evaluation\', TodayDate, '\', num2str(Flag.Time), 'S.jpg'], 'jpeg');        
        % save to file for each frame with [time, g/L, Total number of particle, histogram with 0.1mm bins]
        fileID = fopen(['dataset_evaluation\', TodayDate, '\', 'contamination.txt'],'a');
        fprintf(fileID,'%8f, %12.4f, %4d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d\r\n', contamination_hist);
        fclose(fileID);
     end        
 %%%%%%%%%%%%%%%%%%%   
    guidata(hObject,handles);
    set(handles.edit4, 'String', i);
    i = i + 1;
end

guidata(hObject,handles);

function [C, x] = plotHist(hObject, eventdata, handles)
global particle_diameter_type
guidata(hObject,handles);
option_percentage = get(handles.checkbox4, 'value');
calculation       = handles.calculation; 
if exist('calculation','var')
    major_axis = calculation.major_axis;
    minor_axis = calculation.minor_axis;
    equiv_diam = calculation.equiv_diam;
    cla(handles.axes10);
    axes(handles.axes10)
    if strcmp(particle_diameter_type, 'equiv_diam')
        [C,x] = hist(equiv_diam);
    elseif strcmp(particle_diameter_type, 'major_axis')
        [C, x] = hist(major_axis);
    elseif strcmp(particle_diameter_type, 'minor_axis')
        [C,x] = hist(minor_axis);
    end
    switch option_percentage
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
    xlabel('Particle Size [mm]', 'Fontsize', 10);
    axes(handles.axes10)
    title('Particle Diameter Distribution / Frame','Fontsize',10);
    legend(particle_diameter_type);
    switch option_percentage
        case 1
            ylabel('Particle Count (percentile %)','Fontsize',10);
        case 0
            ylabel('Particle Count (number #)','Fontsize',10);
    end
    if strcmp(particle_diameter_type, 'equiv_diam')
        legend('equiv diameter');
    elseif strcmp(particle_diameter_type, 'major_axis')
        legend('major axis');
    elseif strcmp(particle_diameter_type, 'minor_axis')
        legend('minor axis');
    end
end

function plotImage(hObject, eventdata, handles)
guidata(hObject,handles)
cropped_raw_image = handles.calculation.cropped_raw_image;
centroid          = handles.calculation.centroid;
num_particles     = sum(handles.calculation.number);

%% compute scale-down ration
ratioScaleDown = 0.25 * 2448 / size(cropped_raw_image, 2);
%% plot - processed image
cla(handles.axes7);
axes(handles.axes7);
imshow(imresize(cropped_raw_image, ratioScaleDown), [], 'Parent', handles.axes7);
for  particle_idx = 1 : num_particles
    hold on
    x_particle = centroid(1, particle_idx) * ratioScaleDown;
    y_particle = centroid(2, particle_idx) * ratioScaleDown;
    scatter(x_particle, y_particle, 20, 'r*', 'Parent', handles.axes7);
end

%% plot - raw_image
cla(handles.axes15);
axes(handles.axes15);
imshow(imresize(cropped_raw_image,ratioScaleDown),[], 'Parent', handles.axes15);

function plotVsTime(hObject, eventdata, handles)
global Flag parameter_over_time
guidata(hObject,handles)
box on
signal = handles.plotVsTime;
if Flag.Time <= 20
    timeMin = 1;
    timeMax = Flag.Time;
else
    timeMin = Flag.Time - 20 + 1;
    timeMax = Flag.Time;
end
if strcmp(get(handles.pushbutton1, 'String'), 'Pause')
    axes(handles.axes1)
    plot(timeMin:timeMax, signal(timeMin:timeMax), 'k', 'linewidth', 1.5);
    xlim([max(Flag.Time, 20) - 19, max(Flag.Time, 20)]);
    if strcmp(parameter_over_time, 'contamination')
        ylabel('Concentration g/L');
    else
        ylabel(parameter_over_time);
    end
    xlabel('Frame [#]');
    hold on
    grid on
end

guidata(hObject,handles)

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Flag particle_diameter_type
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

if isfield(handles,'calculation')
    plotHist(hObject, eventdata, handles);
end

handles.Percentage = val;
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox4

