function handles = CropUpdateFields(handles,intWidth,intHeight)
    % CropUpdateFields
    %
    % Update affected fields when cropping
    %
    %
    % Syntax
    %
    % handles = CropUpdateFields(handles,intWidth,intHeight)
    % 
    %
    % Description
    %
    % handles = CropUpdateFields(handles,intWidth,intHeight) updates the
    % Frame Width and Frame Height textboxes with intWidth and intHeight
    % respectively.  When undoing the cropping, intWidth and intHeight can
    % be omitted.  handles is used to refer to the textbox handles.

    if get(handles.cbCrop,'Value')
        % Update center point
        set(handles.txtCenterX,'String',floor(intWidth/2));
        set(handles.txtCenterY,'String',floor(intHeight/2));

        handles = UpdateBoxVal(handles.txtCenterX,handles);
        handles = UpdateBoxVal(handles.txtCenterY,handles);

        % Update capture frame
        set(handles.txtFrameWidth,'String',getBoxVal(handles.txtCropWidth))
        set(handles.txtFrameHeight,'String',getBoxVal(handles.txtCropHeight))
        set(handles.txtFrameVol,'String',getBoxVal(handles.txtCropWidth) * ...
                                         getBoxVal(handles.txtCropHeight) * ...
                                         getBoxVal(handles.txtFrameDepth))

        handles = UpdateBoxVal(handles.txtFrameWidth,handles);
        handles = UpdateBoxVal(handles.txtFrameHeight,handles);
        handles = UpdateBoxVal(handles.txtFrameVol,handles);
    else
        % Update center point
        set(handles.txtCenterX,'String',handles.Param.txtCenterX)
        set(handles.txtCenterY,'String',handles.Param.txtCenterY)

        % Update capture frame
        set(handles.txtFrameWidth,'String',handles.Param.txtFrameWidth)
        set(handles.txtFrameHeight,'String',handles.Param.txtFrameHeight)
        set(handles.txtFrameVol,'String',handles.Param.txtFrameVol)
    end
end