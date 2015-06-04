function output = is_this_bubble(image, particle_pixels, config)

raw_intensity = [];
for i = 1 : length(particle_pixels)
    raw_intensity(i) = image(particle_pixels(i,1), particle_pixels(i,2));
end

bubble_metric = mean(double(raw_intensity)) / max(double(image(:))); 
                % std(seriesData{k+1}); 
                % mean(seriesData{k+1})-median(seriesData{k+1}); 
                % sum(seriesData{k+1}); 
                
output = ~(bubble_metric > config.bubble_detection_threshold);
