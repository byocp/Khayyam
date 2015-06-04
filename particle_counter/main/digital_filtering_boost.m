function output = digital_filtering_boost(image, config)
%**************************************************************************
% Removes isolated pixels (individual 1's that are surrounded by 0's).
image_removed_isolated_pixels = bwmorph(image, 'clean', Inf);

%**************************************************************************
% Removes spur pixels.
image_removed_spur_pixels = bwmorph(image_removed_isolated_pixels, 'spur', Inf);

%**************************************************************************
% Sets a pixel to 1 if five or more pixels in its 3-by-3 neighborhood are 1s; 
% otherwise, it sets the pixel to 0.
image_smooth = bwmorph(image_removed_spur_pixels, 'majority', Inf);

%**************************************************************************
% Removes H-connected pixels.
image_removed_Hconnected_pixels = bwmorph(image_smooth,'hbreak',Inf);

%**************************************************************************
% strel
% SE = strel('rectangle', [3 3]);
% image_strel = imerode(image_removed_Hconnected_pixels, SE);

if config.investigation_process 
    f=figure;
    subplot(2, 2, 1)
    imshow(image_removed_isolated_pixels)
    title('Op(clean): isolated pixels ');
    set(f, 'name', 'Op(clean)', 'numbertitle', 'off')
    
    subplot(2, 2, 2)
    imshow(image_removed_spur_pixels)
    title('Op(spur): spur pixels');
    set(f, 'name', 'Op(spur)', 'numbertitle', 'off')
    
    subplot(2, 2, 3)
    imshow(image_smooth)
    title('Op(majority): smooth');
    set(f, 'name', 'Op(majority)', 'numbertitle', 'off')
    
    subplot(2, 2, 4)
    imshow(image_removed_Hconnected_pixels)
    title('Op(hbreak): H-connected pixels');
    set(f, 'name', 'Op(hbreak)', 'numbertitle', 'off')
end

output = image_removed_Hconnected_pixels;
end
