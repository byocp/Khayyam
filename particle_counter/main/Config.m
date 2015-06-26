%% Notes
% Add output file?

%% Main GUI Functions
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

    % Last Modified by GUIDE v2.5 26-Jun-2015 08:27:46

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

    try
        if nargout
            [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
        else
            gui_mainfcn(gui_State, varargin{:});
        end
    catch ERROR
        if ~isdir('ErrorLog')
            mkdir('ErrorLog')
        end
        logError = fopen('ErrorLog\ERROR.txt','a');

        strErrorTime = datestr(now);
        fprintf(logError,['%-' int2str(length(strErrorTime)) 's\r\n'...
                          '%-' int2str(length(ERROR.message)) 's\r\n'...
                          ],strErrorTime,ERROR.message);
        strErrorTime = regexprep(strErrorTime,':','');
        stcMemory = memory; %#ok<NASGU>
        save(['ErrorLog\ ' strErrorTime '.mat'],'ERROR','stcMemory');

        fclose(logError);
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
    % uiwait(handles.hmiConfig);
end

% --- Outputs from this function are returned to the command line.
function varargout = Config_OutputFcn(hObject, ~, handles)  %#ok<INUSL>
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
        
%     delete(hObject);
%     clc
end

% --- Executes when user attempts to close hmiConfig.
function hmiConfig_CloseRequestFcn(hObject, ~, ~) %#ok<DEFNU>
    delete(hObject);
    % uiresume;
end

%% Image Settings (Textboxes)
% Executes when Enter or Tab is pressed
function txtCenterX_Callback(hObject, ~, handles) %#ok<DEFNU>
    if ishandle(get(handles.axeSampleImg,'Children'))
        set(handles.hScatter,'XData',getBoxVal(hObject));
        posText = get(handles.hText,'Position');
        posText(1) = str2double(get(hObject,'String'));
        set(handles.hText,'Position',posText);
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtCenterY_Callback(hObject, ~, handles) %#ok<DEFNU>
    if ishandle(get(handles.axeSampleImg,'Children'))
        set(handles.hScatter,'YData',getBoxVal(hObject));
        posText = get(handles.hText,'Position');
        posText(2) = str2double(get(hObject,'String')) - size(handles.imgRaw,1)/20;
        set(handles.hText,'Position',posText);
    end
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtGain_Callback(hObject, ~, handles) %#ok<DEFNU>
    set(handles.sldGain,'Value',getBoxVal(hObject));
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtGamma_Callback(hObject, ~, handles) %#ok<DEFNU>
    set(handles.sldGamma,'Value',getBoxVal(hObject));
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtThreshold_Callback(hObject, ~, handles) %#ok<DEFNU>
    set(handles.sldThreshold,'Value',getBoxVal(hObject));

    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtCropWidth_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop, [], handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtCropHeight_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop, [], handles);
    guidata(hObject, handles);
end

%% Image Settings (Sliders)
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
    
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    
    % Update handles structure
    [~,handles] = getBoxVal(handles.txtThreshold,handles);
    guidata(hObject, handles);
end

%% Image Settings (Other)
% Executes on mouse click on axis or its plots
function axeSampleImg_ButtonDownFcn(hObject, ~, ~)
    % Gets the handles object, done this way due to function mapping on
    % children plots (see below)
    handles = guidata(hObject);
    
    % Get tag of selected radial button
    strSource = get(get(handles.pnlSource,'SelectedObject'),'Tag');
    
    if isfield(handles,'imgRaw')
        handles.imgCompare = handles.imgRaw;
        set(handles.cbFilterStatic,'Enable','on');
    end
    
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
    handles.imgRaw = handles.imgRaw ./ 255;
    
    handles = plotSample(handles.imgRaw, handles, 'axeSampleImg');
    
    set(handles.cbCrop,'Enable','on');
    
    % Update handles structure
    handles = cbCrop_Callback(handles.cbCrop, [], handles);
    guidata(handles.axeSampleImg, handles);
end

% Executes on click
function handles = cbCrop_Callback(hObject, ~, handles)
    if ishandle(get(handles.axeSampleImg,'Children'))  % Needs to be fixed?
        if get(hObject,'Value')
            % Enable crop textboxes
            set(handles.txtCropWidth,'Enable','on')
            set(handles.txtCropHeight,'Enable','on')

            % Set crop rectangle
            intWidth = floor(getBoxVal(handles.txtCropWidth)/getBoxVal(handles.txtPixelLen));
            intHeight = floor(getBoxVal(handles.txtCropHeight)/getBoxVal(handles.txtPixelLen));
            intLowerX = max(handles.Param.txtCenterX - floor(intWidth/2),0);
            intLowerY = max(handles.Param.txtCenterY - floor(intHeight/2),0);

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
            if get(handles.tglStartPause,'Value')
                handles = plotSample(handles.imgRawCropped, handles, 'axeRaw');
            else
                handles = plotSample(handles.imgRawCropped, handles, 'axeSampleImg');
            end
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
            if get(handles.tglStartPause,'Value')
                handles = plotSample(handles.imgRaw, handles, 'axeRaw');
            else
                handles = plotSample(handles.imgRaw, handles, 'axeSampleImg');
            end
        end
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

%% Calculation Parameters
% Executes when Enter or Tab is pressed
function txtFrameDepth_Callback(hObject, ~, handles) %#ok<DEFNU>
    intFrameVol = getBoxVal(handles.txtFrameWidth) * ...
                  getBoxVal(handles.txtFrameHeight) * ...
                  getBoxVal(hObject);
    set(handles.txtFrameVol,'String',intFrameVol);
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    [~,handles] = getBoxVal(handles.txtFrameVol,handles);
    guidata(hObject, handles);
end

%% Other Settings
% Executes when Enter or Tab is pressed
function txtPixelLen_Callback(hObject, ~, handles) %#ok<DEFNU>
    intPixelLenOld = handles.Param.txtPixelLen;
    intPixelLenNew = getBoxVal(hObject);
    set(handles.txtFrameWidth,'String',(getBoxVal(handles.txtFrameWidth) / ...
                                       intPixelLenOld * intPixelLenNew));
    set(handles.txtFrameHeight,'String',getBoxVal(handles.txtFrameHeight) / ...
                                        intPixelLenOld * intPixelLenNew);
    set(handles.txtFrameVol,'String',getBoxVal(handles.txtFrameWidth) * ...
                                     getBoxVal(handles.txtFrameHeight) * ...
                                     getBoxVal(handles.txtFrameDepth));
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    [~,handles] = getBoxVal(handles.txtFrameWidth,handles);
    [~,handles] = getBoxVal(handles.txtFrameHeight,handles);
    [~,handles] = getBoxVal(handles.txtFrameVol,handles);
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject, handles);
end

%% Image Processing Options
% Executes on click
function cbOutOfRange_Callback(hObject, ~, handles) %#ok<DEFNU>
    handles = UpdateCBValues(handles, 'cbOutOfRange', get(hObject,'Value'));
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject,handles);
end

% Executes on click
function cbBinary_Callback(hObject, ~, handles) %#ok<DEFNU>
    hList = findobj('Parent',handles.pnlImgProc,'Style','checkbox');
    
    if get(hObject,'Value')
        for i = 1:length(hList)
            if ~strcmp(get(hList(i),'Tag'),{'cbBinary';'cbFilterStatic'})
                set(hList(i),'Enable','on','Value',handles.imgProcCB.(get(hList(i),'Tag')))
            end
        end
    else
        for i = 1:length(hList)
            if ~strcmp(get(hList(i),'Tag'),{'cbNormalize';'cbBinary';'cbFilterStatic'})
                handles.imgProcCB.(get(hList(i),'Tag')) = get(hList(i),'Value');
                set(hList(i),'Enable','off','Value',0)
            end
        end
    end
    
    handles = UpdateCBValues(handles, 'cbBinary', get(hObject,'Value'));
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject,handles);
end

% Executes on click
function cbRemoveBorder_Callback(hObject, ~, handles) %#ok<DEFNU>
    handles = UpdateCBValues(handles, 'cbRemoveBorder', get(hObject,'Value'));
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject,handles);
end

% Executes on click
function cbRoundness_Callback(hObject, ~, handles) %#ok<DEFNU>
    if get(hObject,'Value')
        set(handles.txtRoundLow,'Enable','on')
        set(handles.txtRoundHigh,'Enable','on')
    else
        set(handles.txtRoundLow,'Enable','off')
        set(handles.txtRoundHigh,'Enable','off')
    end
    
    handles = UpdateCBValues(handles, 'cbRoundness', get(hObject,'Value'));
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject,handles);
end

% Executes when Enter or Tab is pressed
function txtRoundHigh_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtRoundLow_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtMinDiam_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtMaxDiam_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject, handles);
end

% Executes on click
function cbFilterStatic_Callback(hObject, ~, handles) %#ok<DEFNU>
    handles = UpdateCBValues(handles, 'cbFilterStatic', get(hObject,'Value'));
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject,handles);
end

% Executes on click
function cbNormalize_Callback(hObject, ~, handles) %#ok<DEFNU>
    handles = UpdateCBValues(handles, 'cbNormalize', get(hObject,'Value'));
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject,handles);
end

%% Continuous Capture
% Executes on button press in tglConfig.
function tglConfig_Callback(hObject, ~, handles) %#ok<DEFNU>
    if get(hObject,'Value')
        set(handles.tglContinuous,'Enable','on');
    else
        set(handles.tglContinuous,'Enable','off');
        set(handles.tglContinuous,'Value',0);
        guidata(hObject,handles);
    end
    guidata(hObject,handles);
end

%% Custom Functions
% Initialization
function handles = Initialize(handles)
    intGUISize = get(handles.hmiConfig,'Position');
    intGUISize(3) = 133;
    set(handles.hmiConfig,'Position',intGUISize);
    
    hList = findobj('Style','edit');
    
    for i = 1:length(hList)
        handles.Param.(get(hList(i),'Tag')) = getBoxVal(hList(i));
        handles.ParamC.(get(hList(i),'Tag')) = getBoxVal(hList(i));
    end
    
    handles.Param.cbCrop = 0;
    handles.ParamC.cbCrop = 1;
    
    hList = findobj('Parent',handles.pnlImgProc,'Style','checkbox');
    
    for i = 1:length(hList)
        handles.Param.(get(hList(i),'Tag')) = get(hList(i),'Value');
        handles.ParamC.(get(hList(i),'Tag')) = get(hList(i),'Value');
        handles.imgProcCB.(get(hList(i),'Tag')) = get(hList(i),'Value');
    end
    
    handles.Stats.GperL = {};
    handles.Stats.Diameters = {};
    
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
function handles = plotSample(imgShow, handles, strAxis)
    % Create size of small/big particle in pixels
    imgMinParticle = fspecial('disk',getBoxVal(handles.txtMinDiam) / ...
                                     getBoxVal(handles.txtPixelLen)/2);
    imgMinParticle(imgMinParticle>0) = 0.5;
    imgMaxParticle = fspecial('disk',getBoxVal(handles.txtMaxDiam) / ...
                                     getBoxVal(handles.txtPixelLen)/2);
    imgMaxParticle(imgMaxParticle>0) = 0.5;
    
    imgRaw = imgShow;
    % Image Processing
    if get(handles.cbNormalize,'Value')
        imgShow = ProcessImage(imgShow,'Normalize');
    end
    if get(handles.cbBinary,'Value')
        imgShow = ProcessImage(imgShow,'bw',getBoxVal(handles.txtThreshold));
    end
    if get(handles.cbOutOfRange,'Value')
        imgShow = ProcessImage(imgShow,'remOutOfRange',sum(imgMinParticle(:))*2,sum(imgMaxParticle(:))*2);
    end
    if get(handles.cbRemoveBorder,'Value')
        imgShow = ProcessImage(imgShow,'remBorder');
    end
    if get(handles.cbRoundness,'Value')
        imgShow = ProcessImage(imgShow,'Roundness',handles);
    end
    if get(handles.cbFilterStatic,'Value')
        imgShow = ProcessImage(imgShow,'Static', handles);
    end
    handles.imgProcessed = imgShow;
    
    switch strAxis
        case 'axeRaw'
            axes(handles.axeRaw);
            cla;
            imshow(imgRaw);
            
            axes(handles.axeProcessed);
            cla;
            imshow(handles.imgProcessed);
        case 'axeSampleImg'
            axes(handles.axeSampleImg);
    
            cla;
            hold on;
            
            % Add size of small and big particle to image
            sizMin = size(imgMinParticle);
            sizMax = size(imgMaxParticle);
            yOffset1 = floor(size(imgShow,1)/20);
            yOffset2 = yOffset1 + sizMin(1) + floor(size(imgShow,1)/20);
            minMaxExample = ones(yOffset2,sizMax(2));
            minMaxExample(yOffset1:sizMin(1)+yOffset1-1, 1:sizMin(2)) = 1-imgMinParticle;
            minMaxExample(yOffset2:sizMax(1)+yOffset2-1, 1:sizMax(2)) = 1-imgMaxParticle;

            imshow(imgShow);
            imshow(minMaxExample);

            text(sizMin(2)+10,sizMin(1)/2+yOffset1, ...
                 'Min Particle Size', ...
                 'Color',[1 0 0]);
            text(sizMax(2)+10,sizMax(1)/2+yOffset2, ...
                 'Max Particle Size', ...
                 'Color',[1 0 0]);
    
            intCenterX = getBoxVal(handles.txtCenterX);
            intCenterY = getBoxVal(handles.txtCenterY);
            handles.hScatter = scatter(intCenterX,intCenterY,'*r');
            intTextY = intCenterY - size(imgShow,1)/20;
            handles.hText = text(intCenterX,intTextY,'Frame Center',...
                                 'HorizontalAlignment','center',...
                                 'Color',[1 0 0]);
    
            % Set function handle of this function to plots (children)
            set(get(handles.axeSampleImg,'Children'),'ButtonDownFcn',@axeSampleImg_ButtonDownFcn);
    end
end

function imgProcessed = ProcessImage(imgRaw, strProcess, varargin)
    switch strProcess
        case 'Normalize'
            imgProcessed = (imgRaw - min(imgRaw(:))) ./ (max(imgRaw(:))-min(imgRaw(:)));
        case 'bw'   % Change to binary image
            imgProcessed = im2bw(imgRaw,varargin{1});
        case 'remOutOfRange'  % Remove objects smaller than Min Particle Diameter
            imgRaw = ~(bwareaopen(~imgRaw, varargin{1}));
            
            intTooBig = varargin{2};
            imgNoBorder = ~(imclearborder(~imgRaw));
            objBound = bwboundaries(~imgNoBorder,'noholes');
            RProp = regionprops(~imgNoBorder, 'Area', 'Perimeter');
            for i = 1:length(objBound)
                if RProp(i).Area > intTooBig
                    imgRaw(objBound{i}(:,1),objBound{i}(:,2)) = 1;
                end
            end
            
            imgProcessed = imgRaw;
        case 'remBorder'    % Remove borders
            imgProcessed = ~(imclearborder(~imgRaw));
        case 'Roundness'
            handles = varargin{1};
            objBound = bwboundaries(~imgRaw,'noholes');
            RProp = regionprops(~imgRaw, 'Area', 'Perimeter');
            for i = 1:length(objBound)
                isRound = 4 * pi * RProp(i).Area / RProp(i).Perimeter^2;
                if isRound < getBoxVal(handles.txtRoundLow) || isRound > getBoxVal(handles.txtRoundHigh)
                    imgRaw(objBound{i}(:,1),objBound{i}(:,2)) = 1;
                end
            end
            
            imgProcessed = imgRaw;
        case 'Static'
            handles = varargin{1};
            imgOld = im2bw(handles.imgCompare, getBoxVal(handles.txtThreshold));
            imgNew = im2bw(handles.imgRaw, getBoxVal(handles.txtThreshold));
            binCompare = imgNew - imgOld;
            imgRaw(binCompare == 0) = max(imgRaw(:));
            imgProcessed = imgRaw;
    end
end

function handles = UpdateCBValues(handles, strCBTag, binValue)
    handles.Param.(strCBTag) = binValue;
    handles.ParamC.(strCBTag) = binValue;
    handles.imgProcCB.(strCBTag) = binValue;
end

%% Not Used

%% Work in progress


% --- Executes on button press in tglContinuous.
function tglContinuous_Callback(hObject, ~, handles) %#ok<DEFNU>
    intSize = get(handles.hmiConfig,'Position');
    if get(hObject,'Value')
        intSize(3) = 270;
        set(handles.hmiConfig,'Position',intSize);
        set(handles.pnlContinuous,'Visible','on')
        set(handles.tglStartPause,'Visible','on','Value',0)
    else
        intSize(3) = 133;
        set(handles.hmiConfig,'Position',intSize);
        set(handles.pnlContinuous,'Visible','off')
        set(handles.tglStartPause,'Visible','off')
    end
    
    guidata(hObject,handles);
end

% --- Executes on button press in tglStartPause.
function tglStartPause_Callback(hObject, ~, handles) %#ok<DEFNU>
    if get(hObject,'Value')
        set(hObject,'String','Pause');
        if ~isfield(handles,'Time')
            handles.Time = tic;
        end
        if ~isfield(handles,'Counter')
            handles.Counter = 1;
        end
    else
        set(hObject,'String','Start');
    end
    
    while (get(hObject,'Value'))
        if isfield(handles,'imgRaw')
            handles.imgCompare = handles.imgRaw;
            set(handles.cbFilterStatic,'Enable','on');
        end
        % Get image capture parameters
        dblExposure = getBoxVal(handles.txtExposure);
        dblGain = getBoxVal(handles.txtGain);
        dblGamma = getBoxVal(handles.txtGamma);

        handles.imgRaw = automated_frame_capture(dblExposure, dblGain, dblGamma);

        if handles.imgRaw == -1
            errordlg('Error while retrieving picture from camera')
            return;
        end
%         handles.imgRaw = imread(['D:\Users\Kepstrum\Desktop\Test\' num2str(mod(handles.Counter-1,3)+1) '.jpg']);
    
        % Set image to grayscale
        if size(handles.imgRaw,3) == 3
            handles.imgRaw = rgb2gray(handles.imgRaw);
        end
        handles.imgRaw = double(handles.imgRaw);
        handles.imgRaw = handles.imgRaw ./ 255;
        
        handles = cbCrop_Callback(handles.cbCrop,[],handles);
        guidata(hObject,handles);
        
        handles = ProcImgStats(handles);
        
        PlotStats(handles)
        
        dblTime = toc(handles.Time);
        strHour = num2str(floor(dblTime/3600));
        strMin = num2str(floor(mod(dblTime,3600)/60));
        strSec = num2str(floor(mod(dblTime,60)));
        strTime = [strHour ':' strMin ':' strSec];
        set(handles.txtTimeElapsed,'String',strTime);
        
        handles.Counter = handles.Counter + 1;

        guidata(hObject,handles);
    end

    guidata(hObject,handles);
end

function handles = ProcImgStats(handles)
    imgProcessed = ~handles.imgProcessed;
    RProp = regionprops(imgProcessed, 'EquivDiameter');
    
    intSumVol = 0;
    arrDiam = [];
    for i = 1:length(RProp)
        dblDiam = RProp(i).EquivDiameter * getBoxVal(handles.txtPixelLen);
        intSumVol = intSumVol + 4/3*pi*(dblDiam/2)^3;
        
        arrDiam(end+1) = dblDiam;
    end
    
    handles.Stats.GperL{mod(handles.Counter-1,500)+1} = ...
            [handles.Counter,intSumVol / 1000^3 * ...
            getBoxVal(handles.txtDensity) / ...
            (getBoxVal(handles.txtFrameVol) / 10^3 / 1000)];
    
    intTime = clock;
    strTime = sprintf('%u_%u_%u_%u_%u_%2.2f',intTime);
    handles.Stats.Diameters{mod(handles.Counter-1,500)+1} = ...
            {handles.Counter,strTime,arrDiam};
end

function PlotStats(handles)
    axes(handles.axeGperL);
    arrGperL = handles.Stats.GperL;
    for i = 1:length(arrGperL)
        intGperL(i,1) = arrGperL{i}(1);
        intGperL(i,2) = arrGperL{i}(2);
    end
    plot(intGperL(:,1),intGperL(:,2));
    xlabel('Image #');
    ylabel('Grams/Liter');
    xlim([handles.Counter - 10, handles.Counter]);
    
    axes(handles.axeHist);
    cla;
    bins = histc(handles.Stats.Diameters{handles.Counter}{3},0:0.1:getBoxVal(handles.txtMaxDiam));
    bar(0:0.1:getBoxVal(handles.txtMaxDiam),bins);
end

% --- Executes on slider movement.
function sldHistorical_Callback(hObject, eventdata, handles) %#ok<DEFNU>
% hObject    handle to sldHistorical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
end