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
% Main function that calls the particle_counter function, MAY be
% unnecessary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = main(strFullPath, plotVal, imgVidFrame)
    % Load configuration file
    strConfigPath = [getenv('USERPROFILE') '\Desktop\conf.txt'];    % Assumed to be on Desktop
    sctConfig = load_config(strConfigPath);

    % Initialization
    number     = zeros(1, sctConfig.moving_average_length);
    centroid   = [];
    area       = [];
    minor_axis = [];
    major_axis = [];
    equiv_diam = [];
    volume     = [];

    idx = 1;
    while (idx <= sctConfig.moving_average_length)
        % Input
        switch strFullPath
            case ''
                raw_image = automated_frame_capture(sctConfig.lucam_snapshot_exposure, sctConfig.lucam_gain);
            case 'Video'
                raw_image = imgVidFrame;
            otherwise
                raw_image = imread(strFullPath);
        end
        
        % Check if raw_image is an image (uint8 might not work?)
        if ~isa(raw_image,'uint8')
            % Biye: Is this necessary?
            number     = -1;
            area       = 0;
            minor_axis = 0;
            major_axis = 0;
            equiv_diam = 0;
            [SV] = memory;
            memUs = SV.MemUsedMATLAB / 1000000;
            memAv = SV.MemAvailableAllArrays / 1000000; 
            contam_level_gram_per_liter = 0;
            contam_level_num_per_liter  = 0;
            return; 
        end

        % Initialization
        output            = image_initialization(raw_image, sctConfig);
        raw_image         = output.raw_image;
        cropped_raw_image = output.cropped_raw_image;
        sctConfig            = output.config;
        % Particle Counter
        calculation  = particle_counter({cropped_raw_image, sctConfig});

        % Results
        if ~isempty(calculation.centroid)
            number(idx) = calculation.number;
            centroid    = [centroid, calculation.centroid];
            area        = [area, calculation.area];
            minor_axis  = [minor_axis, calculation.minorAxis];
            major_axis  = [major_axis, calculation.majorAxis];
            equiv_diam  = [equiv_diam, calculation.equivDiameter];
            volume      = [volume, calculation.volume];
        else
            number(idx) = 0;
            centroid    = centroid ;
            area        = area ;
            minor_axis  = minor_axis ;
            major_axis  = major_axis ;
            equiv_diam  = equiv_diam ;
            volume      = volume;
        end

        if strcmp(plotVal, 'true')
            plotImage({strFullPath, cropped_raw_image, calculation.centroid});
        end
        clear calculation
        % memory-usage monitoring
        if isunix
            memUs = 0;
            memAv = 0;
        else
            [SV] = memory;
            memUs = SV.MemUsedMATLAB / 1000000;
            memAv = SV.MemAvailableAllArrays / 1000000;
        end
        idx = idx + 1;
    end

    out = compute_concentration(number, volume, sctConfig);
    contam_level_num_per_sample = out(1);
    contam_level_num_per_liter  = out(2);
    contam_level_gram_per_liter = out(3);

    % C# GUI
    %output = [area, minor_axis, major_axis, equiv_diam, contam_level_num_per_sample, ...
    %          memAv, memUs, contam_level_gram_per_liter, contam_level_num_per_liter];
    % MATLAB GUI
    output.area       = area;
    output.minor_axis = minor_axis;
    output.major_axis = major_axis;
    output.equiv_diam = equiv_diam;
    output.centroid   = centroid; 
    output.memAv      = memAv;
    output.memUs      = memUs;
    output.config     = sctConfig;
    output.number     = number;
    output.raw_image         = raw_image;
    output.cropped_raw_image           = cropped_raw_image;
    output.contam_level_num_per_sample = contam_level_num_per_sample;
    output.contam_level_gram_per_liter = contam_level_gram_per_liter;
    output.contam_level_num_per_liter  = contam_level_num_per_liter;

    clearvars -except output input_image_type particle_diameter_type parameter_over_time
end

function plotImage(vargin)
    global  input_image_type particle_diameter_type parameter_over_time
    file_name = vargin{1};
    raw_image = vargin{2};
    centroid  = vargin{3};

    scale_down_ratio = 0.25;
    f = figure('visible', 'off');
    cla reset;
    imshow(imresize(raw_image, scale_down_ratio),[],'Border','tight');
    print (f, '-r80', '-djpeg', strcat(file_name, '_raw.jpeg'));
    saveas(f, strcat(file_name, '_raw.jpeg'))

    %imshow(imresize(initImage,ratioScaleDown),[], 'Parent', handles.axes7);
    for  particle_id = 0 : size(centroid, 2) - 1
        hold on
        % scatter((floor( config.crop_coordinates_xmin / 2048 * size(raw_image,1) ) + centroid(particle_id+1, 1)) * scale_down_ratio, ...
        %        (floor( config.crop_coordinates_ymin / 2448 * size(raw_image,2) ) + centroid(particle_id+1, 2)) * scale_down_ratio, 15, 'r*');
        scatter(centroid(1, particle_id+1) * scale_down_ratio, centroid(2, particle_id+1) * scale_down_ratio, 100, 'r*');
    end
    print (f, '-r80', '-djpeg', strcat(file_name,'_proc.jpeg'));
    saveas(f, strcat(file_name, '_proc.jpeg'));


    clearvars -except input_image_type particle_diameter_type parameter_over_time
end
