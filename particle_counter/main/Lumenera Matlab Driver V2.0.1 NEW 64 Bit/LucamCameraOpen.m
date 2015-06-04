function [output] = LucamCameraOpen(cameraNum)
% LucamCameraOpen - Connect to the Lumenera camera specified.
try
    LuDispatcher(-1, cameraNum);
    output = cameraNum;
catch
    output = -1;
    %errordlg(lasterr, 'Connect Error', 'modal');
end