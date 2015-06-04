function out = particle_counter(vargin)
%% Input
raw_image = vargin{1};
config    = vargin{2};
file_name = '';
file_path = '';
if length(vargin) == 4
    file_path = vargin{3};
    file_name = vargin{4};
end
%% Digital Filtering
output = digital_filtering(raw_image, config);
processed_image = output.processed_image;
boundaries      = output.boundaries;

if config.investigation_process
    fig_stages_of_process  = output.fig_stages_of_process;
else
    fig_stages_of_process = [];
end
clear output
%% Statitical Properties
% For more information, please check the following link:
% http://www.mathworks.com/help/images/ref/regionprops.html
stats = regionprops(processed_image, 'Area', 'Centroid', 'Perimeter', ...
    'MajorAxisLength', 'MinorAxisLength', 'EquivDiameter', ...
    'ConvexImage','EulerNumber');
%**************************************************************************
idx = 1;
roundness_metric = zeros(1, size(boundaries,1));
for k = 0 : size(boundaries,1) - 1
    stats(end-k).Area            = stats(end-k).Area            * config.pixel_area_squared_millimeter;
    stats(end-k).Perimeter       = stats(end-k).Perimeter       * config.pixel_length_millimeter;
    stats(end-k).MajorAxisLength = stats(end-k).MajorAxisLength * config.pixel_length_millimeter;
    stats(end-k).MinorAxisLength = stats(end-k).MinorAxisLength * config.pixel_length_millimeter;
    stats(end-k).EquivDiameter   = stats(end-k).EquivDiameter   * config.pixel_length_millimeter;
    %****************
    % Valid Particle
    %****************
    roundness_metric(k+1) = 4 * pi * stats(end-k).Area / stats(end-k).Perimeter ^ 2;
    
    acceptable_particle_roundness = roundness_metric(k+1) < config.threshold_circularity_1 && roundness_metric(k+1) > config.threshold_circularity_2;
    acceptable_particle_diameter  = stats(end-k).EquivDiameter > config.min_particle_diameter_millimeter && stats(end-k).EquivDiameter < config.max_particle_diameter_millimeter;
    is_particle_a_bubble          = 0; %is_this_bubble(raw_image, boundaries{k+1}, config);
    is_euler_number_valid         = 1; %(stats(end-k).EulerNumber ~= 0);
    
    is_this_a_valid_particle = acceptable_particle_roundness && ...
                               acceptable_particle_diameter && ...
                               ~is_particle_a_bubble && ...
                               is_euler_number_valid;
    %************
    % Properties
    %************
    statement.everything.centroid(:, k+1)     = stats(end-k).Centroid;
    statement.everything.area(k+1)            = stats(end-k).Area;
    statement.everything.perimeter(k+1)       = stats(end-k).Perimeter;
    statement.everything.majorAxis(k+1)       = stats(end-k).MajorAxisLength;
    statement.everything.minorAxis(k+1)       = stats(end-k).MinorAxisLength;
    statement.everything.equivDiameter(k+1)   = stats(end-k).EquivDiameter;
    statement.everything.roundnessMetric(k+1) = roundness_metric(k+1);
    %************
    % Selection
    %************
    if is_this_a_valid_particle
        statement.filtered.centroid(:, idx)     = statement.everything.centroid(:, k+1);
        statement.filtered.area(idx)            = statement.everything.area(k+1);
        statement.filtered.majorAxis(idx)       = statement.everything.majorAxis(k+1);
        statement.filtered.minorAxis(idx)       = statement.everything.minorAxis(k+1);
        statement.filtered.equivDiameter(idx)   = statement.everything.equivDiameter(k+1);
        statement.filtered.roundnessMetric(idx) = statement.everything.roundnessMetric(k+1);
        statement.filtered.identifier(idx)      = k+1;
        statement.filtered.volume(idx)          = (4/3) * pi * statement.filtered.equivDiameter(idx)^3;
        idx = idx + 1;
    end
end
%% Archive
if config.investigation_process || config.investigation_final || config.investigation_excel_report
    if exist('statement', 'var') 
        if isfield(statement, 'filtered')
            historian({config, raw_image, statement, fig_stages_of_process, file_path, file_name})
        end
    end
end
%% Output
out.centroid      = [];
out.majorAxis     = [];
out.minorAxis     = [];
out.area          = [];
out.equivDiameter = [];
out.identifier    = [];
out.volume        = [];
out.number        = [];
if exist('statement', 'var')
    if isfield(statement, 'filtered')
        out.centroid      = statement.filtered.centroid;
        out.majorAxis     = statement.filtered.majorAxis;
        out.minorAxis     = statement.filtered.minorAxis;
        out.area          = statement.filtered.area;
        out.equivDiameter = statement.filtered.equivDiameter;
        out.identifier    = statement.filtered.identifier;
        out.volume        = statement.filtered.volume;
        out.number        = size(out.centroid, 2);
    end
else
    out.centroid      = [];
    out.majorAxis     = [];
    out.minorAxis     = [];
    out.area          = [];
    out.equivDiameter = [];
    out.identifier    = [];
    out.volume        = [];
    out.number        = [];
end
end
%% compute perimeter in a simple way
% obtain (X,Y) boundary coordinates corresponding to label 'k'
% boundary = B{end-k};
% compute a simple estimate of the object's perimeter
% DIFF(X): for a matrix X, is the matrix of row differences,
% delta_sq = diff(boundary).^2;
% perimeter = sum(sqrt(sum(delta_sq,2)));
