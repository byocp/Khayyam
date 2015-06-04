function output = load_config(matlab_config_path)
%% Config
%% Format string for each line of text:
%   column1: text (%s)
%	column2: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%f%[^\n\r]';

%% Open the text file.
fileID = fopen(matlab_config_path, 'r');

%% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, 'Delimiter', ',',  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Create output variable
dataArray(2) = cellfun(@(x) num2cell(x), dataArray(2), 'UniformOutput', false);
imported_data = [dataArray{1:end-1}];

for ind = 1 : length(imported_data(:,1))
    config.(imported_data{ind,1}) = imported_data{ind,2};
end
%% Clear temporary variables
clearvars filename formatSpec fileID dataArray ans;

output = config;
end

