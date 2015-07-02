%% Notes
% moving avg size (Done in PLC?)
% Save photos from camera sampling?
% g/L plot will have a line joining the current point to a point from 500
%     points ago due to limiting the cell size to be 500 for memory purposes,
%     though really the memory should be ok even if it's not done. But probably
%     a good idea to do it as is, not a huge deal since the final thing won't
%     be on matlab anyway

%% Code Notes (for Ronan)
% 'set' function sets the property of an object
% 'get' function gets the property of an object
% 'handles' is the master data structure of the entire HMI, stores all
%   objects and custom data fields that I created. 'handles' updates with
%   the guidata function, or if the function passes back the 'handles'
%   variable. guidata only works in default functions (like callback) which
%   is why handles needs to be passed back for all other cases.
% Reason the code becomes slow when editing is because MATLAB uploads all
%   of it to RAM and this file is getting too large, so maybe separate out
%   some of the functions into other files
% To change any of the default textbox/checkbox etc values, use the 'guide'
%   command and open the .fig file

%% Main GUI Functions
% This section contains all the functions automatically generated when the
% GUI is created

function varargout = Config(varargin)
    % Biye's notes: This function is automatically generated with MATLAB's
    % 'guide' whenever you make a new GUI.  The only thing I added here is
    % the error check because all errors regress to this initial function.
    % I wouldn't change much in here.

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

    % Last Modified by GUIDE v2.5 02-Jul-2015 09:47:38

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
    % Biye's notes: This function executes when the HMI instance is
    % created.

    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to Config (see VARARGIN)
    
    % Clear MATLAB screen (irrelevant for compiled version)
    clc
    
    % Initialize variables
    % handles is the master data structure for all GUIs made in 'guide', all
    % functions that pass back handles as an output makes changes to said
    % structure and/or is not a native 'guide' function
    handles = Initialize(handles);
    % Adds the path for the Lumenera functions (assuming the folder is in
    % the same directory)
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
    % Biye's notes: This function is used if you need to output anything
    % from the HMI to the outside (for example if another function calls
    % this HMI). Currently not used since this function is standalone

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
    % Was used at one point to output data from the HMI, but basically not
    % important anymore (still used)
    delete(hObject);
    % uiresume;
end

%% Image Settings (Textboxes)
% This section contains all the callback functions of the textboxes
% contained in the HMI in the Image Settings panel (ones that need to
% perform any action upon change)

% Executes when Enter or Tab is pressed
function txtCenterX_Callback(hObject, ~, handles) %#ok<DEFNU>
    % If there is a plot in axeSampleImg, then update the center point X
    % coordinate
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
    % If there is a plot in axeSampleImg, then update the center point Y
    % coordinate
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
    % Sets the slider for gain to match the value entered in the textbox
    set(handles.sldGain,'Value',getBoxVal(hObject));
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtGamma_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Sets the slider for gamma to match the value entered in the textbox
    set(handles.sldGamma,'Value',getBoxVal(hObject));
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtThreshold_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Sets the slider for threshold to match the value entered in the textbox
    set(handles.sldThreshold,'Value',getBoxVal(hObject));

    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtCropWidth_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Update the image in axeSampleImg with the new cropped width

    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop, [], handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtCropHeight_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Update the image in axeSampleImg with the new cropped height
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop, [], handles);
    guidata(hObject, handles);
end

%% Image Settings (Sliders)
% This section contains all the callback functions of the sliders
% contained in the HMI in the Image Settings panel

% Executes on slider movement.
function sldGain_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Sets the textbox value for gain to match the slider position

    set(handles.txtGain,'String',get(hObject,'Value'));
    
    % Update handles structure
    [~,handles] = getBoxVal(handles.txtGain,handles,handles);
    guidata(hObject, handles);
end

% Executes on slider movement.
function sldGamma_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Sets the textbox value for gamma to match the slider position

    set(handles.txtGamma,'String',get(hObject,'Value'));
    
    % Update handles structure
    [~,handles] = getBoxVal(handles.txtGamma,handles);
    guidata(hObject, handles);
end

% Executes on slider movement.
function sldThreshold_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Sets the textbox value for threshold to match the slider position

    set(handles.txtThreshold,'String',get(hObject,'Value'));
    
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    
    % Update handles structure
    [~,handles] = getBoxVal(handles.txtThreshold,handles);
    guidata(hObject, handles);
end

%% Image Settings (Other)
% This section contains all the callback functions of all other objects
% contained in the HMI (ones that need to perform any action upon change)

% Executes on mouse click on axis or its plots
function axeSampleImg_ButtonDownFcn(hObject, ~, ~)
    % Activates when you click on the axis area, which will either take a
    % photo from the Camera OR ask you for a file location depending on the
    % radio button selected above the axis

    % Gets the handles object, done this way due to function mapping on
    % children plots (see plotSample)
    handles = guidata(hObject);
    
    % Get tag of selected radial button
    strSource = get(get(handles.pnlSource,'SelectedObject'),'Tag');
    
    % Obsolete (for now)
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
            [strFileName, strPath] = uigetfile({'*.jpg;*.bmp;*.png;*.tif','All Image Files'},...
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
    % Change image to double and bring the range down to 0-1
    handles.imgRaw = double(handles.imgRaw);
    handles.imgRaw = handles.imgRaw ./ 255;
    
    % Plot the image onto axeSampleImg
    handles = plotSample(handles.imgRaw, handles, 'axeSampleImg');
    
    % Enable cropping checkbox
    set(handles.cbCrop,'Enable','on');
    
    % Update handles structure
    handles = cbCrop_Callback(handles.cbCrop, [], handles);
    guidata(handles.axeSampleImg, handles);
end

% Executes on click
function handles = cbCrop_Callback(hObject, ~, handles)
    % Crops/uncrops the image depending on the state of the checkbox
    % Doubles as a refresh function, which is why it's called so often, and
    % also why it has to pass back the handles structure

    % Checks whether there is a plot in axeSampleImg OR whether the Config
    % Ready toggle is on
    if sum(ishandle(get(handles.axeSampleImg,'Children'))) > 0 || get(handles.tglConfig,'Value') > 0
        if get(hObject,'Value')     % Checks the state of the checkbox
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
    % Enable/disable certain options depending on the selection (from file
    % or camera)

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
% This section contains all the callback functions of all other objects
% contained in the HMI in the Calculation Parameters panel (ones that need to
% perform any action upon change)

% Executes when Enter or Tab is pressed
function txtFrameDepth_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Updates the total volume based on the depth entered (width and height
    % are fixed and assumed true)

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
% This section contains all the callback functions of all other objects
% contained in the HMI in other panels (ones that need to
% perform any action upon change)

% Executes when Enter or Tab is pressed
function txtPixelLen_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Updates all fields that depend on the pixel length parameter

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
% This section contains all the callback functions of all other objects
% contained in the HMI in the Image Processing panel (ones that need to
% perform any action upon change)

% Executes on click
function cbOutOfRange_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the status of the checkbox and updates the image

    handles = UpdateCBValues(handles, 'cbOutOfRange', get(hObject,'Value'));
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject,handles);
end

% Executes on click
function cbBinary_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the status of the checkbox and updates the image
    % Also acts as an enable/disable (almost) all image processing
    % functions
    
    % This stores the current states of the checkboxes in order to restore
    % them when this checkbox is toggled
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
    % Changes the status of the checkbox and updates the image
    
    handles = UpdateCBValues(handles, 'cbRemoveBorder', get(hObject,'Value'));
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject,handles);
end

% Executes on click
function cbRoundness_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the status of the checkbox and updates the image
    % Enable/disable relevant textboxes
    
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
    % Changes the value of the textbox and updates the image
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtRoundLow_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the value of the textbox and updates the image
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtMinDiam_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the value of the textbox and updates the image
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtMaxDiam_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the value of the textbox and updates the image
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject, handles);
end

% Executes on click
function cbFilterStatic_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the status of the checkbox and updates the image
    
    handles = UpdateCBValues(handles, 'cbFilterStatic', get(hObject,'Value'));
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject,handles);
end

% Executes on click
function cbNormalize_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the status of the checkbox and updates the image
    
    handles = UpdateCBValues(handles, 'cbNormalize', get(hObject,'Value'));
    handles = cbCrop_Callback(handles.cbCrop,[],handles);
    guidata(hObject,handles);
end

%% Continuous Capture
% This section contains all the callback functions of all objects
% contained in the HMI in the Continuous Capture section (ones that need to
% perform any action upon change)

% Executes on button press in tglConfig.
function tglConfig_Callback(hObject, ~, handles) %#ok<DEFNU>
    % The button you click when you're done with setting the configuration
    % parameters and is ready for continuous capture

    if get(hObject,'Value')
        set(handles.tglContinuous,'Enable','on');
    else
        set(handles.tglContinuous,'Enable','off');
        set(handles.tglContinuous,'Value',0);
        guidata(hObject,handles);
    end
    guidata(hObject,handles);
end

% Executes on button press in tglContinuous.
function tglContinuous_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Expands the HMI to the continuous capture section

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

% Executes on button press in tglStartPause.
function tglStartPause_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Start/Pause continuous capture

    hList = findobj('Parent',handles.pnlContinuous,'Style','checkbox');

    if get(hObject,'Value')
        set(hObject,'String','Pause');
        if ~isfield(handles,'Time')
            % Sets a timer to see elapsed time
            handles.Time = tic;
        end
        if ~isfield(handles,'Counter')
            % Sets the counter for indexing
            handles.Counter = 1;
        end
        
        set(hList,'Enable','off');
        set(handles.sldHistorical,'Visible','off');
        set(handles.btnReview,'Visible','off');
    else
        set(hObject,'String','Start');
        set(hList,'Enable','on');
        set(handles.sldHistorical,'Visible','on');
        if ishandle(get(handles.axeGperL,'Children'))
            set(handles.btnReview,'Visible','on');
        end
    end
    
    % Set the time format for use in file saving
    intTime = clock;
    strTimeFile = sprintf('%u_%u_%u_%u_%u_%2.2f',intTime);
    
    while (get(hObject,'Value'))
%       Get image capture parameters
        dblExposure = getBoxVal(handles.txtExposure);
        dblGain = getBoxVal(handles.txtGain);
        dblGamma = getBoxVal(handles.txtGamma);

        handles.imgRaw = automated_frame_capture(dblExposure, dblGain, dblGamma);

        if handles.imgRaw == -1
            errordlg('Error while retrieving picture from camera')
            return;
        end
        
        % Simulated continuous capture, used for troubleshooting without a
        % camera
%         handles.imgRaw = imread(['D:\Users\Kepstrum\Desktop\Test\' num2str(mod(handles.Counter-1,3)+1) '.png']);
    
        % Set image to grayscale
        if size(handles.imgRaw,3) == 3
            handles.imgRaw = rgb2gray(handles.imgRaw);
        end
        % Change image to double and bring the range down to 0-1
        handles.imgRaw = double(handles.imgRaw);
        handles.imgRaw = handles.imgRaw ./ 255;
        
        % Refresh/update because next few lines pass in handles
        handles = cbCrop_Callback(handles.cbCrop,[],handles);
        guidata(hObject,handles);
        
        % Get Statistics (particle diameters) for the processed image
        handles = ProcImgStats(handles);
        
        % Plot the g/L and histogram
        handles = PlotStats(handles);
        
        % Update time elapsed
        dblTime = toc(handles.Time);
        strHour = num2str(floor(dblTime/3600));
        strMin = num2str(floor(mod(dblTime,3600)/60));
        strSec = num2str(floor(mod(dblTime,60)));
        strTime = [strHour ':' strMin ':' strSec];
        set(handles.txtTimeElapsed,'String',strTime);
        
        % Update the slider for g/L plot
        set(handles.sldHistorical,'Max',handles.Counter, ...
            'Value',handles.Counter);
        if handles.Counter > 500
            set(handles.sldHistorical,'Min',handles.Counter-499)
        end
        
        %%% (should be separated out to its own function) %%%%%%%%%%%%%%%%%
        % Save data according to the checkboxes checked
        if ~isdir('Saved Data')
            mkdir('Saved Data')
        end
        dirSave = ['Saved Data\' strTimeFile '\'];
        handles.dirSave = dirSave;
        if ~isdir(dirSave)
            mkdir(dirSave)
        end
        
        % Save raw image
        if get(handles.cbSaveRaw, 'Value')
            imwrite(handles.imgRaw,[dirSave int2str(handles.Counter) 'Raw.png'],'png');
            if get(handles.cbCrop, 'Value')
                imwrite(handles.imgRaw,[dirSave int2str(handles.Counter) 'RawCropped.png'],'png');
            end
        end
        
        % Save processed image
        if get(handles.cbSaveProcessed, 'Value')
            imwrite(handles.imgProcessed,[dirSave int2str(handles.Counter) 'Processed.png'],'png');
        end
        
        % Save g/L in csv text file
        if get(handles.cbSaveGperL, 'Value')
            fidGperL = fopen([dirSave 'GramsPerLiter.txt'], 'a');
            if handles.Counter == 1
                fprintf(fidGperL,'%s,%s,%s,%s\r\n','Index','Grams/Liter','Average g/L','Local Average g/L');
            end
            fprintf(fidGperL,'%d,%2.2f,%2.2f,%2.2f\r\n',handles.Stats.GperL{mod(handles.Counter-1,500)+1}(1), ...
                                              handles.Stats.GperL{mod(handles.Counter-1,500)+1}(2), ...
                                              handles.Stats.avgGperL(handles.Counter,2),...
                                              handles.Stats.localAvgGperL(handles.Counter,2));
            fclose(fidGperL);
        end
        
        % Save list of particle diameters used for the histogram
        if get(handles.cbSaveHist, 'Value')
            savVar = handles.Stats.Diameters{mod(handles.Counter-1,500)+1}; %#ok<NASGU>
            save([dirSave int2str(handles.Counter) 'Hist'], 'savVar');
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Increment master counter
        handles.Counter = handles.Counter + 1;

        guidata(hObject,handles);
    end

    guidata(hObject,handles);
end

% Executes on slider movement.
function sldHistorical_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Updates the range of the g/L plot to see past data (only stores past
    % 500 points, not tested, might break)

    axes(handles.axeGperL);
    intSlider = get(hObject,'Value');
    if (intSlider - 10) > 0
        xlim([intSlider - 10, intSlider]);
    else
        xlim([1, 10]);
    end
    
    guidata(hObject,handles);
end

% Executes on button press in cbSaveRaw.
function cbSaveRaw_Callback(hObject, ~, handles) %#ok<DEFNU>
    % If any of the 4 checkboxes are unchecked, disable the history option

    if get(hObject,'Value')
        hList = findobj('Parent',handles.pnlContinuous,'Style','checkbox');
        if sum(cell2mat(get(hList,'Value'))) == 4
            set(handles.sldHistorical,'Visible','on');
            set(handles.btnReview,'Enable','on');
        end
    else
        set(handles.sldHistorical,'Visible','off');
        set(handles.btnReview,'Enable','off');
    end

    guidata(hObject,handles);
end

% Executes on button press in cbSaveProcessed.
function cbSaveProcessed_Callback(hObject, ~, handles) %#ok<DEFNU>
    % If any of the 4 checkboxes are unchecked, disable the history option

    if get(hObject,'Value')
        hList = findobj('Parent',handles.pnlContinuous,'Style','checkbox');
        if sum(cell2mat(get(hList,'Value'))) == 4
            set(handles.sldHistorical,'Visible','on');
            set(handles.btnReview,'Enable','on');
        end
    else
        set(handles.sldHistorical,'Visible','off');
        set(handles.btnReview,'Enable','off');
    end

    guidata(hObject,handles);
end

% Executes on button press in cbSaveGperL.
function cbSaveGperL_Callback(hObject, ~, handles) %#ok<DEFNU>
    % If any of the 4 checkboxes are unchecked, disable the history option

    set(hObject,'Value',floor(get(hObject,'Value')))

    if get(hObject,'Value')
        hList = findobj('Parent',handles.pnlContinuous,'Style','checkbox');
        if sum(cell2mat(get(hList,'Value'))) == 4
            set(handles.sldHistorical,'Visible','on');
            set(handles.btnReview,'Enable','on');
        end
    else
        set(handles.sldHistorical,'Visible','off');
        set(handles.btnReview,'Enable','off');
    end

    guidata(hObject,handles);
end

% Executes on button press in cbSaveHist.
function cbSaveHist_Callback(hObject, ~, handles) %#ok<DEFNU>
    % If any of the 4 checkboxes are unchecked, disable the history option

    if get(hObject,'Value')
        hList = findobj('Parent',handles.pnlContinuous,'Style','checkbox');
        if sum(cell2mat(get(hList,'Value'))) == 4
            set(handles.sldHistorical,'Visible','on');
            set(handles.btnReview,'Enable','on');
        end
    else
        set(handles.sldHistorical,'Visible','off');
        set(handles.btnReview,'Enable','off');
    end

    guidata(hObject,handles);
end

% Executes on button press in btnReview.
function btnReview_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Lets you pick a point in the g/L plot and plots the historical
    % pictures/plots
    
    [x,~] = ginput(1);
    
    % Prioritizes cropped photo because the processed image will include
    % the cropping
    if exist([handles.dirSave int2str(round(x)) 'RawCropped.png'], 'file')
        imgRaw = imread([handles.dirSave int2str(round(x)) 'RawCropped.png']);
    else
        imgRaw = imread([handles.dirSave int2str(round(x)) 'Raw.png']);
    end
    imgProcessed = imread([handles.dirSave int2str(round(x)) 'Processed.png']);
    stcHist = load([handles.dirSave int2str(round(x)) 'Hist.mat'],'savVar');
    stcHist = stcHist.savVar;
    
    axes(handles.axeRaw);
    imshow(imgRaw);
    axes(handles.axeProcessed);
    imshow(imgProcessed);
    PlotStats(handles,stcHist);
    
    guidata(hObject,handles);
end

%% Custom Functions
% This section contains all the custom functions that does most of the
% actual work. These functions can all be taken outside as their separate
% files, but it was easier for me to work when they're all here.

% Initialization
function handles = Initialize(handles)
    % Called when HMI is created, initializes 'global' variables (handles)
    % and initial states

    % Reset the size of the HMI
    intGUISize = get(handles.hmiConfig,'Position');
    intGUISize(3) = 133;
    set(handles.hmiConfig,'Position',intGUISize);
    
    % handles.Param and ParamC used to be meant for exporting config
    % settings to the main program, but is now not used since this is the
    % main program
    hList = findobj('Style','edit');
    
    for i = 1:length(hList)
        handles.Param.(get(hList(i),'Tag')) = getBoxVal(hList(i));
        handles.ParamC.(get(hList(i),'Tag')) = getBoxVal(hList(i));
    end
    
    handles.Param.cbCrop = 0;
    handles.ParamC.cbCrop = 1;
    
    % imgProcCB is used to restore the checkbox states when cbBinary is
    % toggled
    hList = findobj('Parent',handles.pnlImgProc,'Style','checkbox');
    
    for i = 1:length(hList)
        handles.Param.(get(hList(i),'Tag')) = get(hList(i),'Value');
        handles.ParamC.(get(hList(i),'Tag')) = get(hList(i),'Value');
        handles.imgProcCB.(get(hList(i),'Tag')) = get(hList(i),'Value');
    end
    
    % Stats is where the particle counts are stored
    handles.Stats.GperL = {};
    handles.Stats.avgGperL = [];
    handles.Stats.localAvgGperL = [];
    handles.Stats.Diameters = {};
    
    % Update handles structure
    guidata(handles.hmiConfig, handles);
end

% Get double value from textboxes
function varargout = getBoxVal(varargin)
    % This function grabs the value in the specified textbox and outputs
    % its contents in double format
    % Also doubles as a textbox value update in the handles structure when
    % varargin{2} is used

    % The textbox object, does not check whether it's a textbox, so don't
    % use it for other objects
    hObject = varargin{1};
    
    % If varargin{2} is specified, then use it, otherwise generate a local
    % instance
    if nargin == 2
        handles = varargin{2};
    else
        handles = guidata(hObject);
    end
    
    % The value of the textbox
    varargout{1} = str2double(get(hObject,'String'));
    
    % Update the appropriate Param (obsolete)
    switch get(handles.cbCrop,'Value')
        case 1
            handles.ParamC.(get(hObject,'Tag')) = varargout{1};
        case 0
            handles.Param.(get(hObject,'Tag')) = varargout{1};
    end
    
    % Outputting handles
    varargout{2} = handles;
end

% Plots the sample image and the center point
function handles = plotSample(imgShow, handles, strAxis)
    % Originally ued to plot in axeSampleImg (hence plotSample) but now is
    % also used to plot for continuous capture

    % Create the sample of small and big particles according to the current
    % min/max diameters and pixel length settings
    imgMinParticle = fspecial('disk',getBoxVal(handles.txtMinDiam) / ...
                                     getBoxVal(handles.txtPixelLen)/2);
    imgMinParticle(imgMinParticle>0) = 0.5;
    imgMaxParticle = fspecial('disk',getBoxVal(handles.txtMaxDiam) / ...
                                     getBoxVal(handles.txtPixelLen)/2);
    imgMaxParticle(imgMaxParticle>0) = 0.5;
    
    imgRaw = imgShow;
    % Performs the image processing based on the checkboxes checked, the
    % order that these go in MATTER, in that having one before the other
    % affects the outcome
    if get(handles.cbNormalize,'Value')
        imgShow = ProcessImage(imgShow,'Normalize');
    end
    if get(handles.cbBinary,'Value')
        imgShow = ProcessImage(imgShow,'bw',getBoxVal(handles.txtThreshold));
    end
    if get(handles.cbRemoveBorder,'Value')
        imgShow = ProcessImage(imgShow,'remBorder');
    end
    if get(handles.cbFilterStatic,'Value')
        imgShow = ProcessImage(imgShow,'Static', handles);
    end
    if get(handles.cbOutOfRange,'Value')
        imgShow = ProcessImage(imgShow,'remOutOfRange',sum(imgMinParticle(:))*2,sum(imgMaxParticle(:))*2);
    end
    if get(handles.cbRoundness,'Value')
        imgShow = ProcessImage(imgShow,'Roundness',handles);
    end
    handles.imgProcessed = imgShow;
    
    % This is where it differentiates between plotting to sample and
    % plotting to continuous
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
    
            % Adds the center point on the plot
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

% Image processing functions
function imgProcessed = ProcessImage(imgRaw, strProcess, varargin)
    % Where all the image processing happens

    switch strProcess
        case 'Normalize'
            % Stretch the image intensity to the lower/upper limits
            % (min->0, max->1)
            imgProcessed = (imgRaw - min(imgRaw(:))) ./ (max(imgRaw(:))-min(imgRaw(:)));
        case 'bw'
            % Change to binary image
            imgProcessed = im2bw(imgRaw,varargin{1});
        case 'remOutOfRange'
            % Remove objects smaller than min diameter and bigger than max
            % diameter
            
            % min
            imgRaw = ~(bwareaopen(~imgRaw, varargin{1}));
            
            % max
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
        case 'remBorder'
            % Remove anything touching the edge of the screen and
            % everything connected to itborders
            imgProcessed = ~(imclearborder(~imgRaw));
        case 'Roundness'
            % Check for roundness of the particle, small particles actually
            % have a roundness up to 1.3 (due to digitalization) so that's
            % why the setting is at 1.3.  I know this was originally meant
            % for bubbles but we don't have that problem here and this
            % isn't the best way to do it. But what this function will do
            % is remove any long scratch marks or fibers like before
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
            % Compares the current image with the previous image and
            % removes any objects that are detected in the same location
            % (won't be a huge issue on imparing particle detection unless
            % you're above 10g/L or so
            handles = varargin{1};
            if isfield(handles,'imgCompare')
                imgOld = handles.imgCompare;
                imgNew = handles.imgRaw;
                % Normalize and binary the image for better results
                if get(handles.cbNormalize,'Value')
                    imgOld = ProcessImage(imgOld,'Normalize');
                    imgNew = ProcessImage(imgNew,'Normalize');
                end
                imgOld = im2bw(imgOld, getBoxVal(handles.txtThreshold));
                imgNew = im2bw(imgNew, getBoxVal(handles.txtThreshold));
                
                % Compare and erase static objects from the current image
                binCompare = imgNew - imgOld;
                imgRaw(binCompare == 0) = max(imgRaw(:));
                imgProcessed = imgRaw;
            end
    end
    % If no image processing is actually done, return the old image
    if ~exist('imgProcessed','var')
        imgProcessed = imgRaw;
    end
end

% Update checkbox values to handles
function handles = UpdateCBValues(handles, strCBTag, binValue)
    % This function updates the checkbox values, used for toggling cbBinary
    
    handles.Param.(strCBTag) = binValue;
    handles.ParamC.(strCBTag) = binValue;
    handles.imgProcCB.(strCBTag) = binValue;
end

% Get processed image statistics
function handles = ProcImgStats(handles)
    % This function gets the statistics (particle diameters) of the
    % processed image

    imgProcessed = ~handles.imgProcessed;
    RProp = regionprops(imgProcessed, 'EquivDiameter');
    
    % Calculating g/L
    intSumVol = 0;
    arrDiam = [];
    for i = 1:length(RProp)
        dblDiam = RProp(i).EquivDiameter * getBoxVal(handles.txtPixelLen);
        intSumVol = intSumVol + 4/3*pi*(dblDiam/2)^3;
        
        arrDiam(end+1) = dblDiam; %#ok<AGROW>
    end
    
    % GperL is a cell structure, where each cell contains the index and the
    % g/L value in an array
    handles.Stats.GperL{mod(handles.Counter-1,500)+1} = ...
            [handles.Counter,intSumVol / 10^3 * ...
            getBoxVal(handles.txtDensity) / ...
            (getBoxVal(handles.txtFrameVol) / 10^3 / 1000)];
    
    % Diameters is a cell structure, where each cell contains the index,
    % system time, and the full list of diameters in a cell format. The
    % diameters themselves are stored in an array
    intTime = clock;
    strTime = sprintf('%u_%u_%u_%u_%u_%2.2f',intTime);
    handles.Stats.Diameters{mod(handles.Counter-1,500)+1} = ...
            {handles.Counter,strTime,arrDiam};
end

% Plot image statistics
function handles = PlotStats(varargin)
    % Plots the g/L and histogram

    handles = varargin{1};
    
    % g/L
    axes(handles.axeGperL);
    if nargin == 1
        arrGperL = handles.Stats.GperL;
        for i = 1:length(arrGperL)
            intGperL(i,1) = arrGperL{i}(1); %#ok<AGROW>
            intGperL(i,2) = arrGperL{i}(2); %#ok<AGROW>
        end
        plot(intGperL(:,1),intGperL(:,2));
        
        % Plots the average of the g/L so far as a red line
        hold on
        plot(intGperL(:,1),ones(i,1)*mean(intGperL(:,2)),'r');
        plot(intGperL(:,1),ones(i,1)*mean(intGperL(max(end-20,1):end,2)),'g');
        handles.Stats.avgGperL(handles.Counter,:) = [handles.Counter,mean(intGperL(:,2))];
        handles.Stats.localAvgGperL(handles.Counter,:) = [handles.Counter,mean(intGperL(max(end-20,1):end,2))];
        hold off
        
        % Only shows the 10 most recent results (use slider to see history)
        xlabel('Image #');
        ylabel('Grams/Liter');
        xlim([handles.Counter - 10, handles.Counter]);
    end
    
    % Histogram
    axes(handles.axeHist);
    cla;
    
    % Histogram bins are determined by the min and max diameteres set in
    % their respective textboxes and each bin size will always be 0.1. If
    % max is not exactly 0.1*n away from min, then the closest 0.1*n value
    % below max will be the biggest bin size cutoff
    dblMinDiam = getBoxVal(handles.txtMinDiam);
    dblMaxDiam = getBoxVal(handles.txtMaxDiam);
    if nargin == 1
        bins = histc(handles.Stats.Diameters{mod(handles.Counter-1,500)+1}{3},dblMinDiam:0.1:dblMaxDiam);
        set(handles.lblTimeStamp,'String',handles.Stats.Diameters{mod(handles.Counter-1,500)+1}{2});
    else
        bins = histc(varargin{2}{3},dblMinDiam:0.1:dblMaxDiam);
        set(handles.lblTimeStamp,'String',varargin{2}{2});
    end
    if isempty(bins)
        bins = zeros(length(dblMinDiam:0.1:dblMaxDiam),1);
    end
    bar(dblMinDiam:0.1:dblMaxDiam,bins);
    xlabel('Particle Diameter [mm]');
    ylabel('Count');
    xlim([dblMinDiam, dblMaxDiam]);
    % Since the histogram takes a bit of time to process, it will lag
    % behind the other plots. Maybe sync the plotting functions so that
    % they all appear together (aka plot histogram first?)
end

%% Not Used
% This section contains all the functions that are not used, but has been
% in the past and has potential to be used in the future

function txtMovAvg_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the moving average size, which currently doesn't affect
    % anything.  Though with the average g/L already being plotted and
    % reviewing historical data being possible, this might remain a legacy
    % function

    set(handles.sldGain,'Value',getBoxVal(hObject));
    
    % Update handles structure
    [~,handles] = getBoxVal(hObject,handles);
    guidata(hObject, handles);
end

%% Work in progress
% This section contains all the functions that are being worked on. New
% functions are always added to the bottom of the file, so it helps
% organization
