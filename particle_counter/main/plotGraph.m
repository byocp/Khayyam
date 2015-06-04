function plotGraph(filename)
    xAxis = [];
    yAxis = [];
    spaced_times = [];
    
    % filename = '20150428';
    
    % Copy file to use
    copyfile(strcat('C:\Users\Minghua\Desktop\Contamination-data\',filename,'.txt'), strcat('C:\Users\Minghua\Desktop\Contamination-data\',filename,'_Matlab.txt'));
    %Create fileID
    fileID = fopen(strcat('C:\Users\Minghua\Desktop\Contamination-data\',filename,'_Matlab.txt'));
    
    %Read line by line of file
    tline = fgets(fileID);
    while ischar(tline)
        %Split String by ","
        splitString = strsplit(tline,',');
        %If "Grams_per_L" is found in the second element, then populate arrays
        if (strcmp(splitString(1),'Grams_per_L') == 1)
           xAxis = [xAxis;splitString(2)];
           yAxis = [yAxis;str2double(splitString(3))];
        end
        tline = fgets(fileID);
    end
    
    % Delete File
    delete(strcat('C:\Users\Minghua\Desktop\Contamination-data\',filename,'_Matlab.txt'));
  
    % Get Size for plotting
    x = 1:size(xAxis,1);

    % Plot 
    plotgrph = figure('visible','off');
    axes1 = axes('Parent',plotgrph);
    hold(axes1, 'all');
    plot(x, yAxis);
    set(gca, 'XLim', [1 size(xAxis,1)]);
    
    xTickLabel = get(gca,'xticklabel');
    %Iterate over all ticklabels
    for n = 1 : length(xTickLabel)
       ticks = str2num(xTickLabel(n,:));
       %For the 0'th element, 
       if (round(ticks) == 0)
           spaced_times = [spaced_times;xAxis(round(ticks) + 1)];
       else
           spaced_times = [spaced_times;xAxis(round(ticks))]; 
       end
    end
    
    xlabel('Time')
    ylabel('Grams per L')
    set(gca,'XTickLabel',spaced_times)

    saveas(plotgrph,strcat(filename,'.jpg'));
    
    clear all
end