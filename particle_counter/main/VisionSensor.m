%% Notes
% g/L plot will have a line joining the current point to a point from 500
%     points ago due to limiting the cell size to be 500 for memory purposes,
%     though really the memory should be ok even if it's not done. But probably
%     a good idea to do it as is, not a huge deal since the final thing won't
%     be on matlab anyway
% Ability to save settings changed
% Resize things for smaller screen

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

function varargout = VisionSensor(varargin)
    % Biye's notes: This function is automatically generated with MATLAB's
    % 'guide' whenever you make a new GUI.  The only thing I added here is
    % the error check because all errors regress to this initial function.
    % I wouldn't change much in here.

    % VISIONSENSOR MATLAB code for VisionSensor.fig
    %      VISIONSENSOR, by itself, creates a new VISIONSENSOR or raises the existing
    %      singleton*.
    %
    %      H = VISIONSENSOR returns the handle to a new VISIONSENSOR or the handle to
    %      the existing singleton*.
    %
    %      VISIONSENSOR('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in VISIONSENSOR.M with the given input arguments.
    %
    %      VISIONSENSOR('Property','Value',...) creates a new VISIONSENSOR or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before VisionSensor_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to VisionSensor_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help VisionSensor

    % Last Modified by GUIDE v2.5 05-Aug-2015 12:38:22

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @VisionSensor_OpeningFcn, ...
                       'gui_OutputFcn',  @VisionSensor_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

%     try
        if nargout
            [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
        else
            gui_mainfcn(gui_State, varargin{:});
        end
%     catch ERROR
%         if ~isdir('ErrorLog')
%             mkdir('ErrorLog')
%         end
%         logError = fopen('ErrorLog\ERROR.txt','a');
% 
%         strErrorTime = datestr(now);
%         fprintf(logError,['%-' int2str(length(strErrorTime)) 's\r\n'...
%                           '%-' int2str(length(ERROR.message)) 's\r\n'...
%                           ],strErrorTime,ERROR.message);
%         strErrorTime = regexprep(strErrorTime,':','');
%         stcMemory = memory; %#ok<NASGU>
%         save(['ErrorLog\ ' strErrorTime '.mat'],'ERROR','stcMemory');
% 
%         fclose(logError);
%         errordlg(ERROR.message,'','modal');
%     end
end
% End initialization code - DO NOT EDIT

% --- Executes just before VisionSensor is made visible.
function VisionSensor_OpeningFcn(hObject, ~, handles, varargin)
    % Biye's notes: This function executes when the HMI instance is
    % created.

    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to VisionSensor (see VARARGIN)
    
    % Clear MATLAB screen (irrelevant for compiled version)
    clc
    
    % Adds the path for the Lumenera functions (assuming the folder is in
    % the same directory)
    addpath('Lumenera Matlab Driver V2.0.1 NEW 64 Bit')
    addpath('Supporting Functions')
    
    if nargin > 3 && isstruct(varargin{1})
        handles.Load = varargin{1};
    end
    
    % Initialize variables
    % handles is the master data structure for all GUIs made in 'guide', all
    % functions that pass back handles as an output makes changes to said
    % structure and/or is not a native 'guide' function
    handles = Initialize(handles);
    
    % Choose default command line output for VisionSensor
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes VisionSensor wait for user response (see UIRESUME)
    % uiwait(handles.hmiConfig);
end

% --- Outputs from this function are returned to the command line.
function varargout = VisionSensor_OutputFcn(hObject, ~, handles)  %#ok<INUSL>
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
end

% --- Executes when user attempts to close hmiConfig.
function hmiConfig_CloseRequestFcn(hObject, ~, ~) %#ok<DEFNU>
    % Was used at one point to output data from the HMI, but basically not
    % important anymore (still used)
    pause(0.01);
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
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end
    
    if ishandle(get(handles.axeSampleImg,'Children'))
        set(handles.hScatter,'XData',getBoxVal(hObject));
        posText = get(handles.hText,'Position');
        posText(1) = str2double(get(hObject,'String'));
        set(handles.hText,'Position',posText);
    end
    
    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtCenterY_Callback(hObject, ~, handles) %#ok<DEFNU>
    % If there is a plot in axeSampleImg, then update the center point Y
    % coordinate
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end
    
    if ishandle(get(handles.axeSampleImg,'Children'))
        set(handles.hScatter,'YData',getBoxVal(hObject));
        posText = get(handles.hText,'Position');
        posText(2) = str2double(get(hObject,'String')) - size(handles.imgRaw,1)/20;
        set(handles.hText,'Position',posText);
    end
    
    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtGain_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Sets the slider for gain to match the value entered in the textbox
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end
    
    set(handles.sldGain,'Value',getBoxVal(hObject));
    
    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtGamma_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Sets the slider for gamma to match the value entered in the textbox
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end
    
    set(handles.sldGamma,'Value',getBoxVal(hObject));
    
    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtThreshold_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Sets the slider for threshold to match the value entered in the textbox
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end
    
    set(handles.sldThreshold,'Value',getBoxVal(hObject));

    handles = RefreshPlots(handles);
    
    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtCropWidth_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Update the image in axeSampleImg with the new cropped width
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end

    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    handles = RefreshPlots(handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtCropHeight_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Update the image in axeSampleImg with the new cropped height
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end
    
    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    handles = RefreshPlots(handles);
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
    handles = UpdateBoxVal(handles.txtGain,handles);
    guidata(hObject, handles);
end

% Executes on slider movement.
function sldGamma_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Sets the textbox value for gamma to match the slider position

    set(handles.txtGamma,'String',get(hObject,'Value'));
    
    % Update handles structure
    handles = UpdateBoxVal(handles.txtGamma,handles);
    guidata(hObject, handles);
end

% Executes on slider movement.
function sldThreshold_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Sets the textbox value for threshold to match the slider position

    set(handles.txtThreshold,'String',get(hObject,'Value'));
    
    handles = RefreshPlots(handles);
    
    % Update handles structure
    handles = UpdateBoxVal(handles.txtThreshold,handles);
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
    
    if isfield(handles,'imgRaw')
        handles.imgCompare = handles.imgRaw;
        if get(handles.cbCrop,'Value')
            handles.imgCompareCropped = handles.imgRawCropped;
        end
    end
    
    switch strSource
        case 'radCamera'
            % Get image capture parameters
            dblExposure = getBoxVal(handles.txtExposure);
            dblGain = getBoxVal(handles.txtGain);
            dblGamma = getBoxVal(handles.txtGamma);
            
            handles.imgRaw = automated_frame_capture(dblExposure, dblGain, dblGamma);
            
            if handles.imgRaw == -1
                errordlg('Error while retrieving picture from camera','','modal')
                return;
            end
        case 'radFromFile'
            [strFileName, strPath] = uigetfile({'*.jpg;*.bmp;*.png;*.tif','All Image Files'},...
                                                    'Select Image File');
            if ~strFileName
                errordlg('No file selected','','modal')
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
    handles = RefreshPlots(handles);
    
    % Update handles structure
    handles = RefreshPlots(handles);
    guidata(handles.axeSampleImg, handles);
end

% Executes on click
function handles = cbCrop_Callback(hObject, ~, handles)
    % Crops/uncrops the image depending on the state of the checkbox

    % Checks whether there is a plot in axeSampleImg OR whether the VisionSensor
    % Ready toggle is on
    if sum(ishandle(get(handles.axeSampleImg,'Children'))) > 0 || get(handles.tglStartPause,'Value')
        if get(hObject,'Value')     % Checks the state of the checkbox
            % Set crop rectangle
            intWidth = floor(getBoxVal(handles.txtCropWidth)/getBoxVal(handles.txtPixelLen));
            intHeight = floor(getBoxVal(handles.txtCropHeight)/getBoxVal(handles.txtPixelLen));
            intLowerX = max(handles.Param.txtCenterX - floor(intWidth/2),0);
            intLowerY = max(handles.Param.txtCenterY - floor(intHeight/2),0);
            
            % Check to make sure the crop window is valid
            sizRaw = size(handles.imgRaw);
            if ((intLowerY-intHeight) < 0) || ((intLowerX+intWidth) > sizRaw(2))
                errordlg('Crop window is too large for the current image!','','modal');
                return;
            end

            intCropWindow = [intLowerX, intLowerY, intWidth, intHeight];

            % Crop raw image
            handles.imgRawCropped = imcrop(handles.imgRaw,intCropWindow);

            % Update fields affected when cropping
            handles = CropUpdateFields(handles,intWidth,intHeight);
            
            handles = RefreshPlots(handles);
        else
            handles = CropUpdateFields(handles);
            % Plot/Restore uncropped image
            handles = RefreshPlots(handles);
        end
    else
%         warndlg('There is no image to crop, a preview cannot be shown.','','modal');
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
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end

    intFrameVol = getBoxVal(handles.txtFrameWidth) * ...
                  getBoxVal(handles.txtFrameHeight) * ...
                  getBoxVal(hObject);
    set(handles.txtFrameVol,'String',intFrameVol);
    
    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    handles = UpdateBoxVal(handles.txtFrameVol,handles);
    guidata(hObject, handles);
end

%% Other Settings
% This section contains all the callback functions of all other objects
% contained in the HMI in other panels (ones that need to
% perform any action upon change)

% Executes when Enter or Tab is pressed
function txtPixelLen_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Updates all fields that depend on the pixel length parameter
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end

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
    handles = UpdateBoxVal(hObject,handles);
    handles = UpdateBoxVal(handles.txtFrameWidth,handles);
    handles = UpdateBoxVal(handles.txtFrameHeight,handles);
    handles = UpdateBoxVal(handles.txtFrameVol,handles);
    handles = RefreshPlots(handles);
    guidata(hObject, handles);
end

% --- Executes on button press in btnSave.
function btnSave_Callback(~, ~, ~) %#ok<DEFNU>
    if ~isdir('Saved Projects')
        mkdir('Saved Projects')
    end
    
    i = 1;
    while ~exist('ERR','var')
        try
            load(['Saved Projects\ProjectSave' int2str(i) '.mat']);
        catch ERR %#ok<NASGU>
        end
        i = i+1;
    end
    i = i-1;
    clear ERR
    
    [strFileName,strPath,~] = uiputfile('*.mat','Save Project',['Saved Projects\ProjectSave' int2str(i) '.mat']);
    if ~strFileName
        errordlg('No file selected','','modal')
        return;
    end
    
    hAllTxt = findobj('Style','edit');
    hAllCb = findobj('Style','checkbox');
    hAllSlider = findobj('Style','slider');
    
    stcSave = struct('Textbox',struct,'Checkbox',struct,'Slider',struct);
    for i = 1:length(hAllTxt)
        tag = get(hAllTxt(i),'Tag');
        if ~strcmp('txtTimeElapsed',tag)
            stcSave.Textbox.(tag) = get(hAllTxt(i),'String');
        end
    end
    for i = 1:length(hAllCb)
        tag = get(hAllCb(i),'Tag');
        stcSave.Checkbox.(tag) = get(hAllCb(i),'Value');
    end
    for i = 1:length(hAllSlider)
        tag = get(hAllSlider(i),'Tag');
        if ~strcmp('sldHistorical',tag)
            stcSave.Slider.(tag) = get(hAllSlider(i),'Value');
        end
    end
    
    save([strPath strFileName],'-struct','stcSave');
end

%% Image Processing Options
% This section contains all the callback functions of all other objects
% contained in the HMI in the Image Processing panel (ones that need to
% perform any action upon change)

% Executes on click
function cbOutOfRange_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the status of the checkbox and updates the image

    handles = UpdateCBValues(handles, 'cbOutOfRange', get(hObject,'Value'));
    handles = RefreshPlots(handles);
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
            if ~strcmp(get(hList(i),'Tag'),{'cbNormalize';'cbBinary';'cbFilterStatic'})
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
    handles = RefreshPlots(handles);
    guidata(hObject,handles);
end

% Executes on click
function cbRemoveBorder_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the status of the checkbox and updates the image
    
    handles = UpdateCBValues(handles, 'cbRemoveBorder', get(hObject,'Value'));
    handles = RefreshPlots(handles);
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
    handles = RefreshPlots(handles);
    guidata(hObject,handles);
end

% Executes when Enter or Tab is pressed
function txtRoundHigh_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the value of the textbox and updates the image
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end
    
    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    handles = RefreshPlots(handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtRoundLow_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the value of the textbox and updates the image
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end
    
    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    handles = RefreshPlots(handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtMinDiam_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the value of the textbox and updates the image
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end
    
    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    handles = RefreshPlots(handles);
    guidata(hObject, handles);
end

% Executes when Enter or Tab is pressed
function txtMaxDiam_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the value of the textbox and updates the image
    
    if isnan(getBoxVal(hObject))
        errordlg('The textbox contains an invalid number, please only enter numerical values!','','modal');
        return;
    end
    
    % Update handles structure
    handles = UpdateBoxVal(hObject,handles);
    handles = RefreshPlots(handles);
    guidata(hObject, handles);
end

% Executes on click
function cbFilterStatic_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the status of the checkbox and updates the image
    
    if ~isfield(handles,'imgCompare')
        warndlg('There is no previous image to compare to, please load another photo if you wish to see the effect. This only affects the first image of the continuous capture','','modal');
    end
    
    handles = UpdateCBValues(handles, 'cbFilterStatic', get(hObject,'Value'));
    handles = RefreshPlots(handles);
    guidata(hObject,handles);
end

% Executes on click
function cbNormalize_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Changes the status of the checkbox and updates the image
    
    handles = UpdateCBValues(handles, 'cbNormalize', get(hObject,'Value'));
    handles = RefreshPlots(handles);
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
        set(handles.pnlContinuous,'Visible','on')
        set(handles.tglStartPause,'Visible','on','Value',0)
        handles = tglStartPause_Callback(handles.tglStartPause, [], handles);
        set(handles.pnlImageSettings,'Visible','off')
        set(handles.pnlCalculation,'Visible','off')
        set(handles.pnlCameraSettings,'Visible','off')
        set(handles.pnlOtherSettings,'Visible','off')
    else
        set(handles.pnlContinuous,'Visible','off')
        set(handles.tglStartPause,'Visible','off')
        set(handles.pnlImageSettings,'Visible','on')
        set(handles.pnlCalculation,'Visible','on')
        set(handles.pnlCameraSettings,'Visible','on')
        set(handles.pnlOtherSettings,'Visible','on')
        guidata(hObject,handles);
    end
    guidata(hObject,handles);
end

% Executes on button press in tglStartPause.
function handles = tglStartPause_Callback(hObject, ~, handles)
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
    
    while get(hObject,'Value')
        % Interupt so that plots show up on the axes
        pause(0.01)

        % Sets the last image to be used for removing static objects
        if isfield(handles,'imgRaw')
            handles.imgCompare = handles.imgRaw;
            if get(handles.cbCrop,'Value')
                handles.imgCompareCropped = handles.imgRawCropped;
            end
        end
        
        % Get image capture parameters
        dblExposure = getBoxVal(handles.txtExposure);
        dblGain = getBoxVal(handles.txtGain);
        dblGamma = getBoxVal(handles.txtGamma);

        handles.imgRaw = automated_frame_capture(dblExposure, dblGain, dblGamma);

        if handles.imgRaw == -1
            errordlg('Error while retrieving picture from camera','','modal')
            return;
        end
        
%         % Simulated continuous capture, used for troubleshooting without a
%         % camera
%         handles.imgRaw = imread(['D:\Users\Kepstrum\Desktop\Projects\152\VisionSensorConfig\Saved Data\2015_7_1_14_33_10.69\' num2str(mod(handles.Counter-1,220)+1) 'Raw.png']);
    
        % Set image to grayscale
        if size(handles.imgRaw,3) == 3
            handles.imgRaw = rgb2gray(handles.imgRaw);
        end
        % Change image to double and bring the range down to 0-1
        handles.imgRaw = double(handles.imgRaw);
        handles.imgRaw = handles.imgRaw ./ 255;
        
        % Refresh/update because next few lines pass in handles
        handles = cbCrop_Callback(handles.cbCrop, [], handles);
        handles = RefreshPlots(handles);
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
                imwrite(handles.imgRawCropped,[dirSave int2str(handles.Counter) 'RawCropped.png'],'png');
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
                                              handles.Stats.avgGperL(mod(handles.Counter-1,500)+1,2),...
                                              handles.Stats.localAvgGperL(mod(handles.Counter-1,500)+1,2));
            fclose(fidGperL);
        end
        
        % Save list of particle diameters used for the histogram
        if get(handles.cbSaveHist, 'Value')
            savVar = handles.Stats.Diameters{mod(handles.Counter-1,500)+1}; %#ok<NASGU>
            save([dirSave int2str(handles.Counter) 'Hist'], 'savVar');
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%% Save to csv for PLC to read
        bins = histc(handles.Stats.Diameters{mod(handles.Counter-1,500)+1}{3},0:0.1:3.5);
        if isempty(bins)
            bins = zeros(1,36);
        end
        formatSpec = '%d,';
        formatSpec = repmat(formatSpec,1,length(bins)-1);
        formatSpec = ['%d,%2.6f,' formatSpec '%d,%f\r\n']; %#ok<AGROW>
        fidPLC = fopen('C:\VisionSensor\MATLAB2PLC.csv','w');
        fprintf(fidPLC,formatSpec,handles.Counter,handles.Stats.GperL{mod(handles.Counter-1,500)+1}(2),bins,getBoxVal(handles.txtFrameVol));
        fclose(fidPLC);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
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
    
%     axes(handles.axeRaw);
    imshow(imgRaw,'Parent',handles.axeRaw);
%     axes(handles.axeProcessed);
    imshow(imgProcessed,'Parent',handles.axeProcessed);
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

    % Load settings if it exists
    if isfield(handles,'Load')
        handles = LoadSettings(handles);
    end
    
    % handles.Param and ParamC used to be meant for exporting visionsensor
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

% Refresh plots
function handles = RefreshPlots(handles)
    if get(handles.tglStartPause,'Value')
        if isfield(handles,'imgRaw')
            if get(handles.cbCrop,'Value') && isfield(handles,'imgRawCropped')
                handles = plotContinuous(handles.imgRaw, handles, handles.imgRawCropped);
            else
                handles = plotContinuous(handles.imgRaw, handles);
            end
        end
    else
        if get(handles.cbCrop,'Value')
            if isfield(handles,'imgRawCropped')
                handles = plotSample(handles.imgRawCropped, handles);
            end
        else
            if isfield(handles,'imgRaw')
                handles = plotSample(handles.imgRaw, handles);
            end
        end

        % Set function handle of this function to plots (children)
        set(get(handles.axeSampleImg,'Children'),'ButtonDownFcn',@axeSampleImg_ButtonDownFcn);
    end
end

function handles = LoadSettings(handles)
    Textboxes = fieldnames(handles.Load.Textbox);
    for i = 1:length(Textboxes)
        set(eval(['handles.' Textboxes{i}]),'String', ...
            eval(['handles.Load.Textbox.' Textboxes{i}]));
    end
    Checkboxes = fieldnames(handles.Load.Checkbox);
    for i = 1:length(Checkboxes)
        set(eval(['handles.' Checkboxes{i}]),'Value', ...
            eval(['handles.Load.Checkbox.' Checkboxes{i}]));
    end
    Sliders = fieldnames(handles.Load.Slider);
    for i = 1:length(Sliders)
        set(eval(['handles.' Sliders{i}]),'Value', ...
            eval(['handles.Load.Slider.' Sliders{i}]));
    end
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
