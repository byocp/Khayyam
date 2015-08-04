function dblBoxVal = getBoxVal(hObject)
    % getBoxVal
    %
    % This function grabs the value in the specified textbox and outputs
    % its contents in double format
    %
    %
    % Syntax
    %
    % dblBoxVal = getBoxVal(hObject)
    %
    %
    % Description
    %
    % dblBoxVal = getBoxVal(hObject) gets the 'String' property of the
    % textbox, hObject, and returns the value in double format.  Characters
    % entered in the textbox will be returned as NaN.
    
    % The value of the textbox
    dblBoxVal = str2double(get(hObject,'String'));
end