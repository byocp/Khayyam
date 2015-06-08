function output = digital_filtering(raw_image, config)
%% Enhancement
if config.enhance_image_adapthisteq 
    enhanced_image = adapthisteq(raw_image);
elseif config.enhance_image_imadjust
    enhanced_image = imadjust(raw_image, [0.05 0.1], [0.25 0.5]);
elseif config.enhance_image_decorrstretch
    enhanced_image = decorrstretch(raw_image);
else
    enhanced_image = raw_image;
end
%% Gaussian Filter
% Using a gaussian linear filter to smoothen the image in gray-scale
if config.gaussian_filter
     boxKernel    = fspecial('gaussian', [5, 5], 0.9);
     blurred_image = conv2(double(enhanced_image), double(boxKernel), 'same');
end
%% Converts a grayscale image to a binary image
% THIS STAGE IS VERY IMPORTANT
threshold_image_stage1 = graythresh(enhanced_image);
image_black_and_white = im2bw(enhanced_image, threshold_image_stage1);

if config.boost
    boosted_image_black_and_white = digital_filtering_boost(image_black_and_white, config);
    image_black_and_white = boosted_image_black_and_white;
end
%% Invert
inverted_image = ~image_black_and_white;

%**************************************************************************
% Remove small objects from binary image
min_pixel_size = round(3.14 * (config.min_particle_diameter_millimeter / 2) ^2 / (config.pixel_area_squared_millimeter));
image_removed_small_objects = bwareaopen(inverted_image, min_pixel_size);

%**************************************************************************
% Objects touching image borders removed
image_removed_at_borders = imclearborder(image_removed_small_objects);

if config.boost 
    boosted_image_removed_at_borders = digital_filtering_boost(~image_removed_at_borders, config);
    image_removed_at_borders = ~boosted_image_removed_at_borders;
end

image_ready = image_removed_at_borders;

%% Measure properties of image regions
% Particles must be shown as hole at this stage.
% [B, L, N, A] = bwboundaries(x);
[B, ~, ~, ~] = bwboundaries(image_ready,'noholes'); %much faster

%% Plot
if config.investigation_process
    fig_stages_of_process = figure;
    set(fig_stages_of_process,'name','Procedure','numbertitle','off')
    
    subplot(3, 3, 1)
    imshow(raw_image)
    title('Raw')
    
    subplot(3, 3, 2)
    imshow(enhanced_image)
    title('Enhanced')
    
    %subplot(3, 3, 3)
    %imshow(blurred_image)
    %title('Gaussian');
    
    subplot(3, 3, 4)
    imshow(image_black_and_white)
    title('Binary');
    
    subplot(3, 3, 5)
    imshow(inverted_image)
    title('Inversion');
    
    subplot(3, 3, 6)
    imshow(image_removed_small_objects)
    title('Remove small objects')
    
    % Remove particles which are located next to the image borders
    subplot(3, 3, 7)
    imshow(image_removed_at_borders)
    title('Remove peripheral objects')
    
    subplot(3, 3, 8)
    imshow(image_ready)
    title('Image-Ready')
    for particle_id = 1 : length(B)
        boundary = B{particle_id};
        hold on
        plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 0.2)
    end
    
    output.fig_stages_of_process = fig_stages_of_process;
end

output.processed_image       = image_ready;
output.enhanced_image        = enhanced_image;
output.image_black_and_white = image_black_and_white;
output.boundaries            = B;