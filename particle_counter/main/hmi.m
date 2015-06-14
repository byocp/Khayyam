%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script is made by Kepstrum Inc. Canada
% All rights reserved
% Author: Pedram Ataee
% Date: ??
% Vers: 1.0
% 
% Last edited by: Biye Chen
% Last edited date: Jun. 14, 2015
%
% Description:
% MATLAB based HMI for the vision sensor, temporary standalone solution
% for calibration until a C# integrated solution is made.
% 
% Ongoing Issues:
%   1. Use of global variables
%       - Configure code structure to avoid using global variables, handles
%       object should be used to communicate different variables within an
%       HMI instance
%   2. plotHist & plotImage
%       - Used to see historical data on the images and histogram plots,
%       currently unused and references to non-existing folder paths
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

% Last Modified by GUIDE v2.5 14-Jun-2015 16:09:08

% Begin initialization code - DO NOT EDIT

    % MATLAB generated default code, DO NOT EDIT unless you know what
    % you're doing
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
        
        % Custom edit, adding Lumenera MATLAB functions as part of the path
        addpath('Lumenera Matlab Driver V2.0.1 NEW 64 Bit')
    end
% End initialization code - DO NOT EDIT
end


% --- Executes just before hmi is made visible.
function hmi_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hmi (see VARARGIN)

% Choose default command line output for hmi
    handles.output = hObject;

    cla(handles.axeGramPerLitre)

    % Sets all object background colors to white (Biye: Aesthetics...I
    % guess)
    bgcolor = [1 1 1];
    set(hObject, 'Color', bgcolor);
    set(findobj(hObject,'-property', 'BackgroundColor'), 'BackgroundColor', bgcolor);

	% Set Kepstrum Logo
    axes(handles.axeLogo);
    A=imread('logo.jpg');
    B=imrotate(A,90);
    imshow(B,[]);
    clear A B

    % Update handles structure
    guidata(hObject, handles);
end


% --- Outputs from this function are returned to the command line.
function varargout = hmi_OutputFcn(hObject, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

guidata(hObject,handles);
varargout{1} = handles.output;
end

% --- Executes on slider movement.
function sldrGramPerLitre_Callback(hObject, eventdata, handles) %#ok<DEFNU>
% hObject    handle to sldrGramPerLitre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Biye: Fix this during run to see what it's trying to do
sliderTemp = 0;
global Flag
if isfield(Flag, 'Time')
    while get(handles.btnStart,'Value') == 0 && sliderTemp == 0
        slider1value = ceil(get(handles.sldrGramPerLitre,'Value'));
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
    set(handles.tbxTime,'String', slider1value);
end
guidata(hObject,handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
end

% --- Executes on button press in btnRenew.
function btnRenew_Callback(hObject, eventdata, handles)
% hObject    handle to btnRenew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
clear all
clc
runtime
end


% --- Executes when uipanel7 is resized.
function uipanel7_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear all
end

% --------------------------------------------------------------------
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
Kepstrum
end

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
end

% --- Executes on button press in btnStart.
function btnStart_Callback(hObject, eventdata, handles)
% hObject    handle to btnStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Flag input_image_type particle_diameter_type parameter_over_time

i = 1;
if strcmp(get(handles.btnStart, 'String'), 'Pause')
    set(handles.btnStart, 'String', 'Start');
    Flag.Start = 0;
    runtime
elseif strcmp(get(handles.btnStart, 'String'), 'Start')
    cla(handles.axeGramPerLitre);
    set(handles.btnStart,'String','Pause');
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
    
%    strSystemTime = floor(clock);
    strSystemTime = now;
%    strSystemTime = [int2str(strSystemTime(4)) ':' int2str(strSystemTime(5)) ':' int2str(strSystemTime(6))];
%     contamination_hist(:,Flag.Time) = [Flag.Time; calculation.contam_level_gram_per_liter];
    contamination_hist(:,Flag.Time) = [strSystemTime; calculation.contam_level_gram_per_liter];
    
    cmap = colormap('gray');
    if isunix
%         save(['dataset_evaluation/', TodayDate, '/', filename], 'calculation', 'raw_image', 'cropped_raw_image');
        calculation_noimage = rmfield(calculation,{'raw_image','cropped_raw_image'});
        save(['dataset_evaluation/', TodayDate, '/', filename], 'calculation_noimage');
        imwrite(calculation.raw_image,         cmap, ['dataset_evaluation/', TodayDate, '/', num2str(Flag.Time), '.jpg'], 'jpeg');
        imwrite(calculation.cropped_raw_image * 256, cmap, ['dataset_evaluation/', TodayDate, '/', num2str(Flag.Time), 'C.jpg'], 'jpeg');
        fileID = fopen(['dataset_evaluation/', TodayDate, '/', 'contamination.txt'],'w');
        fprintf(fileID,'%8f %12.8f\r\n', contamination_hist);
        fclose(fileID);
    else
%         save(['dataset_evaluation\', TodayDate, '\', filename], 'calculation', 'raw_image', 'cropped_raw_image');
        calculation_noimage = rmfield(calculation,{'raw_image','cropped_raw_image'});
        save(['dataset_evaluation\', TodayDate, '\', filename], 'calculation_noimage');
        imwrite(calculation.raw_image,         cmap, ['dataset_evaluation\', TodayDate, '\', num2str(Flag.Time), '.jpg'], 'jpeg');
        imwrite(calculation.cropped_raw_image * 256, cmap, ['dataset_evaluation\', TodayDate, '\', num2str(Flag.Time), 'C.jpg'], 'jpeg');
        fileID = fopen(['dataset_evaluation\', TodayDate, '\', 'contamination.txt'],'w');
%         fprintf(fileID,'%6.2f %12.8f\r\n', contamination_hist);
        fprintf(fileID,'%8f %12.8f\r\n', contamination_hist);
        fclose(fileID);
    end


    guidata(hObject,handles);
    set(handles.tbxTime, 'Value', int2str(i));
    i = i + 1;
end

guidata(hObject,handles);
end

function [C, x] = plotHist(hObject, eventdata, handles)
global particle_diameter_type
guidata(hObject,handles);
option_percentage = get(handles.checkbox4, 'value');
calculation       = handles.calculation; 
if exist('calculation','var')
    major_axis = calculation.major_axis;
    minor_axis = calculation.minor_axis;
    equiv_diam = calculation.equiv_diam;
    cla(handles.axeHistogram);
    axes(handles.axeHistogram)
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
    axes(handles.axeHistogram)
    bar(x, Cnew);
    axis tight
    hold on
    plot(x, Cnew, 'r', 'Marker', 'o', 'Linewidth', 2)
    grid on
    xlabel('Particle Size [mm]', 'Fontsize', 10);
    axes(handles.axeHistogram)
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
end

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
if strcmp(get(handles.btnStart, 'String'), 'Pause')
    axes(handles.axeGramPerLitre)
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
end

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Flag particle_diameter_type
guidata(hObject,handles);
val = get(handles.checkbox4,'value');

if strcmp(get(handles.btnStart, 'String'), 'Start') && ~(get(handles.sldrGramPerLitre,'Value') == 0)
    slider1value = get(handles.sldrGramPerLitre,'Value');
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
end



% --- Executes when user attempts to close figVisionHMI.
function figVisionHMI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figVisionHMI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
end
