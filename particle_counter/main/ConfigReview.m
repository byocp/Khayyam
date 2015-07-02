%% Notes


%% Main GUI Functions
% This section contains all the functions automatically generated when the
% GUI is created

function varargout = ConfigReview(varargin)
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

    % Last Modified by GUIDE v2.5 02-Jul-2015 15:37:03

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @ConfigReview_OpeningFcn, ...
                       'gui_OutputFcn',  @ConfigReview_OutputFcn, ...
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
        if ~isdir('ReviewErrorLog')
            mkdir('ReviewErrorLog')
        end
        logError = fopen('ReviewErrorLog\ERROR.txt','a');

        strErrorTime = datestr(now);
        fprintf(logError,['%-' int2str(length(strErrorTime)) 's\r\n'...
                          '%-' int2str(length(ERROR.message)) 's\r\n'...
                          ],strErrorTime,ERROR.message);
        strErrorTime = regexprep(strErrorTime,':','');
        stcMemory = memory; %#ok<NASGU>
        save(['ReviewErrorLog\ ' strErrorTime '.mat'],'ERROR','stcMemory');

        fclose(logError);
    end
end
% End initialization code - DO NOT EDIT

% --- Executes just before Config is made visible.
function ConfigReview_OpeningFcn(hObject, ~, handles, varargin)
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
    
    % Choose default command line output for Config
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes Config wait for user response (see UIRESUME)
    % uiwait(handles.hmiConfig);
end

% --- Outputs from this function are returned to the command line.
function varargout = ConfigReview_OutputFcn(hObject, ~, ~)
    % Biye's notes: This function is used if you need to output anything
    % from the HMI to the outside (for example if another function calls
    % this HMI). Currently not used since this function is standalone

    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = hObject;
        
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

%% Review

% Executes on button press in btnLoad.
function btnLoad_Callback(hObject, ~, handles) %#ok<DEFNU>
    strFolderPath = uigetdir;
    if strFolderPath > 0;
        % Load GperL
        fidGperL = fopen([strFolderPath '\GramsPerLiter.txt'],'r');
        
        % Remove header line
        strLine = fgetl(fidGperL); %#ok<NASGU>
        i = 1;
        while (1)
            strLine = fgetl(fidGperL);
            if ~ischar(strLine)
                break;
            end
            strGperL = textscan(strLine, '%s', 'Delimiter', ',');
            handles.Stats.GperL{i} = strGperL{1}(1:2);
            handles.Stats.GperL{i} = str2double(handles.Stats.GperL{i});
            handles.Stats.avgGperL(i) = str2double(strGperL{1}(3));
            handles.Stats.localAvgGperL(i) = str2double(strGperL{1}(4));
            i = i+1;
        end

        % Plot g/L
        axes(handles.axeGperL);

        [handles,intGperL] = PlotGperL(handles,[]);
    
        % Only shows the 10 most recent results (use slider to see history)
        intStart = intGperL(1,1);
        intEnd = intGperL(end,1);
        handles.intStart = intStart;
        handles.intEnd = intEnd;
        xlabel('Image #');
        ylabel('Grams/Liter');
        xlim([intEnd - 10, intEnd]);
        set(handles.txtXRangeLow,'String',intEnd-10);
        set(handles.txtXRangeHigh,'String',intEnd);
        dblYLim = get(handles.axeGperL,'YLim');
        set(handles.txtYRangeLow,'String',dblYLim(1));
        set(handles.txtYRangeHigh,'String',dblYLim(2));
        set(handles.sldHistorical,'Max',intEnd,'Min',intStart,'Value',intEnd);
        set(handles.btnReview,'Enable','on');
    else
        errordlg('Invalid folder path');
    end
    handles.dirSave = [strFolderPath '\'];
    
    guidata(hObject,handles);
end

% Executes on slider movement.
function sldHistorical_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Updates the range of the g/L plot to see past data
    intRange = str2double(get(handles.txtXRangeHigh,'String')) - ...
               str2double(get(handles.txtXRangeLow,'String')) + 1;
    
    axes(handles.axeGperL);
    intSlider = get(hObject,'Value');
    if (intSlider - intRange) > 0
        set(handles.txtXRangeLow,'String',intSlider - intRange + 1);
        set(handles.txtXRangeHigh,'String',intSlider);
        [handles,~] = PlotGperL(handles,intSlider);
        xlim([intSlider - intRange, intSlider]);
        handles = cbAutoScale_Callback(handles.cbAutoScale,[],handles);
    else
        set(handles.txtXRangeLow,'String',1);
        set(handles.txtXRangeHigh,'String',intRange);
        [handles,~] = PlotGperL(handles,intSlider);
        xlim([1, intRange]);
        handles = cbAutoScale_Callback(handles.cbAutoScale,[],handles);
    end
    dblYLim = get(handles.axeGperL,'YLim');
    set(handles.txtYRangeLow,'String',dblYLim(1));
    set(handles.txtYRangeHigh,'String',dblYLim(2));
    
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
    PlotHist(handles,stcHist);
    
    guidata(hObject,handles);
end

function txtXRangeLow_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Set the lower range of the g/L plot

    intMin = str2double(get(hObject,'String'));
    intMax = str2double(get(handles.txtXRangeHigh,'String'));
    
    if intMin >= intMax
        intMax = intMin + 10;
    end

    set(handles.sldHistorical,'Value',intMax);
    
    axes(handles.axeGperL);
    xlim([intMin intMax]);
    
    guidata(hObject,handles);
end

function txtXRangeHigh_Callback(hObject, ~, handles) %#ok<DEFNU>
    % Set the higher range of the g/L plot

    intMin = str2double(get(handles.txtXRangeLow,'String'));
    intMax = str2double(get(hObject,'String'));
    
    if intMax <= intMin
        intMin = intMax - 10;
    end

    set(handles.sldHistorical,'Value',intMax);

    axes(handles.axeGperL);
    xlim([intMin intMax]);
    
    guidata(hObject,handles);
end

function handles = txtYRangeLow_Callback(hObject, ~, handles)
    % Set the lower range of the g/L plot

    intMin = str2double(get(hObject,'String'));
    intMax = str2double(get(handles.txtYRangeHigh,'String'));
    
    if intMin >= intMax
        intMax = intMin + 1;
    end

    set(handles.cbAutoScale,'Value',0);
    
    axes(handles.axeGperL);
    ylim([intMin intMax]);
    
    guidata(hObject,handles);
end

function handles = txtYRangeHigh_Callback(hObject, ~, handles)
    % Set the higher range of the g/L plot

    intMin = str2double(get(handles.txtYRangeLow,'String'));
    intMax = str2double(get(hObject,'String'));
    
    if intMax <= intMin
        intMin = intMax - 1;
    end

    set(handles.cbAutoScale,'Value',0);

    axes(handles.axeGperL);
    ylim([intMin intMax]);
    
    guidata(hObject,handles);
end

% --- Executes on button press in cbAutoScale.
function handles = cbAutoScale_Callback(hObject, ~, handles) %#ok<DEFNU>
    if get(hObject,'Value')
        set(handles.axeGperL,'YLimMode','auto')
    else
        set(handles.axeGperL,'YLimMode','manual')
        handles = txtYRangeLow_Callback(handles.txtYRangeLow,[],handles);
        handles = txtYRangeHigh_Callback(handles.txtYRangeHigh,[],handles);
    end
    
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
    
    % Stats is where the particle counts are stored
    handles.Stats.GperL = {};
    handles.Stats.avgGperL = [];
    handles.Stats.localAvgGperL = [];
end

% Plot image statistics
function handles = PlotHist(varargin)
    % Plots the g/L and histogram

    handles = varargin{1};
    
    % Histogram
    axes(handles.axeHist);
    cla;
    
    % Histogram bins are determined by the min and max diameteres set in
    % their respective textboxes and each bin size will always be 0.1. If
    % max is not exactly 0.1*n away from min, then the closest 0.1*n value
    % below max will be the biggest bin size cutoff
    bins = histc(varargin{2}{3},0.1:0.1:3.5);
    set(handles.lblTimeStamp,'String',varargin{2}{2});
    
    if isempty(bins)
        bins = zeros(length(0.1:0.1:3.5),1);
    end
    bar(0.1:0.1:3.5,bins);
    xlabel('Particle Diameter [mm]');
    ylabel('Count');
    xlim([0.1, 3.5]);
    % Since the histogram takes a bit of time to process, it will lag
    % behind the other plots. Maybe sync the plotting functions so that
    % they all appear together (aka plot histogram first?)
end

function [handles,intGperL] = PlotGperL(handles,intSlider)
    arrGperL = handles.Stats.GperL;
    for i = 1:length(arrGperL)
        intGperL(i,1) = arrGperL{i}(1); %#ok<AGROW>
        intGperL(i,2) = arrGperL{i}(2); %#ok<AGROW>
    end
    plot(intGperL(:,1),intGperL(:,2));
    
    % Plots the average of the g/L so far as a red line
    hold on
    if isfield(handles,'intEnd')
        if intSlider > handles.intEnd
            intSlider = handles.intEnd;
        end
        index = round(intSlider) - handles.intStart + 1;
        plot(intGperL(:,1),ones(i,1)*handles.Stats.avgGperL(index),'r');
        plot(intGperL(:,1),ones(i,1)*handles.Stats.localAvgGperL(index),'g');
    else
        plot(intGperL(:,1),ones(i,1)*handles.Stats.avgGperL(i),'r');
        plot(intGperL(:,1),ones(i,1)*handles.Stats.localAvgGperL(i),'g');
    end
    hold off
end

%% Not Used
% This section contains all the functions that are not used, but has been
% in the past and has potential to be used in the future

%% Work in progress
% This section contains all the functions that are being worked on. New
% functions are always added to the bottom of the file, so it helps
% organization
