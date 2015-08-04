% Plots the sample image and the center point
function handles = plotContinuous(imgShow, handles, imgShowCropped)
    % plotContinuous
    %
    % Plots the raw image from the camera and the processed image in the
    % continuous capture image frames.
    %
    %
    % Syntax
    %
    % handles = plotContinuous(imgShow, handles)
    %
    %
    % Description
    %
    % handles = plotContinuous(imgShow, handles) takes the image, imgShow,
    % passed in and plots it into the raw image axis.  Any selected
    % image processing options will be applied to the image and plotted to
    % the processed image axis.

    [imgMinParticle,imgMaxParticle] = MinMaxParticleSample(handles);
    
    imgRaw = imgShow;
    if exist('imgShowCropped','var')
        imgShow = ApplyImageProcessing(handles,imgShowCropped,imgMinParticle,imgMaxParticle);
    else
        imgShow = ApplyImageProcessing(handles,imgShow,imgMinParticle,imgMaxParticle);
    end
    handles.imgProcessed = imgShow;
    
    imshow(imgRaw,'Parent',handles.axeRaw);
    imshow(handles.imgProcessed,'Parent',handles.axeProcessed);
end