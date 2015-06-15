%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script is made by Kepstrum Inc. Canada
% All rights reserved
% Author: Pedram Ataee
% Date: ??
% Vers: 1.0
% 
% Last edited by: Biye Chen
% Last edited date: Jun. 15, 2015
%
% Description:
% Loads the configuration file into MATLAB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sctConfig = load_config(strConfigPath)
    % Config
    % Format string for each line of text:
    %   column1: text (%s)
    %	column2: double (%f)
    % For more information, see the TEXTSCAN documentation.
    sctConfig = struct;

    % Open the text file.
    fidConfig = fopen(strConfigPath, 'r');
    
    % Check if file exists
    if fidConfig == -1
        btnYesNo = questdlg(['The configuration file does not exist, ' ...
                             'Would you like to browse to the file?'], ...
                             'Configuration Not Found','Yes', 'No', 'Yes');
        
        % Browse for conf.txt
        switch btnYesNo
            case 'Yes'
                [strFileName, strPath] = uigetfile({'*.txt', 'Config File'},...
                                                    'Select Config File');
                
                % Copy conf.txt to expected path
                btnYesNo2 = questdlg('Would you like to copy this to the default directory (Desktop)?', ...
                                     'Copy Config','Yes', 'No', 'Yes');
                switch btnYesNo2
                    case 'Yes'
                        copyfile([strPath strFileName],strConfigPath);
                        fidConfig = fopen(strConfigPath, 'r');
                    otherwise
                        fidConfig = fopen([strPath strFileName], 'r');
                end
            otherwise
                clear all
                close all
                clc
                errordlg('No Configuration file found!');
        end
    end

    % Read columns of data according to format string.
    celConfig = textscan(fidConfig, '%s%f', 'Delimiter', ',', 'ReturnOnError', false);

    % Close the text file.
    fclose(fidConfig);

    % Create output variable
    for i = 1:length(celConfig{1})
        sctConfig = setfield(sctConfig,celConfig{1,1}{i},celConfig{1,2}(i)); %#ok<SFLD>
    end
    
    % Clear temporary variables
    clearvars fidConfig celConfig strConfigPath btnYes* ans;
end
