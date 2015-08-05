%% Default MATLAB CODE
function varargout = LoadProject(varargin)
    % LOADPROJECT MATLAB code for LoadProject.fig
    %      LOADPROJECT, by itself, creates a new LOADPROJECT or raises the existing
    %      singleton*.
    %
    %      H = LOADPROJECT returns the handle to a new LOADPROJECT or the handle to
    %      the existing singleton*.
    %
    %      LOADPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in LOADPROJECT.M with the given input arguments.
    %
    %      LOADPROJECT('Property','Value',...) creates a new LOADPROJECT or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before LoadProject_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to LoadProject_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help LoadProject

    % Last Modified by GUIDE v2.5 05-Aug-2015 13:47:12

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @LoadProject_OpeningFcn, ...
                       'gui_OutputFcn',  @LoadProject_OutputFcn, ...
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
end
% End initialization code - DO NOT EDIT

% --- Executes just before LoadProject is made visible.
function LoadProject_OpeningFcn(hObject, ~, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to LoadProject (see VARARGIN)

    clc;
    handles = Initialize(handles);
    
    % Choose default command line output for LoadProject
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes LoadProject wait for user response (see UIRESUME)
    % uiwait(handles.LoadProject);
end

% --- Outputs from this function are returned to the command line.
function varargout = LoadProject_OutputFcn(~, ~, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end

% --- Executes when user attempts to close LoadProject.
function LoadProject_CloseRequestFcn(hObject, ~, ~)
    % hObject    handle to LoadProject (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: delete(hObject) closes the figure
    delete(hObject);
end

%% CALLBACKS
% --- Executes on button press in btnLoad.
function btnLoad_Callback(~, ~, handles) %#ok<DEFNU>
    try
        stcLoad = load(handles.celProjList{get(handles.cboxProject,'Value'),2});
    catch ERR
        errordlg(ERR.message);
        return;
    end
    
    VisionSensor(stcLoad);
    LoadProject_CloseRequestFcn(handles.LoadProject);
end

% --- Executes on button press in btnOpen.
function btnOpen_Callback(hObject, ~, handles) %#ok<DEFNU>
    [strFileName, strPath] = uigetfile({'*.mat','MATLAB mat file'},...
                                        'Select Project Save File');
    if ~strFileName
        errordlg('No file selected','','modal')
        return;
    end
    
    handles.celProjList{end+1,1} = strFileName(1:end-4);
    handles.celProjList{end,2} = [strPath strFileName];
    
    set(handles.cboxProject,'String',handles.celProjList(:,1));
    set(handles.btnLoad,'Enable','on');
    
    guidata(hObject,handles);
end

% --- Executes on button press in btnNew.
function btnNew_Callback(~, ~, handles) %#ok<DEFNU>
    VisionSensor;
    LoadProject_CloseRequestFcn(handles.LoadProject);
end

%% Custom Functions
% --- Executes during object creation, after setting all properties.
function handles = Initialize(handles)
    if isdir('Saved Projects')
        stcProjList = dir('Saved Projects');
        
        handles.celProjList = {};
        for i = 3:length(stcProjList)
            if ~stcProjList(i).isdir && strcmp(stcProjList(i).name(end-2:end),'mat')
                handles.celProjList{end+1,1} = stcProjList(i).name(1:end-4);
                handles.celProjList{end,2} = ['Saved Projects\' stcProjList(i).name];
            end
        end
        if isempty(handles.celProjList)
            handles.celProjList{1} = ' ';
        else
            set(handles.btnLoad,'Enable','on');
        end
        
        set(handles.cboxProject,'String',handles.celProjList(:,1));
    end
    
    imgLogo = imread('Supporting Functions\kep_logo.png');
    axis(handles.axeLogo);
    imshow(imgLogo);
end
