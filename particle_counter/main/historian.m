function historian(vargin)
% Archive
config                = vargin{1};
raw_image_cropped     = vargin{2};
report                = vargin{3};
fig_stages_of_process = vargin{4};
file_path             = vargin{5};
file_name             = vargin{6};
%% Stages of process
if config.investigation_process && ~isempty(file_name)
%     saveas(fig_stages_of_process, [file_path, strcat(file_name, '_Procedure','.jpg')])
end
%% Raw Image (bw) + Particles (-r*)
if config.investigation_final && ~isempty(file_name)
    f = figure;
    imshow(raw_image_cropped);
    for  k = 0 : size(report.filtered.centroid, 2) - 1
        hold on
        scatter(report.filtered.centroid(1, k+1), report.filtered.centroid(2, k+1), 5, 'r*');
        text(report.filtered.centroid(1, k+1), report.filtered.centroid(2, k+1), num2str(k+1), 'Color', 'k','FontSize', 14)
    end
    set(f, 'name', strcat(file_name, '_Processed'), 'numbertitle', 'off');
%     saveas(f, [file_path, strcat(file_name,'_Processed','.jpg')])
end
%% Report (Excel)
if config.investigation_excel_report && ~isempty(file_name)
    output(:,1) = report.identifier;
    output(:,2) = report.centroid(1, :);
    output(:,3) = report.centroid(2, :);
    output(:,4) = report.area;
    output(:,5) = report.majorAxis;
    output(:,6) = report.minorAxis;
    %'VariableNames': {'Identifier', Centroid,'Area','MajorAxisLength','MinorAxisLength'};
    xlswrite([file_path,strcat(file_name,'.xls')], output); 
end

end

