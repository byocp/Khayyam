function imgShow = ApplyImageProcessing(handles,imgShow,imgMinParticle,imgMaxParticle)
    % ApplyImageProcessing
    %
    % Performs the image processing based on the checkboxes checked, the
    % order that these go in MATTER, in that having one before the other
    % affects the outcome
    %
    %
    % Syntax
    %
    % imgShow =
    % ApplyImageProcessing(handles,imgShow,imgMinParticle,imgMaxParticle) 
    %
    %
    % Description
    %
    % imgShow =
    % ApplyImageProcessing(handles,imgShow,imgMinParticle,imgMaxParticle) 
    % returns imgShow as the processed image of the original imgShow based
    % on the image processing options selected.  imgMinParticle and
    % imgMaxParticle are used to determine the min/max area that is
    % considered a particle.
    
    if get(handles.cbNormalize,'Value')
        imgShow = ProcessImage(imgShow,'Normalize');
    end
    if get(handles.cbBinary,'Value')
        imgShow = ProcessImage(imgShow,'bw',getBoxVal(handles.txtThreshold));
    end
    if get(handles.cbRemoveBorder,'Value')
        imgShow = ProcessImage(imgShow,'remBorder');
    end
    if get(handles.cbFilterStatic,'Value')
        imgShow = ProcessImage(imgShow,'Static', handles);
    end
    if get(handles.cbOutOfRange,'Value')
        imgShow = ProcessImage(imgShow,'remOutOfRange',sum(imgMinParticle(:))*2,sum(imgMaxParticle(:))*2);
    end
    if get(handles.cbRoundness,'Value')
        imgShow = ProcessImage(imgShow,'Roundness',handles);
    end
end