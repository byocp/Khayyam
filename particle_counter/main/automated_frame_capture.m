function output = automated_frame_capture(snapshot_exposure, gain)
%% This function set the minimal camera parameters using the API functions
% lucam_set_gain: 11.5
% lucam_set_snapshot_exposure: 0.5
% Two unused, useful Lucam API commands:
%   (a) LucamGetExposure(cam);
%   (b) LucamGetGain(cam);
%   (c) LucamCaptureSaveFrame(strcat('rawfr',i,'.bmp'),false,1);

%% Make Camera ready
% Set the number of camers
cam = 1;
% Open camera
camConnect = LucamCameraOpen(cam);

if camConnect ~= -1
    % Adjust level of gain
    LucamSetGain(gain, 1);
    % Set exposure
    LucamSetSnapshotExposure(snapshot_exposure, 1);
    % Take the first snap shot.
    raw_image = LucamTakeSnapshot(cam);
    output = raw_image;
    % Close camera.
    LucamCameraClose(cam);
else
    output = -1;
end

end
