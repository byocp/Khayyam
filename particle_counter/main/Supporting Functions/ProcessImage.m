% Image processing functions
function imgProcessed = ProcessImage(imgRaw, strProcess, varargin)
    % ProcessImage
    %
    % Executes Normalize, Binary, Out of Range, Remove Border, Roundness
    % Check, and Remove Static Objects.
    %
    %
    % Syntax
    %
    % imgProcessed = ProcessImage(imgRaw, strProcess, [Additional
    % parameters])
    %
    %
    % Description
    %
    % imgProcessed = ProcessImage(imgRaw, strProcess, [Additional
    % parameters]) runs an image processing procedure based on strProcess
    % on imgRaw.  The additional parameters are required for some
    % functions.
    %
    %
    % Examples
    %
    % To normalize the image:
    % imgProcessed = ProcessImage(imgRaw, 'Normalize')
    %
    % To turn the image into a binary image using a defined threshold 0.5
    % imgProcessed = ProcessImage(imgRaw, 'bw', 0.5)
    %
    % To remove any objects out of the defined size range, min 1, max 20
    % (requires binary image)
    % imgProcessed = ProcessImage(imgRaw,'remOutOfRange',1,20);
    %
    % To remove the borders of an image (requires binary image)
    % imgProcessed = ProcessImage(imgRaw,'remBorder');
    %
    % To check the roundness of the object detected using a threshold of
    % 0.1 to 1.5 (requires binary image)
    % imgProcessed = ProcessImage(imgRaw,'Roundness',handles);
    %
    % To remove any static objects between the current and last picture
    % (requires a previous image to have been made)
    % imgProcessed = ProcessImage(imgRaw,'Static', handles);

    switch strProcess
        case 'Normalize'
            % Stretch the image intensity to the lower/upper limits
            % (min->0, max->1)
            imgProcessed = (imgRaw - min(imgRaw(:))) ./ (max(imgRaw(:))-min(imgRaw(:)));
        case 'bw'
            % Change to binary image
            imgProcessed = im2bw(imgRaw,varargin{1});
        case 'remOutOfRange'
            % Remove objects smaller than min diameter and bigger than max
            % diameter
            
            % min
            imgRaw = ~(bwareaopen(~imgRaw, varargin{1}));
            
            % max
            intTooBig = varargin{2};
            imgNoBorder = ~(imclearborder(~imgRaw));
            objBound = bwboundaries(~imgNoBorder,'noholes');
            RProp = regionprops(~imgNoBorder, 'Area', 'Perimeter');
            for i = 1:length(objBound)
                if RProp(i).Area > intTooBig
                    imgRaw(objBound{i}(:,1),objBound{i}(:,2)) = 1;
                end
            end
            
            imgProcessed = imgRaw;
        case 'remBorder'
            % Remove anything touching the edge of the screen and
            % everything connected to itborders
            imgProcessed = ~(imclearborder(~imgRaw));
        case 'Roundness'
            % Check for roundness of the particle, small particles actually
            % have a roundness up to 1.3 (due to digitalization) so that's
            % why the setting is at 1.3.  I know this was originally meant
            % for bubbles but we don't have that problem here and this
            % isn't the best way to do it. But what this function will do
            % is remove any long scratch marks or fibers like before
            handles = varargin{1};
            objBound = bwboundaries(~imgRaw,'noholes');
            RProp = regionprops(~imgRaw, 'Area', 'Perimeter');
            for i = 1:length(objBound)
                isRound = 4 * pi * RProp(i).Area / RProp(i).Perimeter^2;
                if isRound < getBoxVal(handles.txtRoundLow) || isRound > getBoxVal(handles.txtRoundHigh)
                    imgRaw(objBound{i}(:,1),objBound{i}(:,2)) = 1;
                end
            end
            
            imgProcessed = imgRaw;
        case 'Static'
            % Compares the current image with the previous image and
            % removes any objects that are detected in the same location
            % (won't be a huge issue on imparing particle detection unless
            % you're above 10g/L or so
            handles = varargin{1};
            
            if get(handles.cbCrop,'Value')
                if isfield(handles,'imgCompareCropped')
                    imgOld = handles.imgCompareCropped;
                    imgNew = handles.imgRawCropped;

                    % Normalize and binary the image for better results
                    if get(handles.cbNormalize,'Value')
                        imgOld = ProcessImage(imgOld,'Normalize');
                        imgNew = ProcessImage(imgNew,'Normalize');
                    end
                    imgOld = im2bw(imgOld, getBoxVal(handles.txtThreshold));
                    imgNew = im2bw(imgNew, getBoxVal(handles.txtThreshold));

                    % Compare and erase static objects from the current image
                    binCompare = imgNew - imgOld;
                    imgRaw(binCompare == 0) = max(imgRaw(:));
                    imgProcessed = imgRaw;
                end
            else
                if isfield(handles,'imgCompare')
                    imgOld = handles.imgCompare;
                    imgNew = handles.imgRaw;
                    
                    % Normalize and binary the image for better results
                    if get(handles.cbNormalize,'Value')
                        imgOld = ProcessImage(imgOld,'Normalize');
                        imgNew = ProcessImage(imgNew,'Normalize');
                    end
                    imgOld = im2bw(imgOld, getBoxVal(handles.txtThreshold));
                    imgNew = im2bw(imgNew, getBoxVal(handles.txtThreshold));

                    % Compare and erase static objects from the current image
                    binCompare = imgNew - imgOld;
                    imgRaw(binCompare == 0) = max(imgRaw(:));
                    imgProcessed = imgRaw;
                end
            end
    end
    % If no image processing is actually done, return the old image
    if ~exist('imgProcessed','var')
        imgProcessed = imgRaw;
    end
end