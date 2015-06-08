function varargout = Kepstrum(varargin)
% Kepstrum MATLAB code for Kepstrum.fig
%      Kepstrum, by itself, creates a new Kepstrum or raises the existing
%      singleton*.
%
%      H = Kepstrum returns the handle to a new Kepstrum or the handle to
%      the existing singleton*.
%
%      Kepstrum('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Kepstrum.M with the given input arguments.
%
%      Kepstrum('Property','Value',...) creates a new Kepstrum or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Kepstrum_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Kepstrum_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Kepstrum

% Last Modified by GUIDE v2.5 23-May-2014 02:16:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Kepstrum_OpeningFcn, ...
    'gui_OutputFcn',  @Kepstrum_OutputFcn, ...
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


% --- Executes just before Kepstrum is made visible.
function Kepstrum_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Kepstrum (see VARARGIN)
axes(handles.axes1);
A=imread('logo.jpg');
imagesc(A);
set(gca, 'XTick', [], 'YTick', []);

% Choose default command line output for Kepstrum
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Kepstrum wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Kepstrum_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
set(handles.output, 'HandleVisibility', 'off');
close all;
set(handles.output, 'HandleVisibility', 'on');

[file_name, file_path]=uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },'Kepstrum',...
    '\\nasserver\Public\0- Projects\PreDevelopment\Biye\Vision Sensor\Data\08-Jun-2015');
%     '..\Samples');
if file_name==0
    close all
    clear all
    Kepstrum
else
    output = importdata(strcat(file_path, file_name));
    file_name = file_name(1 : end-4);
    matlab_config_path = '../../conf.txt';
    config = load_config(matlab_config_path);
    output = image_initialization(output, config);
    cropped_raw_image = output.cropped_raw_image;
    config            = output.config;
    particle_counter({cropped_raw_image, config, file_path, file_name});
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hmi
