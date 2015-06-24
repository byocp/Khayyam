function varargout = Config(varargin)
    % CONFIG MATLAB code for Config.fig
    %      CONFIG, by itself, creates a new CONFIG or raises the existing
    %      singleton*.
    %
    %      H = CONFIG returns the handle to a new CONFIG or the handle to
    %      the existing singleton*.
    %
    %      CONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in CONFIG.M with the given input arguments.
    %
    %      CONFIG('Property','Value',...) creates a new CONFIG or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before Config_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to Config_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help Config

    % Last Modified by GUIDE v2.5 24-Jun-2015 02:48:42

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @Config_OpeningFcn, ...
                       'gui_OutputFcn',  @Config_OutputFcn, ...
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


% --- Executes just before Config is made visible.
function Config_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to Config (see VARARGIN)
    
    % Choose default command line output for Config
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes Config wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end


% --- Outputs from this function are returned to the command line.
function varargout = Config_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end


% --- Executes on mouse press over axes background.
function axeSampleImg_ButtonDownFcn(hObject, ~, ~)
    handles = guidata(hObject);
    
    strSource = get(get(handles.pnlSource,'SelectedObject'),'Tag');
    
    dblExposure = get(handles.txtExposure,'Value');
    dblGain = get(handles.txtGain,'Value');
    dblGamma = get(handles.txtGamma,'Value');
    
    switch strSource
        case 'radCamera'
            handles.imgRaw = automated_frame_capture(dblExposure, dblGain, dblGamma);
        case 'radFromFile'
            [strFileName, strPath] = uigetfile({'*.jpg','JPEG Files'},...
                                                    'Select First and Last File',...
                                                    'MultiSelect','on');
            if ~strFileName
                errordlg('No file selected')
                return;
            end
            
            handles.imgRaw = imread([strPath strFileName]);
    end
    
    axes(handles.axeSampleImg);
    cla;
    imshow(handles.imgRaw);
    set(get(handles.axeSampleImg,'Children'),'ButtonDownFcn',@axeSampleImg_ButtonDownFcn);
    scatter
    
    guidata(handles.axeSampleImg, handles);
end
