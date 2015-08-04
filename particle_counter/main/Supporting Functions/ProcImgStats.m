% Get processed image statistics
function handles = ProcImgStats(handles)
    % ProcImgStats
    %
    % This function gets the statistics (particle diameters) of the
    % processed image
    %
    %
    % Syntax
    %
    % handles = ProcImgStats(handles)
    %
    %
    % Description
    %
    % handles = ProcImgStats(handles) runs the function regionprops on the 
    % processed image stored in handles.imgProcessed.  This function 
    % assumes that the processed image stored is ready to be used in the 
    % regionprops function.  For this project, this function returns the
    % grams/Litre calculation and an array of equivalent diameters based on
    % the objects found.  Both are stored in handles.

    imgProcessed = ~handles.imgProcessed;
    RProp = regionprops(imgProcessed, 'EquivDiameter');
    
    % Calculating g/L
    intSumVol = 0;
    arrDiam = [];
    for i = 1:length(RProp)
        dblDiam = RProp(i).EquivDiameter * getBoxVal(handles.txtPixelLen);
        intSumVol = intSumVol + 4/3*pi*(dblDiam/2)^3;
        
        arrDiam(end+1) = dblDiam; %#ok<AGROW>
    end
    
    % GperL is a cell structure, where each cell contains the index and the
    % g/L value in an array
    handles.Stats.GperL{mod(handles.Counter-1,500)+1} = ...
            [handles.Counter,intSumVol / 10^3 * ...
            getBoxVal(handles.txtDensity) / ...
            (getBoxVal(handles.txtFrameVol) / 10^3 / 1000)];
    
    % Diameters is a cell structure, where each cell contains the index,
    % system time, and the full list of diameters in a cell format. The
    % diameters themselves are stored in an array
    intTime = clock;
    strTime = sprintf('%u_%u_%u_%u_%u_%2.2f',intTime);
    handles.Stats.Diameters{mod(handles.Counter-1,500)+1} = ...
            {handles.Counter,strTime,arrDiam};
end