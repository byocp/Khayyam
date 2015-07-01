function varargout = TakePhotos(varargin)
% TAKEPHOTOS MATLAB code for TakePhotos.fig
%      TAKEPHOTOS, by itself, creates a new TAKEPHOTOS or raises the existing
%      singleton*.
%
%      H = TAKEPHOTOS returns the handle to a new TAKEPHOTOS or the handle to
%      the existing singleton*.
%
%      TAKEPHOTOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TAKEPHOTOS.M with the given input arguments.
%
%      TAKEPHOTOS('Property','Value',...) creates a new TAKEPHOTOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TakePhotos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TakePhotos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TakePhotos

% Last Modified by GUIDE v2.5 29-Jun-2015 11:32:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TakePhotos_OpeningFcn, ...
                   'gui_OutputFcn',  @TakePhotos_OutputFcn, ...
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


% --- Executes just before TakePhotos is made visible.
function TakePhotos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TakePhotos (see VARARGIN)

addpath('Lumenera Matlab Driver V2.0.1 NEW 64 Bit')

% Choose default command line output for TakePhotos
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TakePhotos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TakePhotos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in tglStartStop.
function tglStartStop_Callback(hObject, eventdata, handles)
% hObject    handle to tglStartStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tglStartStop
i = 1;

camConnect = LucamCameraOpen(1);
if camConnect ~= -1
    % Adjust level of gain
    LucamSetGain(1, 1);
    % Set exposure
    LucamSetSnapshotExposure(0.1, 1);
    % Set Gamma
    LucamSetGamma(1, 1);
end

while get(hObject,'Value')
    disp(2)
    pause(.01);
    handles.(['imgRaw' int2str(i)]) = LucamTakeSnapshot(1);
    handles.(['Time' int2str(i)]) = clock;
    i = i+1;
end
% Close camera.
LucamCameraClose(1);
save('Saved Data\handles.mat','handles');