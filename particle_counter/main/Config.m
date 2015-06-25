%% GUI Functions
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

    % Last Modified by GUIDE v2.5 25-Jun-2015 11:51:44

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
function Config_OpeningFcn(hObject, ~, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to Config (see VARARGIN)
    
    clc
    handles = Initialize(handles);
    addpath('Lumenera Matlab Driver V2.0.1 NEW 64 Bit')
    
    % Choose default command line output for Config
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes Config wait for user response (see UIRESUME)
    uiwait(handles.hmiConfig);
end

% --- Outputs from this function are returned to the command line.
function varargout = Config_OutputFcn(hObject, ~, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    if get(handles.cbCrop,'Value')
        varargout{1} = handles.ParamC;
    else
        varargout{1} = handles.Param;
    end
        
    delete(hObject);
    clc
end

% --- Executes when user attempts to close hmiConfig.
function hmiConfig_CloseRequestFcn(~, ~, ~)
    uiresume;
end

% Executes on mouse click on axis or its plots
function axeSampleImg_ButtonDownFcn(hObject, ~, ~)
    % Gets the handles object, done this way due to function mapping on
    % children plots (see below)
    handles = guidata(hObject);
    
    % Get tag of selected radial button
    strSource = get(get(handles.pnlSource,'SelectedObject'),'Tag');
    
    switch strSource
        case 'radCamera'
            % Get image capture parameters
            dblExposure = getBoxVal(handles.txtExposure);
            dblGain = getBoxVal(handles.txtGain);
            dblGamma = getBoxVal(handles.txtGamma);
            
            handles.imgRaw = automated_frame_capture(dblExposure, dblGain, dblGamma);
            
            if handles.imgRaw == -1
                errordlg('Error while retrieving picture from camera')
                return;
            end
        case 'radFromFile'
            [strFileName, strPath] = uigetfile({'*.jpg','JPEG Files'},...
                                                    'Select Image File');
            if ~strFileName
                errordlg('No file selected')
                return;
            end
            
            handles.imgRaw = imread([strPath strFileName]);
    end
    
    % Set image to grayscale
    if size(handles.imgRaw,3) == 3
        handles.imgRaw = rgb2gray(handles.imgRaw);
    end
    handles.imgRaw = double(handles.imgRaw);
    handles.imgRaw = handles.imgRaw ./ max(handles.imgRaw(:));
    
    handles = plotSample(handles.imgRaw, handles);
    
    set(handles.cbCrop,'Enable','on');
    
    % Update handles structure
    guidata(handles.axeSampleImg, handles);
end

% Executes when Enter is pressed
function txtCenterX_KeyPressFcn(hObject, eventdata, handles) %#ok<DEFNU>
    if strcmp(eventdata.Key,'return') & ishandle(get(handles.axeSampleImg,'Children')) %#ok<AND2>
        set(handles.hScatter,'XData',getBoxVal(hObject));
        posText = get(handles.hText,'Position');
        posText(1) = str2double(get(hObject,'String'));
        set(handles.hText,'Position',posText);
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter is pressed
function txtCenterY_KeyPressFcn(hObject, eventdata, handles) %#ok<DEFNU>
    if strcmp(eventdata.Key,'return') & ishandle(get(handles.axeSampleImg,'Children')) %#ok<AND2>
        set(handles.hScatter,'YData',getBoxVal(hObject));
        posText = get(handles.hText,'Position');
        posText(2) = str2double(get(hObject,'String')) - size(handles.imgRaw,1)/20;
        set(handles.hText,'Position',posText);
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter is pressed
function txtGain_KeyPressFcn(hObject, eventdata, handles) %#ok<DEFNU>
    if strcmp(eventdata.Key,'return')
        set(handles.sldGain,'Value',getBoxVal(hObject));
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter is pressed
function txtGamma_KeyPressFcn(hObject, eventdata, handles) %#ok<DEFNU>
    if strcmp(eventdata.Key,'return')
        set(handles.sldGamma,'Value',getBoxVal(hObject));
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter is pressed
function txtThreshold_KeyPressFcn(hObject, eventdata, handles) %#ok<DEFNU>
    if strcmp(eventdata.Key,'return')
        set(handles.sldThreshold,'Value',getBoxVal(hObject));
        
        if ishandle(get(handles.axeSampleImg,'Children'))
            cbCrop_Callback(handles.cbCrop,[],handles);
        end
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes on slider movement.
function sldGain_Callback(hObject, ~, handles) %#ok<DEFNU>
    set(handles.txtGain,'String',get(hObject,'Value'));
    
    % Update handles structure
    [~,handles] = getBoxVal(handles.txtGain,handles,handles);
    guidata(hObject, handles);
end

% Executes on slider movement.
function sldGamma_Callback(hObject, ~, handles) %#ok<DEFNU>
    set(handles.txtGamma,'String',get(hObject,'Value'));
    
    % Update handles structure
    [~,handles] = getBoxVal(handles.txtGamma,handles);
    guidata(hObject, handles);
end

% Executes on slider movement.
function sldThreshold_Callback(hObject, ~, handles) %#ok<DEFNU>
    set(handles.txtThreshold,'String',get(hObject,'Value'));
    
    if ishandle(get(handles.axeSampleImg,'Children'))
        cbCrop_Callback(handles.cbCrop,[],handles);
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(handles.txtThreshold,handles);
    guidata(hObject, handles);
end

% Executes when Enter is pressed
function txtCropWidth_KeyPressFcn(hObject, eventdata, handles) %#ok<DEFNU>
    if strcmp(eventdata.Key,'return')
        cbCrop_Callback(handles.cbCrop, [], handles)
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter is pressed
function txtCropHeight_KeyPressFcn(hObject, eventdata, handles) %#ok<DEFNU>
    if strcmp(eventdata.Key,'return')
        cbCrop_Callback(handles.cbCrop, [], handles)
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter is pressed
function txtFrameDepth_KeyPressFcn(hObject, eventdata, handles) %#ok<DEFNU>
    if strcmp(eventdata.Key,'return')
        intFrameVol = getBoxVal(handles.txtFrameWidth) * ...
                      getBoxVal(handles.txtFrameHeight) * ...
                      getBoxVal(hObject);
        set(handles.txtFrameVol,'String',intFrameVol);
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    [~,handles] = getBoxVal(handles.txtFrameVol,handles);
    guidata(hObject, handles);
end

% Executes when Enter is pressed
function txtPixelLen_KeyPressFcn(hObject, eventdata, handles) %#ok<DEFNU>
    if strcmp(eventdata.Key,'return')
        intPixelLenOld = handles.Param.txtPixelLen;
        intPixelLenNew = getBoxVal(hObject);
        set(handles.txtFrameWidth,'String',getBoxVal(handles.FrameWidth) / ...
                                           intPixelLenOld * intPixelLenNew);
        set(handles.txtFrameHeight,'String',getBoxVal(handles.FrameHeight) / ...
                                            intPixelLenOld * intPixelLenNew);
        set(handles.txtFrameVol,'String',getBoxVal(handles.FrameWidth) * ...
                                         getBoxVal(handles.FrameHeight) * ...
                                         getBoxVal(handles.FrameDepth));
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    [~,handles] = getBoxVal(handles.txtFrameWidth,handles);
    [~,handles] = getBoxVal(handles.txtFrameHeight,handles);
    [~,handles] = getBoxVal(handles.txtFrameVol,handles);
    guidata(hObject, handles);
end

% Executes on click
function cbCrop_Callback(hObject, ~, handles)
    if get(hObject,'Value')
        % Enable crop textboxes
        set(handles.txtCropWidth,'Enable','on')
        set(handles.txtCropHeight,'Enable','on')

        % Set crop rectangle
        intWidth = floor(getBoxVal(handles.txtCropWidth)/getBoxVal(handles.txtPixelLen));
        intHeight = floor(getBoxVal(handles.txtCropHeight)/getBoxVal(handles.txtPixelLen));
        intLowerX = handles.Param.txtCenterX - floor(intWidth/2);
        intLowerY = handles.Param.txtCenterY - floor(intHeight/2);

        intCropWindow = [intLowerX, intLowerY, intWidth, intHeight];

        % Crop raw image
        handles.imgRawCropped = imcrop(handles.imgRaw,intCropWindow);

        % Update center point
        set(handles.txtCenterX,'String',floor(intWidth/2));
        set(handles.txtCenterY,'String',floor(intHeight/2));
        
        [~,handles] = getBoxVal(handles.txtCenterX,handles);
        [~,handles] = getBoxVal(handles.txtCenterY,handles);

        % Update capture frame
        set(handles.txtFrameWidth,'String',getBoxVal(handles.txtCropWidth))
        set(handles.txtFrameHeight,'String',getBoxVal(handles.txtCropHeight))
        set(handles.txtFrameVol,'String',getBoxVal(handles.txtCropWidth) * ...
                                         getBoxVal(handles.txtCropHeight) * ...
                                         getBoxVal(handles.txtFrameDepth))
        
        [~,handles] = getBoxVal(handles.txtFrameWidth,handles);
        [~,handles] = getBoxVal(handles.txtFrameHeight,handles);
        [~,handles] = getBoxVal(handles.txtFrameVol,handles);

        % Plot cropped image
        handles = plotSample(handles.imgRawCropped, handles);
    else
        set(handles.txtCropWidth,'Enable','off')
        set(handles.txtCropHeight,'Enable','off')

        % Update center point
        set(handles.txtCenterX,'String',handles.Param.txtCenterX)
        set(handles.txtCenterY,'String',handles.Param.txtCenterY)

        % Update capture frame
        set(handles.txtFrameWidth,'String',handles.Param.txtFrameWidth)
        set(handles.txtFrameHeight,'String',handles.Param.txtFrameHeight)
        set(handles.txtFrameVol,'String',handles.Param.txtFrameVol)

        % Plot cropped image
        handles = plotSample(handles.imgRaw, handles);
    end
    
    % Update handles structure
    guidata(hObject, handles);
end

% Executes when selected object is changed in pnlSource.
function pnlSource_SelectionChangeFcn(hObject, eventdata, handles) %#ok<DEFNU>
    switch get(eventdata.NewValue, 'Tag')
        case 'radCamera'
            set(handles.txtGain,'Enable','on')
            set(handles.txtGamma,'Enable','on')
            set(handles.txtExposure,'Enable','on')
            set(handles.sldGain,'Enable','on')
            set(handles.sldGamma,'Enable','on')
        case 'radFromFile'
            set(handles.txtGain,'Enable','off')
            set(handles.txtGamma,'Enable','off')
            set(handles.txtExposure,'Enable','off')
            set(handles.sldGain,'Enable','off')
            set(handles.sldGamma,'Enable','off')
    end
    
    % Update handles structure
    guidata(hObject, handles);
end

% Executes on button press in btnConfig.
function btnConfig_Callback(~, ~, ~) %#ok<DEFNU>
    hmiConfig_CloseRequestFcn;
end

%% Custom Functions

% Initialization
function handles = Initialize(handles)
    hList = findobj('Style','edit');
    
    for i = 1:length(hList)
        handles.Param.(get(hList(i),'Tag')) = getBoxVal(hList(i));
        handles.ParamC.(get(hList(i),'Tag')) = getBoxVal(hList(i));
    end
    
    handles.Param.cbCrop = 0;
    handles.ParamC.cbCrop = 1;
    
    % Update handles structure
    guidata(handles.hmiConfig, handles);
end

% Get double value from textboxes
function varargout = getBoxVal(varargin)
    hObject = varargin{1};
    if nargin == 2
        handles = varargin{2};
    else
        handles = guidata(hObject);
    end
    
    varargout{1} = str2double(get(hObject,'String'));
    
    switch get(handles.cbCrop,'Value')
        case 1
            handles.ParamC.(get(hObject,'Tag')) = varargout{1};
        case 0
            handles.Param.(get(hObject,'Tag')) = varargout{1};
    end
    varargout{2} = handles;
end

% Plots the sample image and the center point
function handles = plotSample(imgSample, handles)
    axes(handles.axeSampleImg);
    cla;
    hold on;
    
    % Create size of small/big particle in pixels
    imgMinParticle = fspecial('disk',getBoxVal(handles.txtMinDiam) / ...
                                     getBoxVal(handles.txtPixelLen)/2);
    imgMinParticle(imgMinParticle>0) = 1;
    imgMaxParticle = fspecial('disk',getBoxVal(handles.txtMaxDiam) / ...
                                     getBoxVal(handles.txtPixelLen)/2);
    imgMaxParticle(imgMaxParticle>0) = 1;
    
    % Image Processing
    imgSample = ProcessImage(imgSample,'bw',getBoxVal(handles.txtThreshold));
%     imgSample = ProcessImage(imgSample,'remSmallObj',sum(imgMinParticle(:)));

    % Add size of small and big particle to image
    sizMin = size(imgMinParticle);
    yOffset1 = floor(size(imgSample,1)/20);
    imgSample(yOffset1:sizMin(1)+yOffset1-1, 1:sizMin(2)) = ~imgMinParticle;

    sizMax = size(imgMaxParticle);
    yOffset2 = yOffset1 + sizMin(1) + floor(size(imgSample,1)/20);
    imgSample(yOffset2:sizMax(1)+yOffset2-1, 1:sizMax(2)) = ~imgMaxParticle;

    imshow(imgSample);
    
    text(sizMin(2)+10,sizMin(1)/2+yOffset1, ...
         'Min Particle Size', ...
         'Color',[1 0 0]);
    text(sizMax(2)+10,sizMax(1)/2+yOffset2, ...
         'Max Particle Size', ...
         'Color',[1 0 0]);
    
    intCenterX = getBoxVal(handles.txtCenterX);
    intCenterY = getBoxVal(handles.txtCenterY);
    handles.hScatter = scatter(intCenterX,intCenterY,'*r');
    intTextY = intCenterY - size(imgSample,1)/20;
    handles.hText = text(intCenterX,intTextY,'Frame Center',...
                         'HorizontalAlignment','center',...
                         'Color',[1 0 0]);
    
    % Set function handle of this function to plots (children)
    set(get(handles.axeSampleImg,'Children'),'ButtonDownFcn',@axeSampleImg_ButtonDownFcn);
end

function imgProcessed = ProcessImage(imgRaw, strProcess, varargin)
    switch strProcess
        case 'bw'
            imgProcessed = im2bw(imgRaw,varargin{1});
        case 'remSmallObj'
            imgProcessed = ~(bwareaopen(~imgRaw, varargin{1}));
        otherwise    
    end
end
%% Work in progress
