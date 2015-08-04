% Update checkbox values to handles
function handles = UpdateCBValues(handles, strCBTag, binValue)
    % UpdateCBValues
    %
    % This function updates the checkbox values, used for toggling cbBinary
    %
    %
    % Syntax
    %
    % handles = UpdateCBValues(handles, strCBTag, binValue)
    %
    %
    % Description
    %
    % handles = UpdateCBValues(handles, strCBTag, binValue) stores the
    % state, binValue,of the checkbox, strCBTag, in the handles structure.
    
    handles.Param.(strCBTag) = binValue;
    handles.ParamC.(strCBTag) = binValue;
    handles.imgProcCB.(strCBTag) = binValue;
end