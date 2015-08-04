function [imgMinParticle,imgMaxParticle] = MinMaxParticleSample(handles)
    % MinMaxParticleSample
    %
    % Create the sample of small and big particles according to the current
    % min/max diameters and pixel length settings
    %
    %
    % Syntax
    %
    % [imgMinParticle,imgMaxParticle] = MinMaxParticleSample(handles)
    %
    %
    % Description
    %
    % [imgMinParticle,imgMaxParticle] = MinMaxParticleSample(handles)
    % generates a disk the size of the min (imgMinParticle) and max
    % (imgMaxParticle) particle based on the current min/max diameters and 
    % pixel length settings.
    
    imgMinParticle = fspecial('disk',getBoxVal(handles.txtMinDiam) / ...
                                     getBoxVal(handles.txtPixelLen)/2);
    imgMinParticle(imgMinParticle>0) = 0.5;
    imgMaxParticle = fspecial('disk',getBoxVal(handles.txtMaxDiam) / ...
                                     getBoxVal(handles.txtPixelLen)/2);
    imgMaxParticle(imgMaxParticle>0) = 0.5;
end