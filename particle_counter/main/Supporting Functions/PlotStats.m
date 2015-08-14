% Plot image statistics
function handles = PlotStats(varargin)
    % PlotStats
    %
    % Plots the g/L and histogram
    %
    %
    % Syntax
    %
    % handles = PlotStats(varargin)
    %
    %
    % Description
    %
    % handles = PlotStats(varargin) plots the grams/Litre plot and
    % histogram in the GUI using values stored in handles.  This function
    % is also used when reviewing old data points.

    handles = varargin{1};
    
    % g/L
    if nargin == 1
        arrGperL = handles.Stats.GperL;
        for i = 1:length(arrGperL)
            intGperL(i,1) = arrGperL{i}(1); %#ok<AGROW>
            intGperL(i,2) = arrGperL{i}(2); %#ok<AGROW>
        end
        
        plot(intGperL(:,1),intGperL(:,2),'Parent',handles.axeGperL);
        
        % Plots the average of the g/L so far as a red line
        hold(handles.axeGperL,'on')
        plot(intGperL(:,1),ones(i,1)*mean(intGperL(:,2)),'r','Parent',handles.axeGperL);
        plot(intGperL(:,1),ones(i,1)*mean(intGperL(max(end-20,1):end,2)),'g','Parent',handles.axeGperL);
        hold(handles.axeGperL,'off')

        % Only shows the 10 most recent results (use slider to see history)
        xlabel(handles.axeGperL,'Image #');
        ylabel(handles.axeGperL,'Grams/Liter');
        xlim(handles.axeGperL,[handles.Counter - 10, handles.Counter]);
        handles.Stats.avgGperL(mod(handles.Counter-1,500)+1,:) = [handles.Counter,mean(intGperL(:,2))];
        if handles.Counter > 500
            index = mod(handles.Counter-1,500)+1;
            if index < 20
                handles.Stats.localAvgGperL(index,:) = [handles.Counter,mean([intGperL(500-(19-index):500,2);intGperL(1:index,2)])];
            else
                handles.Stats.localAvgGperL(index,:) = [handles.Counter,mean(intGperL(index-19:index,2))];
            end
        else
            handles.Stats.localAvgGperL(handles.Counter,:) = [handles.Counter,mean(intGperL(max(end-19,1):end,2))];
        end
    end
    
    % Histogram
    
    % Histogram bins are determined by the min and max diameteres set in
    % their respective textboxes and each bin size will always be 0.1. If
    % max is not exactly 0.1*n away from min, then the closest 0.1*n value
    % below max will be the biggest bin size cutoff
    dblMinDiam = getBoxVal(handles.txtMinDiam);
    dblMaxDiam = getBoxVal(handles.txtMaxDiam);
    if nargin == 1
        bins = histc(handles.Stats.Diameters{mod(handles.Counter-1,500)+1}{3},dblMinDiam:0.1:dblMaxDiam);
        set(handles.lblTimeStamp,'String',handles.Stats.Diameters{mod(handles.Counter-1,500)+1}{2});
    else
        bins = histc(varargin{2}{3},dblMinDiam:0.1:dblMaxDiam);
        set(handles.lblTimeStamp,'String',varargin{2}{2});
    end
    if isempty(bins)
        bins = zeros(length(dblMinDiam:0.1:dblMaxDiam),1);
    end
    bar(handles.axeHist,dblMinDiam:0.1:dblMaxDiam,bins);
    xlabel(handles.axeHist,'Particle Diameter [mm]');
    ylabel(handles.axeHist,'Count');
    xlim(handles.axeHist,[dblMinDiam, dblMaxDiam]);
    % Since the histogram takes a bit of time to process, it will lag
    % behind the other plots. Maybe sync the plotting functions so that
    % they all appear together (aka plot histogram first?)
end