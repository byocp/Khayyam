function output = image_initialization(raw_image, config)
% This function applies several standard operation including rgb2gray,
% crop, and normalization on the raw_image for any future analysis
%% Import
% rgb2gray
if isstruct(raw_image)
    raw_image = raw_image.cdata;  
end    
if size(raw_image, 3) == 3
    raw_image_gray = double(rgb2gray(raw_image));
else
    raw_image_gray = raw_image;
end
%% Update config
x_center_window = 1227;
y_center_window = 935;

x_min_pixel = max(0, x_center_window - floor(config.half_of_width_millimeter  / config.pixel_length_millimeter));
y_min_pixel = max(0, y_center_window - floor(config.half_of_length_millimeter / config.pixel_length_millimeter));

image_width_pixel  = 2 * floor(config.half_of_width_millimeter  / config.pixel_length_millimeter);
image_length_pixel = 2 * floor(config.half_of_length_millimeter / config.pixel_length_millimeter);

depth_sample_millimeter  = 4;
length_sample_millimeter = image_length_pixel * config.pixel_length_millimeter;
width_sample_millimeter  = image_width_pixel  * config.pixel_length_millimeter;

config.volume_of_sample_cubic_millimeter = depth_sample_millimeter  * ...
                                           length_sample_millimeter * ...
                                           width_sample_millimeter;

config.coordinates_cropped_image = [x_min_pixel, y_min_pixel, ...
                                    image_width_pixel, image_length_pixel];

% crop
if config.crop_option == 1
    cropped_raw_image = imcrop(raw_image_gray, config.coordinates_cropped_image);
else
    cropped_raw_image = raw_image_gray;
end


%% Initialization
% normalization                                
% normalized_image = ( double(raw_image_gray) - double(min(raw_image_gray(:))) ) ./ ...
%                   ( double(max(raw_image_gray(:))) - double(min(raw_image_gray(:))) );              

normalized_image = double(cropped_raw_image / max(cropped_raw_image(:)));

%% Output
output.raw_image         = raw_image_gray;
output.cropped_raw_image = normalized_image;
output.config            = config;

end

