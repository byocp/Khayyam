% Plots the sample image and the center point
function handles = plotSample(imgShow, handles)
    % plotSample
    %
    % Plots the image either from the camera or file in the sample image
    % axis.  It will also apply any image processing options if they are
    % selected.
    %
    %
    % Syntax
    %
    % handles = plotSample(imgShow,handles)
    %
    %
    % Description
    %
    % handles = plotSample(imgShow,handles) takes the image, imgShow,
    % passed in and plots it into the sample image axis.  Any selected
    % image processing options will be applied to the image.

    [imgMinParticle,imgMaxParticle] = MinMaxParticleSample(handles);
    
    imgShow = ApplyImageProcessing(handles,imgShow,imgMinParticle,imgMaxParticle);
    handles.imgProcessed = imgShow;
    
    axes(handles.axeSampleImg);
    cla;
    hold on;

    [minMaxExample,sizMin,sizMax,yOffset1,yOffset2] = MinMaxExampleImage(imgShow,imgMinParticle,imgMaxParticle);

    imshow(imgShow);
    imshow(minMaxExample);

    % Add the label next to the min and max particle examples
    text(sizMin(2)+10,sizMin(1)/2+yOffset1, ...
         'Min Particle Size', ...
         'Color',[1 0 0]);
    text(sizMax(2)+10,sizMax(1)/2+yOffset2, ...
         'Max Particle Size', ...
         'Color',[1 0 0]);

    % Adds the center point on the plot
    intCenterX = getBoxVal(handles.txtCenterX);
    intCenterY = getBoxVal(handles.txtCenterY);
    handles.hScatter = scatter(intCenterX,intCenterY,'*r');
    intTextY = intCenterY - size(imgShow,1)/20;
    handles.hText = text(intCenterX,intTextY,'Frame Center',...
                         'HorizontalAlignment','center',...
                         'Color',[1 0 0]);
end