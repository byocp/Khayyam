function [area, minor_axis, major_axis, equiv_diam, contam_level_num_per_sample, ...
          memAv, memUs, contam_level_gram_per_liter, contam_level_num_per_liter] = main(file_name, plotVal)
%% Load config
config = load_config('C:/Users/Minghua/Desktop/conf.txt');

%% Initialization
number     = zeros(1, config.moving_average_length);
centroid   = [];
area       = [];
minor_axis = [];
major_axis = [];
equiv_diam = [];
volume     = [];

idx  = 1;
while (idx <= config.moving_average_length)
    %% Input
    % Test
    %raw_image = importdata(strcat('C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\samples\test_bench','.jpg'));

    % Original
    raw_image = automated_frame_capture(config.lucam_snapshot_exposure, config.lucam_gain);
    
    %% Camera Connection
    if raw_image == -1
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
    
    %% Initialization
    output = image_initialization(raw_image, config);   
    cropped_raw_image = output.cropped_raw_image;
    config = output.config;

    %% Particle Counter
    calculation  = particle_counter({cropped_raw_image, config});
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
        plotImage({file_name, cropped_raw_image, calculation.centroid});
    end
    clear calculation
    %% memory-usage monitoring
    [SV] = memory;
    memUs = SV.MemUsedMATLAB / 1000000;
    memAv = SV.MemAvailableAllArrays / 1000000;
    clear raw_image cropped_raw_image

    idx = idx + 1;
end
%% Output
number_total = sum(number);
volume_total_cubic_millimeter = sum(volume);
% Contamination Level
contam_level_num_per_sample = round(number_total / config.moving_average_length);
contam_level_num_per_liter  = round((number_total / config.moving_average_length) * 10^6 / config.volume_of_sample_cubic_millimeter);
contam_level_gram_per_liter = (volume_total_cubic_millimeter / config.moving_average_length) * config.density_of_material_kg_per_cubic_meter / config.volume_of_sample_cubic_millimeter ;
contam_level_gram_per_liter = str2num(num2str(contam_level_gram_per_liter,2));

end

function plotImage(vargin)
file_name = vargin{1};
raw_image = vargin{2};
centroid  = vargin{3};

scale_down_ratio = 0.25;
f = figure('visible', 'off');
cla reset;
imshow(imresize(raw_image, scale_down_ratio),[],'Border','tight');
print (f, '-r80', '-djpeg', strcat(file_name, '_raw.jpeg'));
saveas(f, strcat(file_name, '_raw.jpeg'));

%imshow(imresize(initImage,ratioScaleDown),[], 'Parent', handles.axes7);
for  particle_id = 0 : size(centroid, 2) - 1
    hold on
    % scatter((floor( config.crop_coordinates_xmin / 2048 * size(raw_image,1) ) + centroid(particle_id+1, 1)) * scale_down_ratio, ...
    %        (floor( config.crop_coordinates_ymin / 2448 * size(raw_image,2) ) + centroid(particle_id+1, 2)) * scale_down_ratio, 15, 'r*');
    scatter(centroid(1, particle_id+1) * scale_down_ratio, centroid(2, particle_id+1) * scale_down_ratio, 100, 'r*');
end
print (f, '-r80', '-djpeg', strcat(file_name,'_proc.jpeg'));
saveas(f, strcat(file_name, '_proc.jpeg'));

clear all;
close all;
end
