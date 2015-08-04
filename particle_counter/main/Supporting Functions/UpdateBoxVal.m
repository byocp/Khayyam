function handles = UpdateBoxVal(hObject,handles)
    % UpdateBoxVal
    %
    % Saves the new value of the textbox to handles.Param.(txtbox) or
    % handles.ParamC.(txtbox) depending on if the image is currently
    % cropped or not.  handles is used to refer to the textbox handles.
    %
    %
    % Syntax
    %
    % handles = UpdateBoxVal(hObject,handles)
    %
    %
    % Description
    %
    % handles = UpdateBoxVal(hObject,handles) takes in the affected textbox
    % , hObject, and updates the corresponding Param or ParamC value with
    % its current 'String' property.
    
    % Update the appropriate Param
    if get(handles.cbCrop,'Value')
        handles.ParamC.(get(hObject,'Tag')) = getBoxVal(hObject);
    else
        handles.Param.(get(hObject,'Tag')) = getBoxVal(hObject);
    end
end