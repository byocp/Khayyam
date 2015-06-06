function output = compute_concentration(number, volume, config)
%% Compute contamination
number_total = sum(number);
volume_total_cubic_millimeter = sum(volume);

contam_level_num_per_sample = round(number_total / config.moving_average_length);
contam_level_num_per_liter  = round((number_total / config.moving_average_length) * 10^6 / config.volume_of_sample_cubic_millimeter);
contam_level_gram_per_liter = (volume_total_cubic_millimeter / config.moving_average_length) * config.density_of_material_kg_per_cubic_meter / config.volume_of_sample_cubic_millimeter ;
contam_level_gram_per_liter = str2num(num2str(contam_level_gram_per_liter,2));

output = [contam_level_num_per_sample, contam_level_num_per_liter, contam_level_gram_per_liter];