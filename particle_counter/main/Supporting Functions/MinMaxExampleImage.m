function [minMaxExample,sizMin,sizMax,yOffset1,yOffset2] = MinMaxExampleImage(imgShow,imgMinParticle,imgMaxParticle)
    % MinMaxExampleImage
    %
    % Add the min and max particle disks into a sample image.
    %
    %
    % Syntax
    %
    % minMaxExample = MinMaxExampleImage(imgMinParticle,imgMaxParticle)
    %
    %
    % Description
    %
    % minMaxExample = MinMaxExampleImage(imgMinParticle,imgMaxParticle)
    % takes the imgMinParticle and imgMaxParticle and generates a white
    % background box containing both the min and max particle disks based
    % on the size of the max particle.  imgShow is used for size reference.
    % minMaxExample is the image output, other outputs are used for
    % reference in plotSample.
    
    sizMin = size(imgMinParticle);
    sizMax = size(imgMaxParticle);
    yOffset1 = floor(size(imgShow,1)/20);
    yOffset2 = yOffset1 + sizMin(1) + floor(size(imgShow,1)/20);
    minMaxExample = ones(yOffset2,sizMax(2));
    minMaxExample(yOffset1:sizMin(1)+yOffset1-1, 1:sizMin(2)) = 1-imgMinParticle;
    minMaxExample(yOffset2:sizMax(1)+yOffset2-1, 1:sizMax(2)) = 1-imgMaxParticle;
end